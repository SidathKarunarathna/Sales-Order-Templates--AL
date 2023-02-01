page 50103 "Sales Order Template List"
{
    ApplicationArea = All;
    Caption = 'Sales Order Template List';
    PageType = List;
    SourceTable = "Sales Order Templates";
    UsageCategory = Lists;
    CardPageId = "Sales Order Template Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
