codeunit 50105 "Sales Order Template Mgt"
{
    procedure SelectCustomerTemplate() Result: Code[20]
    var
        SalesOrderTempl: Record "Sales Order Templates";
        SelectSalesOrderTemplList: Page "Sales Order Template List";
        IsHandled: Boolean;
    begin
        if (SalesOrderTempl.Count > 1) and GuiAllowed then begin
            SelectSalesOrderTemplList.SetTableView(SalesOrderTempl);
            SelectSalesOrderTemplList.LookupMode(true);
            if SelectSalesOrderTemplList.RunModal() = Action::LookupOK then begin
                SelectSalesOrderTemplList.GetRecord(SalesOrderTempl);

                exit(SalesOrderTempl."Template Code");
            end;
        end;

    end;


}
