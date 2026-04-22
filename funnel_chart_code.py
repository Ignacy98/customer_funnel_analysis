import plotly.graph_objects as go

# Set up the funnel steps and corresponding user counts
steps = df1['step']
num_users = df1['num_users']

# Create the funnel chart
fig = go.Figure(go.Funnel(
    y=steps,
    x=num_users,
    textinfo="value+percent initial"
))

fig.update_layout(
    title='Funnel Analysis',
    xaxis_title='Number of Users'
)

fig.show()
