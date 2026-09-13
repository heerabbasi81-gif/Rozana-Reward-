onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Task started! +10 points'),
    ),
  );
},
