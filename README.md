# SSAC_9_LotteryNumber
동행복권 API를 통해 회차별 로또 당첨 번호를 보여주는 앱입니다.

# Assigment
- [x] 참조이미지와 같이 화면 구성하기
- [x] textField클릭 시 pickerView를 띄워 로또 추첨 회차를 선택합니다.
- [x] Alamofire를 통해 동행복권 api의 JSON 형식으로 된 데이터를 가져왔습니다.
- [x] SwiftyJSON을 통해 JSON 형식의 데이터에서 원하는 정보를 파싱하여 로또 번호 Label들에 뿌려주었습니다.
- [ ] 이미 검색한 회차정보는 userDefaults에 저장합니다.

# 추가 구현 사항 
- [x] pickerView에서 회차정보 숫자가 가장 큰 순서로 뜨도로 정렬하였습니다.
- [x] 앱 최초 실행 시, 가자 최근 회차 정보를 띄우도로 하였습니다.
- [x] 오늘 날짜를 기준으로 가장 최신 회차 정보를 가져오는 로직을 구현하였습니다.
- [x] 네트워크 통신 시, progress indicator를 띄워주었습니다.

|참조 이미지||구현 앱 UI|
|:---:|:---:|:--:|
|<img src="https://user-images.githubusercontent.com/59866819/139908999-b8b0411f-51c2-4516-bbea-69f03cdfad5c.png" />|<img width="120" src="https://user-images.githubusercontent.com/59866819/135194858-4405d3a0-0de3-4ca6-a594-3b08e0ae951b.png" />|<img width="65%" src="https://user-images.githubusercontent.com/59866819/139909007-e389b8bb-ab9d-485e-9e86-1a5ba2d449e4.png" />|

# 실행 영상
<p align="center"><img width="30%" src="https://user-images.githubusercontent.com/59866819/139908806-ad19f5f6-f952-472d-a1b4-aad73abc76ba.mp4" /></p>
