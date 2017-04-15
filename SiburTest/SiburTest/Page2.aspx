<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page2.aspx.cs" Inherits="SiburTest.Page2" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="input-group col-md-12">
            <asp:Label runat="server" Text="Разделитель:" CssClass="input-group-addon" Font-Bold="true" />
            <asp:TextBox runat="server" Text='<%# Separator %>' ID="txtSep" CssClass="form-control" />
            <asp:Button runat="server" OnClick="Unnamed_Click" CssClass="btn" Text="Применить" />
        </div>
    </div>
    <br />
    <asp:LinqDataSource runat="server"
        ID="DeparetmentsSource"
        ContextTypeName="SiburTest.Models.StaffContext"
        TableName="Departments" />
    <asp:Repeater runat="server" DataSource="<%# Departments %>" ID="rep">
        <ItemTemplate>
            <div class="row">

                <div class="col-md-12">
                    <p>
                        <asp:Label runat="server" Text='<%# Eval("Name") %>' Font-Size="Larger" Font-Bold="true" />
                    </p>
                    <p style="margin-left: 15px">
                        <asp:Label runat="server"
                            Text='<%# string.Join(Separator,((Eval("Employees") as List<SiburTest.Models.Employee>) ?? new List<SiburTest.Models.Employee>()).Select(empl=> GetShortName(empl))) %>' />
                    </p>
                </div>
            </div>

        </ItemTemplate>

    </asp:Repeater>
</asp:Content>
