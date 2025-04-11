BEGIN { 
    received_bytes = 0;
    start_time = -1;
}

{
    if ($2 ~ /^[0-9.]+$/) {
        if (start_time == -1) {
            start_time = $2;
        }

        end_time = $2;

        # Count received TCP packets (ignoring ACKs)
        if ($1 == "r" && $5 == "tcp") {
            received_bytes += $6;  # Assuming field 6 contains packet size
            time = int($2);  # Round timestamp to nearest second
            throughput[time] += ($6 * 8) / 1000;  # Convert bytes to kilobits
        }
    }
}

END {
    for (t in throughput) {
        print t, throughput[t];
    }
}
