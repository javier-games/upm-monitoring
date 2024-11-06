using System.IO;
using UnityEngine;
using UnityEngine.Events;

namespace JG.UPM.Monitoring
{
	public class TrackerComponent : MonoBehaviour
	{
		[SerializeField]
		private UnityEvent<string> onStop;
		private ITracker Tracker { get; set; }

		private void Awake()
		{
#if PLATFORM_IOS && !UNITY_EDITOR
			Tracker = new IOS.TrackerAdapter(Application.targetFrameRate);
#else
			Tracker = new DefaultTracker();
#endif
		}

		public void StartTracking()
		{
			Tracker.Start();
		}

		public void StopTracking()
		{
			var path = Tracker.Stop();
			if (string.IsNullOrEmpty(path)) { return; }
			onStop.Invoke(File.ReadAllText(path));
		}

		private void OnDestroy()
		{
			Tracker.Flush();
		}
	}
}