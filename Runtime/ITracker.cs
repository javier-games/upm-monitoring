namespace JG.UPM.Monitoring
{
    public interface ITracker
    {
        void Start();
        string Stop();
        void Flush();
    }
}