[xml]$Game = Get-Content -Path .\16429725767.xml

$Entries = @()

foreach ($Lap in $Game.TrainingCenterDatabase.Activities.Activity.Lap)
{
    $Lap | Select-Object StartTime, TotalTimeSeconds, DistanceMeters
    foreach($TrackPoint in $Lap.Track.Trackpoint)
    {
        $entry = "" | Select-Object Time, Lat, Lon, TotalDistance, IncrementalDistance, Velocity, HeartRate
            $entry.Time = $TrackPoint.Time
            $entry.Lat = $TrackPoint.Position.LatitudeDegrees
            $entry.Lon = $TrackPoint.Position.LongitudeDegrees
            $entry.TotalDistance = $TrackPoint.DistanceMeters
            if($Entries.Count -lt 1)
            {
                $entry.IncrementalDistance = 0
                $entry.Velocity = 0
            }
            else 
            {
                $entry.IncrementalDistance = $Entries[$Entries.Count-1].TotalDistance
                $entry.Velocity = 0

                $Entries[$Entries.Count-1].TotalDistance
            }            
            
            $entry.HeartRate = $TrackPoint.HeartRateBpm.Value

        $Entries += $entry
    }
}


