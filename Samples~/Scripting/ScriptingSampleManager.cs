using UnityEngine;
using UnityEngine.UI;

namespace JG.UPM.Monitoring.IOS.Sample
{ 
	public class ScriptingSampleManager : MonoBehaviour
	{
		[SerializeField]
		private Text gpuLabel;

		[SerializeField]
		private Text ramLabel;

		[SerializeField]
		private Text cpuLabel;

		private void FixedUpdate()
		{
			gpuLabel.text = "GPU:" + DeviceMonitor.GetGpuUsage().ToString("P2");
			ramLabel.text = "RAM:" + DeviceMonitor.GetRamUsage().ToString("P2");
			cpuLabel.text = "CPU:" + DeviceMonitor.GetCpuUsage().ToString("P2");
		}
	}
}