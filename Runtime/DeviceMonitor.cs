namespace JG.UPM.Monitoring
{
	public static class DeviceMonitor
	{
		public static float GetCpuUsage()
		{
#if PLATFORM_IOS && !UNITY_EDITOR
			return IOS.PerformanceCalculatorAdapter.GetCpuUsage();
#else
			return 0;
#endif
		}

		public static float GetRamUsage()
		{
#if PLATFORM_IOS && !UNITY_EDITOR
			return IOS.PerformanceCalculatorAdapter.GetRamUsage();
#else
			return 0;
#endif
		}

		public static float GetGpuUsage()
		{
#if PLATFORM_IOS && !UNITY_EDITOR
			return IOS.PerformanceCalculatorAdapter.GetGpuUsage();
#else
			return 0;
#endif
		}
	}
}