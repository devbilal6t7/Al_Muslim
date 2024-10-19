import 'package:flutter/material.dart';

import '../../consts/muslim_colors.dart';

// Define your custom MuslimColors class


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: MuslimColors.mainColor,
        foregroundColor: Colors.white,// Use the Muslim main color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildSectionTitle('1. Information We Collect'),
            _buildParagraph(
                'We may collect and process the following types of data when you use our app:'),
            _buildListItem(
                'Location Data: The app may access your location to help you accurately find the Qibla direction. This data is only used within the app and is not stored or shared with third parties.'),
            _buildListItem(
                'Usage Data: We may collect non-personal information related to how you interact with the app, such as the features you use, time spent on the app, etc., to improve the app\'s functionality and user experience.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('2. How We Use Your Information'),
            _buildListItem(
                'Location Data: Your location is used solely to help you find the Qibla direction based on your geographical position.'),
            _buildListItem(
                'App Features: We use your interaction data to provide core functionalities of the app, such as the Qibla Finder, Quranic Surahs, 99 Names of Allah, Hadith of the Day, and more.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('3. Third-Party Services'),
            _buildParagraph(
                'We do not share your personal data with any third-party services unless required by law. The app does not use third-party analytics or advertising networks that collect personal information.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('4. Data Security'),
            _buildParagraph(
                'We are committed to protecting your information. We use commercially reasonable safeguards to preserve the integrity and security of your data. However, no system is entirely secure, and we cannot guarantee complete security of your data.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('5. Your Choices'),
            _buildParagraph(
                'You can disable location services at any time through your device settings. However, please note that some features, such as the Qibla Finder, may not function properly without access to your location.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('6. Children’s Privacy'),
            _buildParagraph(
                'This app is not intended for use by anyone under the age of 13. We do not knowingly collect personal information from children under 13.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('7. Changes to This Policy'),
            _buildParagraph(
                'We may update this Privacy Policy from time to time. Any changes will be posted within the app, and the updated version will be effective as of the posted date.'),
            const SizedBox(height: 16.0),
            _buildSectionTitle('8. Contact Us'),
            _buildParagraph(
                'If you have any questions or concerns about this Privacy Policy or our practices, please contact us at:'),
            _buildContactDetails('Email: dev.bilal.6t7@gmail.com'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: MuslimColors.mainColor, // Main color for section titles
      ),
    );
  }

  Widget _buildParagraph(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }

  Widget _buildListItem(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetails(String contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        contact,
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }
}

