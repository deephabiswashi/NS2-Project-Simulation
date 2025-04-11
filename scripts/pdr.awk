BEGIN { 
    sent = 0; 
    received = 0; 
}

{
    # Check if the second field is numeric (to handle the simple format lines)
    if ($2 ~ /^[0-9.]+$/) {
        # For send events: we assume the protocol is in field 5.
        if ($1 == "+" && $5 == "tcp") {
            sent++;
        }
        # For receive events: count if protocol is "tcp" (ignoring ack events)
        if ($1 == "r" && $5 == "tcp") { 
            received++;
            # Calculate cumulative PDR, provided at least one packet has been sent.
            if (sent > 0) {
                pdr = (received / sent) * 100;
            } else {
                pdr = 0;
            }
            # Output: time and current cumulative PDR.
            print $2, pdr;
        }
    }
}
