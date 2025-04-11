import matplotlib.pyplot as plt
import pandas as pd

# Load throughput data
data = pd.read_csv("results/throughput.txt", sep=" ", header=None, names=["Time", "Throughput"])

# Sort by time
data = data.sort_values("Time")

# Plot
plt.figure(figsize=(10, 5))
plt.plot(data["Time"], data["Throughput"], marker="o", linestyle="-", color="b", label="Throughput (kbps)")

# Labels & Title
plt.xlabel("Time (seconds)")
plt.ylabel("Throughput (kbps)")
plt.title("Throughput Over Time")
plt.legend()
plt.grid(True)

# Show plot
plt.show()
