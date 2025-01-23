import 'package:abugida/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_provider.dart';
// Import the Job model

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ongoing'),
            Tab(text: 'Not Started'),
            Tab(text: 'Requests'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          JobList(status: 'Ongoing'),
          JobList(status: 'Not Started'),
          JobList(status: 'Requests'),
          JobList(status: 'Completed'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddJobDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddJobDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Job'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Enter job title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final jobProvider =
                      Provider.of<JobProvider>(context, listen: false);
                  final newJob = Job(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: titleController.text,
                    status: "Not Started",
                  );
                  jobProvider.addJob(newJob);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class JobList extends StatelessWidget {
  final String status;

  const JobList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    final jobs = jobProvider.jobs.where((job) => job.status == status).toList();

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return JobItem(job: job);
      },
    );
  }
}

class JobItem extends StatelessWidget {
  final Job job;

  const JobItem({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(job.title),
        subtitle: Text("Status: ${job.status}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (job.status == "Requests")
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  jobProvider.updateJobStatus(job.id, "Ongoing");
                },
              ),
            if (job.status == "Requests")
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  jobProvider.updateJobStatus(job.id, "Rejected");
                },
              ),
            if (job.status == "Ongoing")
              IconButton(
                icon: const Icon(Icons.done, color: Colors.blue),
                onPressed: () {
                  jobProvider.updateJobStatus(job.id, "Completed");
                },
              ),
            if (job.status == "Ongoing")
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.orange),
                onPressed: () {
                  jobProvider.updateJobStatus(job.id, "Not Started");
                },
              ),
          ],
        ),
      ),
    );
  }
}
