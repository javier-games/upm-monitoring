#if UNITY_IOS
using System.Runtime.InteropServices;

namespace games.javier.upm.monitoring.ios
{
	public class TrackerAdapter : ITracker
	{
		[DllImport("__Internal", EntryPoint = "start_tracking")]
		private static extern void StartTracking();

		[DllImport("__Internal", EntryPoint = "stop_tracking")]
		private static extern string StopTracking();

		[DllImport("__Internal", EntryPoint = "flush")]
		private static extern void FlushTracker();

		[DllImport("__Internal", EntryPoint = "set_frame_rate")]
		private static extern void SetFrameRate(int frameRate);

		public TrackerAdapter(int frameRate) => SetFrameRate(frameRate);
		public void Start() => StartTracking();
		public string Stop() => StopTracking();
		public void Flush() => FlushTracker();
	}
}
#endif