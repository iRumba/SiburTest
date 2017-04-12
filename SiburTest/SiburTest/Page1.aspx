<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page1.aspx.cs" Inherits="SiburTest.Page1" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:SqlDataSource ID="StuffSource" runat="server" ConnectionString="<%$ connectionStrings:SiburConnection %>"
        SelectCommand="SELECT Id, FirstName FROM EmployeeSet"
        UpdateCommand="UPDATE EmployeeSet SET FirstName = @FirstName WHERE Id = @Id"
        InsertCommand="INSERT INTO EmployeeSet (FirstName, LastName) VALUES (@FirstName, @LastName)"></asp:SqlDataSource>
    Page1
    <asp:GridView ID="grid" runat="server" DataSourceID="StuffSource" AutoGenerateColumns="False" DataKeyNames="Id">
        <Columns>
            <asp:BoundField DataField="FirstName" HeaderText="Имя"/>
        </Columns>
    </asp:GridView>
    <asp:Button runat="server" Text="New" OnClick="Unnamed_Click"/>
    <asp:TextBox Width="500" runat="server" ID="txtName"/>
</asp:Content>
