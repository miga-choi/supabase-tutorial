import "package:flutter/material.dart";
import "package:flutter_supabase/Config.dart";
import "package:supabase_flutter/supabase_flutter.dart";

void main() async {
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  void fetchData() async {
    final data = await supabase.from("countries").select("name");
    print(data);
  }

  void insertData() async {
    final data = await supabase.from("countries").insert({"name": "Japan"});
    print(data);
  }

  void updateData() async {
    final data =
        await supabase.from("countries").update({"name": "China"}).eq("id", 5);
    print(data);
  }

  void upsertData() async {
    final data = await supabase
        .from("countries")
        .upsert({"id": 1, "name": "Albania"}).select();
    print(data);
  }

  void deleteData() async {
    final data = await supabase.from("countries").delete().eq("id", 1);
    print(data);
  }

  void columnIsEqualToAValue() async {
    final data = await supabase.from("countries").select().eq("name", "Japan");
    print(data);
  }

  void columnIsNotEqualToAValue() async {
    final data = await supabase
        .from("countries")
        .select("id, name")
        .neq("name", "Japan");
    print(data);
  }

  void columnIsGreaterThanAValue() async {
    final data = await supabase.from("countries").select().gt("id", 2);
    print(data);
  }

  void columnIsGreaterThanOrEqualToAValue() async {
    final data = await supabase.from("countries").select().gte("id", 2);
    print(data);
  }

  void columnIsLessThanAValue() async {
    final data = await supabase.from("countries").select().lt("id", 2);
    print(data);
  }

  void columnIsLessThanOrEqualToAValue() async {
    final data = await supabase.from("countries").select().lte("id", 2);
    print(data);
  }

  void columnMatchesAPattern() async {
    final data =
        await supabase.from("countries").select().like("name", "%apa%");
    print(data);
  }

  void columnMatchesACaseInsensitivePattern() async {
    final data =
        await supabase.from("countries").select().ilike("name", "%aPa%");
    print(data);
  }

  void columnIsAValue() async {
    final data =
        await supabase.from("countries").select().isFilter("name", null);
    print(data);
  }

  void columnIsInAnArray() async {
    final data = await supabase
        .from("countries")
        .select()
        .inFilter("name", ["Korea", "Japan"]);
    print(data);
  }

  void columnContainsEveryElementInAValue() async {
    final data = await supabase
        .from("issues")
        .select()
        .contains("tags", ["is:open", "priority:low"]);
    print(data);
  }

  void containedByValue() async {
    final data = await supabase
        .from("classes")
        .select("name")
        .containedBy("days", ["monday", "tuesday", "wednesday", "friday"]);
    print(data);
  }

  void greaterThanARange() async {
    final data = await supabase
        .from("reservations")
        .select()
        .rangeGt("during", "[2000-01-02 08:00, 2000-01-02 09:00)");
    print(data);
  }

  void greaterThanOrEqualToARange() async {
    final data = await supabase
        .from("reservations")
        .select()
        .rangeGte("during", "[2000-01-02 08:30, 2000-01-02 09:30)");
    print(data);
  }

  void lessThanARange() async {
    final data = await supabase
        .from("reservations")
        .select()
        .rangeLt("during", "[2000-01-01 15:00, 2000-01-01 16:00)");
    print(data);
  }

  void lessThanOrEqualToARange() async {
    final data = await supabase
        .from("reservations")
        .select()
        .rangeLte("during", "[2000-01-01 15:00, 2000-01-01 16:00)");
    print(data);
  }

  void mutuallyExclusiveToARange() async {
    final data = await supabase
        .from("reservations")
        .select()
        .rangeAdjacent("during", "[2000-01-01 12:00, 2000-01-01 13:00)");
    print(data);
  }

  void withACommonElement() async {
    final data = await supabase
        .from("issues")
        .select("title")
        .overlaps("tags", ["is:closed", "severity:high"]);
    print(data);
  }

  void matchAString() async {
    final data = await supabase
        .from("texts")
        .select("content")
        .textSearch("content", "\"eggs\" & \"ham\"", config: "english");
    print(data);
  }

  void matchAnAssociatedValue() async {
    final data = await supabase
        .from("countries")
        .select()
        .match({"id": 11, "name": "Japan"});
    print(data);
  }

  void doNotMatchTheFilter() async {
    final data =
        await supabase.from("countries").select().not("name", "is", null);
    print(data);
  }

  void matchAtLeastOneFilter() async {
    final data = await supabase
        .from("countries")
        .select("id, name")
        .or("id.eq.11,name.eq.Korea");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: matchAtLeastOneFilter,
      ),
    );
  }
}
