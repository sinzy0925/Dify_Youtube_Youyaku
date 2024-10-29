from youtubesearchpython import VideosSearch
from langdetect import detect   
import re
import json

def main(search_query,limit0):

    def get_many_videos(search_query, limit=100):
        videos_search = VideosSearch(search_query, limit=limit)
        results = []
        
        while len(results) < limit:
            batch = videos_search.result()["result"]
            results.extend(batch)
            
            if not videos_search.next():
                break
        
        return results[:limit]

    def determine_language(text):
        try:
            lang = detect(text)
            return lang if lang in ['ja', 'en'] else 'unknown'
        except:
            return "unknown"

    # 検索したいキーワードを指定
    #search_query = "dify ai"

    # 検索を実行
    #videos_search = VideosSearch(search_query, limit = 1000)  # より多くの結果を取得
    results = get_many_videos(search_query, limit=100)

    # 結果を取得
    #results = videos_search.result()["result"]

    # publishedTimeに年が含まれていないかチェックする関数
    def is_recent_video(published_time):
        if published_time is None:
            return False
        return "year" not in published_time.lower() and "years" not in published_time.lower()

    # タイトルに日本語が含まれているかチェックする関数
    def contains_japanese(text):
        pattern = r'[ぁ-んァ-ン\s.,!?()[\]{}:;"\'`@#$%^&*_+=|~<>-]'
        return bool(re.search(pattern, text))
    def contains_english(text):
        pattern = r'[a-zA-Z\s.,!?()[\]{}:;"\'`@#$%^&*_+=|~<>-]'
        return bool(re.search(pattern, text))
    from langdetect import detect

    def determine_language(text):
        try:
            lang = detect(text)
            return lang if lang in ['ja', 'en'] else 'unknown'
        except:
            return "unknown"

    # フィルタリング
    filtered_results = [
        video for video in results 
        if 'publishedTime' in video and is_recent_video(video['publishedTime'])
    ]

    # sorted_resultsの各要素に対してlanguageキーを追加
    for video in filtered_results:
        try:
            video['language'] = determine_language(video['title'])
        except Exception as e:
            print(f"言語の判定中にエラーが発生しました: {e}")
            video['language'] = 'Unknown'

    # 言語が'unknown'でないエントリーのみをフィルタリング
    filtered_results = [result for result in filtered_results if result.get('language') != 'unknown']


    # viewCountでソート
    sorted_results = sorted(filtered_results, key=lambda x: int(x['viewCount']['text'].split()[0].replace(',', '')), reverse=True)
    list_results = list(sorted_results)

    array_results = []
    for result in sorted_results:
        array_results.append({'title': result['title'],'videoId': result['id'],'viewCount': result['viewCount'],'publishedTime': result['publishedTime'],'channel': result['channel'],'language': result['language']})

    print(array_results[limit0])

    return {
        "result": json.dumps(array_results[limit0], ensure_ascii=False)
    }

main("dify ai",0)
