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
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select("name");
    print(data);
  }

  void insertData() async {
    final data = await supabase.from("countries").insert({"name": "Japan"});
    print(data);
  }

  void updateData() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .update({"name": "China"})
        .eq("id", 5)
        .select();
    print(data);
  }

  void upsertData() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .upsert({"id": 1, "name": "Albania"}).select();
    print(data);
  }

  void deleteData() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").delete().eq("id", 1).select();
    print(data);
  }

  void columnIsEqualToAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().eq("name", "Japan");
    print(data);
  }

  void columnIsNotEqualToAValue() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select("id, name")
        .neq("name", "Japan");
    print(data);
  }

  void columnIsGreaterThanAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().gt("id", 2);
    print(data);
  }

  void columnIsGreaterThanOrEqualToAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().gte("id", 2);
    print(data);
  }

  void columnIsLessThanAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().lt("id", 2);
    print(data);
  }

  void columnIsLessThanOrEqualToAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().lte("id", 2);
    print(data);
  }

  void columnMatchesAPattern() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().like("name", "%apa%");
    print(data);
  }

  void columnMatchesACaseInsensitivePattern() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().ilike("name", "%aPa%");
    print(data);
  }

  void columnIsAValue() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().isFilter("name", null);
    print(data);
  }

  void columnIsInAnArray() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select()
        .inFilter("name", ["Korea", "Japan"]);
    print(data);
  }

  void columnContainsEveryElementInAValue() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("issues")
        .select()
        .contains("tags", ["is:open", "priority:low"]);
    print(data);
  }

  void containedByValue() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("classes")
        .select("name")
        .containedBy("days", ["monday", "tuesday", "wednesday", "friday"]);
    print(data);
  }

  void greaterThanARange() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("reservations")
        .select()
        .rangeGt("during", "[2000-01-02 08:00, 2000-01-02 09:00)");
    print(data);
  }

  void greaterThanOrEqualToARange() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("reservations")
        .select()
        .rangeGte("during", "[2000-01-02 08:30, 2000-01-02 09:30)");
    print(data);
  }

  void lessThanARange() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("reservations")
        .select()
        .rangeLt("during", "[2000-01-01 15:00, 2000-01-01 16:00)");
    print(data);
  }

  void lessThanOrEqualToARange() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("reservations")
        .select()
        .rangeLte("during", "[2000-01-01 15:00, 2000-01-01 16:00)");
    print(data);
  }

  void mutuallyExclusiveToARange() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("reservations")
        .select()
        .rangeAdjacent("during", "[2000-01-01 12:00, 2000-01-01 13:00)");
    print(data);
  }

  void withACommonElement() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("issues")
        .select("title")
        .overlaps("tags", ["is:closed", "severity:high"]);
    print(data);
  }

  void matchAString() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("texts")
        .select("content")
        .textSearch("content", "\"eggs\" & \"ham\"", config: "english");
    print(data);
  }

  void matchAnAssociatedValue() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select()
        .match({"id": 11, "name": "Japan"});
    print(data);
  }

  void doNotMatchTheFilter() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select().not("name", "is", null);
    print(data);
  }

  void matchAtLeastOneFilter() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select("id, name")
        .or("id.eq.11,name.eq.Korea");
    print(data);
  }

  void matchTheFilter() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select()
        .filter("name", "in", "(\"Korea\",\"Japan\")");
    print(data);
  }

  void returnDataAfterInserting() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .upsert({"id": 1, "name": "Algeria"}).select();
    print(data);
  }

  void orderTheResults() async {
    final List<Map<String, dynamic>> data = await supabase
        .from("countries")
        .select("id, name")
        .order("id", ascending: false);
    print(data);
  }

  void limitTheNumberOfRowsReturned() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select("name").limit(1);
    print(data);
  }

  void limitTheQueryToARange() async {
    final List<Map<String, dynamic>> data =
        await supabase.from("countries").select("name").range(0, 1);
    print(data);
  }

  void retrieveOneRowOfData() async {
    final Map<String, dynamic> data =
        await supabase.from("countries").select("name").limit(1).single();
    print(data);
  }

  void retrieveZeroOrOneRowOfData() async {
    final Map<String, dynamic>? data = await supabase
        .from("countries")
        .select()
        .eq("name", "Singapore")
        .maybeSingle();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: retrieveZeroOrOneRowOfData,
      ),
    );
  }
}
