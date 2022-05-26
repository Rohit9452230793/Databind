using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Databind.Startup))]
namespace Databind
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
