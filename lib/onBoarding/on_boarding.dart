import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  // 페이지 컨트롤러 선언
  final PageController _pageController = PageController();

  // 현재 페이지 인덱스
  int _currentPage = 0;

  // 온보딩 데이터
  final List<OnBoardingData> _pages = [
    OnBoardingData(
      title: 'Color Walk에 대하여\n알고 있나요?',
      description: '',
      image: 'assets/images/onboarding/rainbow.png',
    ),
    OnBoardingData(
      title: '이는 색을 찾아서\n사진으로 찍는 활동이에요.',
      description: '',
      image: 'assets/images/onboarding/camera.png',
    ),
    OnBoardingData(
      title: '주의력 회복,\n스트레스 완화,\n창의성 향상에 도움이 되죠.',
      description: '',
      image: 'assets/images/onboarding/pallete.png',
    ),
    OnBoardingData(
      title: 'Colora에서\n친구들과 함께\n오늘의 색을 찾아보세요!',
      description: '',
      image: 'assets/images/onboarding/friends.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 페이지 변경 시 호출되는 함수
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 로고 이미지
          Positioned(
            top: MediaQuery.of(context).padding.top + 40,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/logo/logo.png', height: 40),
          ),
          // 페이지 뷰
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return OnBoardingContent(data: _pages[index]);
            },
          ),

          // 페이지 인디케이터
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.pinkAccent,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                ),
              ),
            ),
          ),

          // 시작하기 버튼 (마지막 페이지에서만 표시)
          if (_currentPage == _pages.length - 1)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 메인 페이지로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Google 계정으로 시작하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// 온보딩 데이터 모델
class OnBoardingData {
  final String title;
  final String description;
  final String image;

  OnBoardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

// 온보딩 컨텐츠 위젯
class OnBoardingContent extends StatelessWidget {
  final OnBoardingData data;

  const OnBoardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image, height: 200),
          const SizedBox(height: 40),
          Text(
            data.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          if (data.description.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              data.description,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
