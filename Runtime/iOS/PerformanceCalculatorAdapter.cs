#if UNITY_IOS
using System.Runtime.InteropServices;

namespace JG.UPM.Monitoring.IOS
{
	internal static class PerformanceCalculatorAdapter
	{
		[DllImport("__Internal", EntryPoint = "get_gpu_usage")]
		public static extern float GetGpuUsage();

		[DllImport("__Internal", EntryPoint = "get_ram_usage")]
		public static extern float GetRamUsage();

		[DllImport("__Internal", EntryPoint = "get_cpu_usage")]
		public static extern float GetCpuUsage();
	}
}
#endif