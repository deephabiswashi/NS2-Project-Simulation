set terminal png
set output "graphs/pdr_plot.png"
set title "Packet Delivery Ratio Over Time"
set xlabel "Time (s)"
set ylabel "PDR (%)"
set grid
set xrange [0:*]
set yrange [0:100]
plot "graphs/pdr.dat" using 1:2 with lines title "PDR"
