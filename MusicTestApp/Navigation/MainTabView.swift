//
//  MainTabView.swift
//  MusicTestApp
//
//  멀티플랫폼 네비게이션 루트 뷰
//  - iOS / iPadOS : TabView (하단 탭바) + MiniPlayer 오버레이
//  - macOS        : NavigationSplitView (사이드바)
//

import SwiftUI

// MARK: - 탭 항목 정의

enum AppTab: Int, CaseIterable, Identifiable {
    case musicList
    case playlist
    case files
    case profile

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .musicList: return "음악 리스트"
        case .playlist:  return "플레이리스트"
        case .files:     return "파일"
        case .profile:   return "내 정보"
        }
    }

    var systemImage: String {
        switch self {
        case .musicList: return "music.note.list"
        case .playlist:  return "music.note.tv"
        case .files:     return "folder"
        case .profile:   return "person.crop.circle"
        }
    }
}

// MARK: - 플랫폼 분기 진입점

struct MainTabView: View {
    @State private var selectedTab: AppTab = .musicList

    var body: some View {
#if os(macOS)
        MacSidebarView(selectedTab: $selectedTab)
#else
        IOSTabView(selectedTab: $selectedTab)
#endif
    }
}

// MARK: - iOS / iPadOS TabView + MiniPlayer 오버레이

#if !os(macOS)
struct IOSTabView: View {
    @Binding var selectedTab: AppTab
    private let player = MusicPlayerManager.shared

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(AppTab.allCases) { tab in
                    NavigationStack {
                        tabDestination(for: tab)
                            .navigationTitle(tab.title)
                    }
                    // 미니 플레이어가 보일 때 탭바 위 여백 확보
                    .safeAreaInset(edge: .bottom) {
                        if player.isMiniPlayerVisible {
                            Color.clear.frame(height: 100)
                        }
                    }
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
                }
            }

            // 미니 플레이어 — 탭바 바로 위에 오버레이
            if player.isMiniPlayerVisible {
                MiniPlayerView()
                    .padding(.bottom, 50) // 탭바 높이만큼 위로
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: player.isMiniPlayerVisible)
    }
}
#endif

// MARK: - macOS NavigationSplitView

#if os(macOS)
struct MacSidebarView: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        NavigationSplitView {
            List(AppTab.allCases, selection: $selectedTab) { tab in
                Label(tab.title, systemImage: tab.systemImage)
                    .tag(tab)
            }
            .navigationTitle("MusicTestApp")
            .listStyle(.sidebar)
        } detail: {
            NavigationStack {
                tabDestination(for: selectedTab)
                    .navigationTitle(selectedTab.title)
            }
        }
    }
}
#endif

// MARK: - 탭별 목적지 뷰 라우터

@ViewBuilder
func tabDestination(for tab: AppTab) -> some View {
    switch tab {
    case .musicList: MusicListView()
    case .playlist:  PlaylistView()
    case .files:     FilesView()
    case .profile:   ProfileView()
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
}
