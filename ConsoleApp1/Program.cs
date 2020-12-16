using Newtonsoft.Json;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            PowerShell ps;
            Runspace runspace = RunspaceFactory.CreateRunspace(InitialSessionState.CreateDefault());
            ps = PowerShell.Create();

            string jsonText = JsonConvert.SerializeObject("Load Newtonsoft.Json");

            using (runspace)
            {
                ps.AddScript(@"../../Test-AzAccountImport.ps1");
                var output = ps.Invoke();
                if (ps.Streams.Error.Count > 0)
                {
                    throw new RuntimeException($"Test failed due to a non-empty error stream.");
                }

                jsonText = JsonConvert.SerializeObject(output);
            }
        }
    }
}
