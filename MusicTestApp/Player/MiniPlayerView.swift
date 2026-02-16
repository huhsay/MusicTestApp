//
//  MiniPlayerView.swift
//  MusicTestApp
//
//  탭바 위에 고정되는 미니 플레이어
//  - 이전곡 / -5초 / 재생·정지 / +5초 / 다음곡 버튼
//  - 위로 드래그하면 FullPlayerView 시트로 전환
//

import SwiftUI

struct MiniPlayerView: View {

    private let player = MusicPlayerManager.shared

    // MARK: 드래그 상태
    @State private var dragOffset: CGFloat = 0
    @State private var showFullPlayer: Bool = false

    // 드래그 임계값: 이 이상 위로 당기면 풀플레이어 오픈
    private let dragThreshold: CGFloat = -60

    var body: some View {
        VStack(spacing: 0) {
            // 드래그 핸들
            Capsule()
                .fill(Color.secondary.opacity(0.4))
                .frame(width: 36, height: 4)
                .padding(.top, 8)

            // 곡 정보 + 컨트롤
            VStack(spacing: 6) {
                // 곡 제목 / 아티스트
                VStack(spacing: 2) {
                    Text(player.currentItem?.title ?? "재생 중인 곡 없음")
                        .font(.subheadline.bold())
                        .lineLimit(1)
                    Text(player.currentItem?.artist ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .padding(.top, 4)

                // 재생 진행바
                ProgressView(value: progressValue)
                    .tint(.primary)
                    .padding(.horizontal, 16)

                // 컨트롤 버튼
                HStack(spacing: 0) {
                    // 이전 곡
                    controlButton(
                        icon: "backward.end.fill",
                        size: 20
                    ) {
                        player.playPrevious()
                    }

                    Spacer()

                    // -5초
                    controlButton(
                        icon: "gobackward.5",
                        size: 22
                    ) {
                        player.seek(by: -5)
                    }

                    Spacer()

                    // 재생 / 정지
                    controlButton(
                        icon: player.isPlaying ? "pause.circle.fill" : "play.circle.fill",
                        size: 40,
                        isPrimary: true
                    ) {
                        player.togglePlayPause()
                    }

                    Spacer()

                    // +5초
                    controlButton(
                        icon: "goforward.5",
                        size: 22
                    ) {
                        player.seek(by: 5)
                    }

                    Spacer()

                    // 다음 곡
                    controlButton(
                        icon: "forward.end.fill",
                        size: 20
                    ) {
                        player.playNext()
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 8)
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.12), radius: 8, y: -2)
        .offset(y: dragOffset)
        // 드래그 제스처
        .gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { value in
                    // 위로만 드래그 허용
                    if value.translation.height < 0 {
                        dragOffset = value.translation.height * 0.4
                    }
                }
                .onEnded { value in
                    if value.translation.height < dragThreshold {
                        // 임계값 초과 → 풀플레이어 오픈
                        showFullPlayer = true
                    }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        dragOffset = 0
                    }
                }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: player.isPlaying)
        .sheet(isPresented: $showFullPlayer) {
            FullPlayerView()
        }
        .padding(.horizontal, 8)
    }

    // MARK: - 진행바 값 (0.0 ~ 1.0)
    private var progressValue: Double {
        guard player.duration > 0 else { return 0 }
        return player.currentTime / player.duration
    }

    // MARK: - 버튼 빌더
    @ViewBuilder
    private func controlButton(
        icon: String,
        size: CGFloat,
        isPrimary: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .foregroundStyle(isPrimary ? .primary : .secondary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        Spacer()
        MiniPlayerView()
    }
    .background(Color(.systemGroupedBackground))
}
