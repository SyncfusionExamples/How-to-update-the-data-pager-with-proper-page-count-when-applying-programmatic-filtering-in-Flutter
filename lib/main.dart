import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: const MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.

class MyHomePage extends StatefulWidget {
  /// Creates the home page.

  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

int _rowsPerPage = 15;

const double _dataPagerHeight = 60.0;

List<Employee> _pageEmployee = [];

class _MyHomePageState extends State<MyHomePage> {
  late EmployeeDataSource employeeDataSource;
  double pageCount = 0;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageEmployee = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: _pageEmployee);
    _updatePageCount();
  }

  // To update the DataPager's page count while filtering the rows.
  void _updatePageCount() {
    final rowsCount = employeeDataSource.filterConditions.isNotEmpty
        ? employeeDataSource.effectiveRows.length
        : employeeDataSource._employeeRows.length;
    pageCount = (rowsCount / _rowsPerPage).ceil().toDouble();
  }

  Widget searchField() {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          employeeDataSource.clearFilters(columnName: 'name');
          if (value.isNotEmpty &&
              _pageEmployee.any((employee) =>
                  employee.name.toLowerCase() == value.toLowerCase())) {
            employeeDataSource.addFilter(
                'name',
                FilterCondition(
                    type: FilterType.contains,
                    filterBehavior: FilterBehavior.stringDataType,
                    value: value));
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              // Need to update the page count.
              _updatePageCount();
            });
          });

          employeeDataSource.updateDataGriDataSource();
        },
        decoration: const InputDecoration(
          hintText: "serach",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Column(children: [
          searchField(),
          const Padding(padding: EdgeInsets.all(5)),
          SizedBox(
              height: constraint.maxHeight - _dataPagerHeight - 100,
              width: constraint.maxWidth,
              child: _buildDataGrid(constraint)),
          SizedBox(
            height: _dataPagerHeight,
            child: SfDataPager(
              delegate: employeeDataSource,
              pageCount: pageCount,
              direction: Axis.horizontal,
            ),
          )
        ]);
      }),
    );
  }

  Widget _buildDataGrid(BoxConstraints constraint) {
    return SfDataGrid(
      rowsPerPage: 15,
      source: employeeDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
            columnName: 'id',
            label: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: const Text(
                  'ID',
                ))),
        GridColumn(
            columnName: 'name',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('Name'))),
        GridColumn(
            columnName: 'designation',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  'Designation',
                  overflow: TextOverflow.ellipsis,
                ))),
        GridColumn(
            columnName: 'salary',
            label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text('Salary'))),
      ],
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10011, 'Doran', 'Developer', 15000),
      Employee(10012, 'Banda', 'Developer', 15000),
      Employee(10013, 'Banks', 'Developer', 15000),
      Employee(10014, 'Santana', 'Developer', 15000),
      Employee(10015, 'Banks', 'Developer', 15000),
      Employee(10016, 'Santana', 'Developer', 15000),
      Employee(10017, 'Banks', 'Developer', 15000),
      Employee(10018, 'Santana', 'Developer', 15000),
      Employee(10019, 'Banks', 'Developer', 15000),
      Employee(10020, 'Santana', 'Developer', 15000),
      Employee(10021, 'Banks', 'Developer', 15000),
      Employee(10022, 'Santana', 'Developer', 15000),
      Employee(10023, 'Banks', 'Developer', 15000),
      Employee(10024, 'Santana', 'Developer', 15000),
      Employee(10025, 'Banks', 'Developer', 15000),
      Employee(10026, 'Santana', 'Developer', 15000),
      Employee(10027, 'Banks', 'Developer', 15000),
      Employee(10028, 'Santana', 'Developer', 15000),
      Employee(10029, 'Banks', 'Developer', 15000),
      Employee(10030, 'Santana', 'Developer', 15000),
      Employee(10031, 'James', 'Project Lead', 20000),
      Employee(10032, 'Kathryn', 'Manager', 30000),
      Employee(10033, 'Lara', 'Developer', 15000),
      Employee(10034, 'Michael', 'Designer', 15000),
      Employee(10035, 'Martin', 'Developer', 15000),
      Employee(10036, 'Newberry', 'Developer', 15000),
      Employee(10037, 'Balnc', 'Developer', 15000),
      Employee(10038, 'Perry', 'Developer', 15000),
      Employee(10039, 'Gable', 'Developer', 15000),
      Employee(10040, 'Grimes', 'Developer', 15000),
      Employee(10041, 'James', 'Project Lead', 20000),
      Employee(10042, 'Kathryn', 'Manager', 30000),
      Employee(10043, 'Lara', 'Developer', 15000),
      Employee(10044, 'Michael', 'Designer', 15000),
      Employee(10045, 'Martin', 'Developer', 15000),
      Employee(10046, 'Newberry', 'Developer', 15000),
      Employee(10047, 'Balnc', 'Developer', 15000),
      Employee(10048, 'Perry', 'Developer', 15000),
      Employee(10049, 'Gable', 'Developer', 15000),
      Employee(10050, 'Grimes', 'Developer', 15000),
      Employee(10051, 'James', 'Project Lead', 20000),
      Employee(10052, 'Kathryn', 'Manager', 30000),
      Employee(10053, 'Lara', 'Developer', 15000),
      Employee(10054, 'Michael', 'Designer', 15000),
      Employee(10055, 'Martin', 'Developer', 15000),
      Employee(10056, 'Newberry', 'Developer', 15000),
      Employee(10057, 'Balnc', 'Developer', 15000),
      Employee(10058, 'Perry', 'Developer', 15000),
      Employee(10059, 'Gable', 'Developer', 15000),
      Employee(10060, 'Grimes', 'Developer', 15000),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed

/// information about the employee which will be rendered in datagrid.

class Employee {
  /// Creates the employee class with required details.

  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.

  final int id;

  /// Name of an employee.

  final String name;

  /// Designation of an employee.

  final String designation;

  /// Salary of an employee.

  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This

/// is used to map the employee data to the datagrid widget.

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.

  EmployeeDataSource({required List<Employee> employeeData}) {
    buildPaginatedDataGridRows(employeeData);
  }

  List<DataGridRow> _employeeRows = [];

  @override
  List<DataGridRow> get rows => _employeeRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void buildPaginatedDataGridRows(List<Employee> employees) {
    _employeeRows = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList(growable: false);
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}
