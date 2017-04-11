using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SiburTest.Startup))]
namespace SiburTest
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
