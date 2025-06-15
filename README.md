<div align="center">
  <a href="https://github.com/bloomwayz/hapticky">
    <img src="https://capsule-render.vercel.app/api?type=venom&height=300&text=눈%20감고도%20쓰겠다&textBg=false&desc=저시력자를%20위한%20햅틱%20키보드&descAlignY=70">
  </a>

  <p align="center">
    <img src="https://img.shields.io/badge/iOS-1A1A1A?style=for-the-badge&logo=apple&logoColor=white"/>
    <img src="https://img.shields.io/badge/SwiftUI-F05138?style=for-the-badge&logo=swift&logoColor=white"/>
    <img src="https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=uikit&logoColor=white"/>
    </div>
  </p>
</div>
<br></br>

## 🧐 프로젝트 소개

- 이 프로젝트는 2025학년도 1학기 서울대학교 '인간컴퓨터상호작용' 강의의 기말 과제로 제출된 것입니다.

- iPhone 쿼티 키보드의 **각 글쇠에 햅틱 피드백을 부여**하여 저시력자 및 노안 사용자의 입력 경험을 개선하는 것을 목표로 합니다.

- 아래 링크에서 보고서와 포스터를 열람할 수 있습니다.
    - [중간 보고서](assets/midterm_report_team4.pdf)
    - [최종 보고서](assets/final_report_team4.pdf)
    - [발표 포스터](assets/poster_team4.pdf)
<br></br>

## 📲 실행 방법

1. 다음 명령어를 실행하여 이 저장소를 복제합니다.

    ```sh
    $ git clone https://github.com/bloomwayz/hapticky.git
    ```

    또는 **XCode > Clone Git Repository...** 메뉴에서 다음 URL을 입력하여 이 저장소를 복제할 수도 있습니다.

    ```
    https://github.com/bloomwayz/hapticky.git
    ```

2. Xcode에서 `Group4` 프로젝트를 열고, Signing & Capabilities 탭에서 서명 정보를 설정합니다.

3. 설정이 완료되면 ⌘R를 눌러 앱을 실행할 수 있습니다.
<br></br>


## ⌨️ 기능 안내

### 로마자 입력 모드

- 알파벳 26자를 포함하여 쉼표와 물음표, 백스페이스 키, 시프트 키, 스페이스 키, 엔터 키가 있습니다.

- 각 글쇠에는 고유한 햅틱 피드백이 할당되어 있습니다.

- 글쇠에 손가락을 가져다 대면 진동이 재생되고, 손을 떼면 입력됩니다.

- 손가락을 떼지 않은 상태에서 다른 글쇠로 손가락을 움직이면 입력을 정정할 수 있고, 손가락을 떼는 순간 입력이 확정됩니다.

### 한글 입력 모드

- 우측 상단의 `한글` 버튼을 터치하여 입력 모드를 전환할 수 있습니다.

- 한글 26자를 포함하여 마침표, 백스페이스 키, 시프트 키, 스페이스 키, 엔터 키가 있습니다.

- 각 글쇠에는 햅틱 피드백이 할당되어 있습니다. 이들 패턴은 인접한 글쇠들과 구별되도록 할당하였습니다.
<br></br>


## 🔗 같이 보기

- [summerBreeze2007/haptic-keyboard-for-the-visually-impaired](https://github.com/summerBreeze2007/haptic-keyboard-for-the-visually-impaired)
<br></br>

**2025-1 인간컴퓨터상호작용 4조** \
김교헌 김태윤 박준영 전수빈
