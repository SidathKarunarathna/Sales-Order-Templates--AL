pageextension 50104 "Sales Order Card Ext" extends "Sales Order"
{


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                NewMode := true;
        NotRefreshed := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SalesOrderTemplateMgt: Codeunit "Sales Order Template Mgt";
        SalesOrdertemplate: Record "Sales Order Templates";
        SalesOrderTemplateLine: Record "Sales Order Templates Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesReciveable: Record "Sales & Receivables Setup";
        customer: Record Customer;
        PickACustomer: page "Pick Customer Page";
    begin
        SalesReciveable.Get();
        if SalesReciveable."Enable Template" then
            if NewMode then begin
                TemplateCode := SalesOrderTemplateMgt.SelectSalesTemplate();
                SalesOrdertemplate.get(TemplateCode);
                NoSeriesMgt.InitSeries(SalesOrdertemplate."No. Series", '', SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
                NoSeriesMgt.InitSeries(SalesOrdertemplate."Posted No.Series", '', SalesHeader."Posting Date", SalesHeader."Posting No.", SalesHeader."Posting No. Series");
                SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                SalesHeader."Your Reference" := SalesOrdertemplate."Your Reference";
                //SalesHeader.Validate("Sell-to Customer No.", SalesOrdertemplate."Sell-to-Customer-No.");
                SalesHeader.NotRefreshed := true;
                Commit();
                if SalesOrdertemplate."Sell-to-Customer-No." = '' then begin
                    if PickACustomer.RunModal() = Action::OK then begin
                        SalesHeader.Validate("Sell-to Customer No.", PickACustomer.GetCustomerNo());
                    end
                end
                else begin
                    SalesHeader.Validate("Sell-to Customer No.", SalesOrdertemplate."Sell-to-Customer-No.");
                end;
                SalesHeader.Insert(true);

                SalesOrderTemplateLine.SetRange("Template Code", TemplateCode);
                if SalesOrderTemplateLine.FindSet() then
                    repeat begin
                        SalesLine.init();
                        SalesLine."Document Type" := SalesLine."Document Type"::Order;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := SalesOrderTemplateLine."Line no";
                        SalesLine.Type := SalesOrderTemplateLine.Type;
                        SalesLine.Validate("No.", SalesOrderTemplateLine."No.");
                        SalesLine.Validate(Quantity, SalesOrderTemplateLine.Quantity);
                        SalesLine.Insert();
                        //SalesLine.Modify();
                        CurrPage.Update;
                    end until SalesOrderTemplateLine.Next() = 0;


                Rec.Copy(SalesHeader);
                CurrPage.Update();
                CurrPage.Close();



                NewMode := false;

            end;
    end;







    var
        NotRefreshed: Boolean;
        NewMode: Boolean;
        TemplateCode: Code[20];

}
