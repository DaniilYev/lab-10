import &#39;package:flutter/material.dart&#39;;

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: &#39;Flutter Navigation Demo&#39;,
initialRoute: &#39;/&#39;,
routes: {
&#39;/&#39;: (context) =&gt; const HomeScreen(),
&#39;/second&#39;: (context) =&gt; const SecondScreen(),
&#39;/third&#39;: (context) =&gt; const ThirdScreen(),
},
);
}
}

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text(&#39;Home Screen&#39;)),

body: Center(
child: SingleChildScrollView(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ElevatedButton(
onPressed: () =&gt; Navigator.push(
context,
MaterialPageRoute(builder: (context) =&gt; const SecondScreen()),
),
child: const Text(&#39;Push to Second&#39;),
),
ElevatedButton(
onPressed: () =&gt; Navigator.pushNamed(context, &#39;/second&#39;),
child: const Text(&#39;PushNamed to Second&#39;),
),
ElevatedButton(
onPressed: () =&gt; Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (context) =&gt; const SecondScreen()),
),
child: const Text(&#39;PushReplacement to Second&#39;),
),
ElevatedButton(
onPressed: () =&gt; Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (context) =&gt; const SecondScreen()),
(Route&lt;dynamic&gt; route) =&gt; false,
),
child: const Text(&#39;PushAndRemoveUntil to Second&#39;),

),
ElevatedButton(
onPressed: () =&gt; Navigator.pushNamedAndRemoveUntil(
context,
&#39;/second&#39;,
(Route&lt;dynamic&gt; route) =&gt; false,
),
child: const Text(&#39;PushNamedAndRemoveUntil to Second&#39;),
),
],
),
),
),
);
}
}

class SecondScreen extends StatelessWidget {
const SecondScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text(&#39;Second Screen&#39;)),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ElevatedButton(
onPressed: () =&gt; Navigator.pop(context),

child: const Text(&#39;Pop to Previous&#39;),
),
ElevatedButton(
onPressed: () =&gt; Navigator.popAndPushNamed(context, &#39;/third&#39;),
child: const Text(&#39;PopAndPushNamed to Third&#39;),
),
],
),
),
);
}
}

class ThirdScreen extends StatelessWidget {
const ThirdScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text(&#39;Third Screen&#39;)),
body: Center(
child: ElevatedButton(
onPressed: () =&gt; Navigator.pop(context),
child: const Text(&#39;Back to Previous&#39;),
),
),
);
}
}