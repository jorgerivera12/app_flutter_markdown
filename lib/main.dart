import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                ...listMarkdownStrings.map((e) => ContainerMarkdown(text: e))
              ],
            )));
  }
}

class ContainerMarkdown extends StatelessWidget {
  final String text;
  ContainerMarkdown({super.key, required this.text});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Markdown(
        shrinkWrap: true,
        selectable: true,
        controller: _scrollController,
        data: text,
        extensionSet: md.ExtensionSet(
          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
          <md.InlineSyntax>[
            md.EmojiSyntax(),
            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
          ],
        ),
        onTapLink: (text, href, title) {
          if (href != null) {
            launchInBrowserView(href);
          }
        },
      ),
    );
  }
}

Future<void> launchInBrowserView(String url) async {
  Uri urlUri = Uri.parse(url);
  if (!await launchUrl(urlUri, mode: LaunchMode.inAppBrowserView)) {
    throw Exception('Could not launch $url');
  }
}

List<String> listMarkdownStrings = [
  'My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  '[OpenAI](https://openai.com/) es una organización de investigación dedicada a avanzar en la inteligencia artificial de manera segura y responsable. Han desarrollado varios modelos de lenguaje avanzados, como GPT (Generative Pre-trained Transformer),[OpenAI](https://openai.com/) que son capaces de realizar una amplia gama de tareas de procesamiento de lenguaje natural. Visita su sitio web para obtener más información sobre sus proyectos y contribuciones a la IA.',
  'My [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  '[OpenAI](https://openai.com/) es una organización de investigación dedicada a avanzar en la inteligencia artificial de manera segura y responsable. Han desarrollado varios modelos de lenguaje avanzados, como GPT (Generative Pre-trained Transformer),[OpenAI](https://openai.com/) que son capaces de realizar una amplia gama de tareas de procesamiento de lenguaje natural. Visita su sitio web para obtener más información sobre sus proyectos y contribuciones a la IA.',
  'My [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  'My favorite [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). search engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
  '[Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). My favorite search [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy"). engine is [Duck Duck Go](https://duckduckgo.com "The best search engine for privacy").',
];
