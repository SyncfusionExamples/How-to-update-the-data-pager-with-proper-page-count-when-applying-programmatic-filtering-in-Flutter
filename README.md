## How to update the data pager with proper page count when applying programmatic filtering in Flutter DataTable (SfDataGrid)?

In this article, we will show you how to update the data pager with the proper page count when applying programmatic filtering in [Flutter DataGrid](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) and [SfDataPager](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataPager-class.html) widgets with all required properties, begin by declaring them and specifying their respective properties. Additionally, ensure to update the DataPager’ s page count whenever filtering is applied to or removed from the rows. This update should reflect the pageCount value based on the length of the [DataGridSource.effectiveRows](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource/effectiveRows.html).

```dart
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
          if (value.isNotEmpty&&
              _pageEmployee.any((employee) =>
                  employee.name.toLowerCase() == value.toLowerCase()) ) {
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
```
You can download the example from [GitHub](https://github.com/SyncfusionExamples/How-to-update-the-data-pager-with-proper-page-count-when-applying-programmatic-filtering-in-Flutter).