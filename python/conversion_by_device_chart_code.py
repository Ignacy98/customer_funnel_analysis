import matplotlib.pyplot as plt
import numpy as np

# Get funnel steps and devices
steps = df2['step'].tolist()
devices = ['Desktop', 'Mobile', 'Tablet']

# Get percent_users for each device as a list of lists
percent_users = [
    df2['percent_users'].tolist(),
    df3['percent_users'].tolist(),
    df4['percent_users'].tolist()
]  # shape: (3, num_steps)

percent_users = np.array(percent_users)  # shape: (3, num_steps)

x = np.arange(len(steps))  # the label locations
width = 0.25  # the width of the bars

fig, ax = plt.subplots(figsize=(10, 6))

bars = []
for i, device in enumerate(devices):
    bars.append(
        ax.bar(
            x + (i - 1) * width,  # center the bars
            percent_users[i],
            width,
            label=device
        )
    )

ax.set_xlabel('Funnel Step')
ax.set_ylabel('% Conversion')
ax.set_title('Conversion Funnel by Device')
ax.set_xticks(x)
ax.set_xticklabels(steps, rotation=30, ha='right')
ax.set_ylim(0, 100)
ax.legend(title='Device')
plt.tight_layout()

fig.savefig('conversion_funnel_by_device.png', dpi=300)
