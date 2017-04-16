<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page2.aspx.cs" Inherits="SiburTest.Page2" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <%-- Форма для выбора разделителя --%>
    <div class="row">
        <div class="input-group col-md-12">
            <asp:Label runat="server" Text="Разделитель:" CssClass="input-group-addon" Font-Bold="true" />
            <asp:TextBox runat="server" Text='<%# Separator %>' ID="txtSep" CssClass="form-control" Width="50" />
            <asp:Button runat="server" OnClick="Unnamed_Click" CssClass="btn" Text="Применить" />
        </div>
    </div>
    <br />

    <%-- Вывод для отчета сотрудников по отделам --%>
    <asp:Repeater runat="server" DataSource="<%# Departments %>" ID="rep">
        <ItemTemplate>
            <div class="row">
                <div class="col-md-12">
                    <%-- Выводим название отдела --%>
                    <h5 style="background-color: #e0e0e0; padding: 10px; border-radius: 3px">
                        <asp:Label runat="server" Text='<%# Eval("Name") %>' Font-Size="Larger" Font-Bold="true" />
                    </h5>
                    <%-- Выводим список сотрудников отдела --%>
                    <p style="padding-left: 20px">
                        <asp:Label runat="server"
                            Text='<%# string.Join(Separator,((Eval("Employees") as List<SiburTest.Models.Employee>) ?? new List<SiburTest.Models.Employee>()).Select(empl=> GetShortName(empl))) %>' />
                    </p>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
