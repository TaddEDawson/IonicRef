[xml]$Game = Get-Content -Path .\16429725767.xml

$Entries = @()

foreach ($Lap in $Game.TrainingCenterDatabase.Activities.Activity.Lap)
{
    $Lap | Select-Object StartTime, TotalTimeSeconds, DistanceMeters
    foreach($TrackPoint in $Lap.Track.Trackpoint)
    {
        $entry = "" | Select-Object Time, Lat, Lon, TotalDistance, IncrementalDistance, Velocity, MinMile HeartRate
            $entry.Time = $TrackPoint.Time
            $entry.Lat = $TrackPoint.Position.LatitudeDegrees
            $entry.Lon = $TrackPoint.Position.LongitudeDegrees
            $entry.TotalDistance = $TrackPoint.DistanceMeters
            if($Entries.Count -lt 1)
            {
                $entry.IncrementalDistance = 0
                $entry.Velocity = 0
                $entry.MinMile = 0
            }
            else 
            {
                $entry.IncrementalDistance = ($TrackPoint.DistanceMeters - $Entries[$Entries.Count-1].TotalDistance)
                # m/s as the increment of th erecording is each second
                # convert to min/mile to get a "feel" of the exertion

                $entry.Velocity = $entry.IncrementalDistance
                $entry.MinMile = $entry.IncrementalDistance * 10.3567
            }            
            
            $entry.HeartRate = $TrackPoint.HeartRateBpm.Value

        $Entries += $entry
    }
}


