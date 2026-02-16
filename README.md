# MusicTestApp

Apple 멀티플랫폼 음악 앱 — SwiftUI로 구현한 iOS / iPadOS / macOS 공용 프로젝트입니다.

## 지원 플랫폼

| 플랫폼 | 네비게이션 패턴 |
|--------|----------------|
| iOS / iPadOS | `TabView` + `NavigationStack` (하단 탭바) |
| macOS | `NavigationSplitView` (사이드바) |

## 탭 구성

| 탭 | 아이콘 | 설명 |
|----|--------|------|
| 음악 리스트 | `music.note.list` | 전체 음악 목록 |
| 플레이리스트 | `music.note.tv` | 플레이리스트 관리 |
| 파일 | `folder` | 음악 파일 브라우저 |
| 내 정보 | `person.crop.circle` | 계정 및 설정 |

## 프로젝트 구조

```
MusicTestApp/
├── MusicTestAppApp.swift         # 앱 진입점
├── ContentView.swift              # 루트 뷰 (MainTabView 위임)
├── Navigation/
│   └── MainTabView.swift          # 플랫폼 분기 네비게이션
└── Features/
    ├── MusicList/MusicListView.swift
    ├── Playlist/PlaylistView.swift
    ├── Files/FilesView.swift
    └── Profile/ProfileView.swift
```

## 요구사항

- Xcode 15+
- iOS 17+ / macOS 14+
- Swift 5.9+
