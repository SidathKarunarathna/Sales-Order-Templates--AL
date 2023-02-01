pageextension 50104 "Sales Order Card Ext" extends "Sales Order"
{
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                NewMode := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SalesOrderTemplateMgt: Codeunit "Sales Order Template Mgt";
        SalesOrdertemplate: Record "Sales Order Templates";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesHeader: Record "Sales Header";
        SalesReciveable: Record "Sales & Receivables Setup";
    begin
        SalesReciveable.Get();
        if SalesReciveable."Enable Template" then
            if NewMode then begin
                TemplateCode := SalesOrderTemplateMgt.SelectCustomerTemplate();
                SalesOrdertemplate.get(TemplateCode);
                NoSeriesMgt.InitSeries(SalesOrdertemplate."No. Series", '', SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
                NoSeriesMgt.InitSeries(SalesOrdertemplate."Posted No.Series",'',SalesHeader."Posting Date",SalesHeader."Posting No.",SalesHeader."Posting No. Series");
                SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                SalesHeader."Your Reference" := SalesOrdertemplate."Your Reference";
                SalesHeader.Insert(true);
                Commit();
                Rec.Copy(SalesHeader);
                CurrPage.Update;
                NewMode := false;
            end;



    end;



    var
        NewMode: Boolean;
        TemplateCode: Code[20];

}
