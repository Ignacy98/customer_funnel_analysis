# Funnel Analysis

## Overview
This project analyzes a user conversion funnel using event-level data. The goal is to understand where users drop off as they move through the customer journey and whether performance differs by device type.

**Funnel steps:**
1. Browse
2. Add to Cart
3. Checkout
4. Purchase

## Business goal
The objective of this analysis is to identify the biggest bottlenecks in the funnel and turn them into actionable recommendations for conversion rate optimization.

## Dataset
This project uses a **publicly available synthetic dataset** sourced from Kaggle:
- https://www.kaggle.com/datasets/dhruvkp07/funnel-analysis-dataset

The analysis is based on an event dataset containing at least the following fields:
- `User ID`
- `Session ID`
- `Event`
- `Device`

The event types used in the funnel are:
- `Browse`
- `Add to Cart`
- `Checkout`
- `Purchase`

## Tools used
- PostgreSQL
- Python / visualization library
- GitHub

## Methodology
The analysis follows three steps:

1. **Session-level aggregation**  
   User events were grouped by `User ID` and `Session ID` to measure how many funnel events each user completed.

2. **Funnel counting**  
   Distinct users were counted at each funnel stage to measure conversion volume.

3. **Conversion and drop-off calculation**  
   For each step, the share of users relative to the first step was calculated, along with the drop-off from the previous step.

The same analysis was repeated for each device type to compare funnel performance across platforms.

## Key findings
### Overall funnel
- The largest drop-off happens between **Checkout** and **Purchase**.
- Early-stage engagement is relatively strong, with a high share of users moving from **Browse** to **Add to Cart**.
- The final conversion rate from **Browse** to **Purchase** is low, indicating friction near the end of the purchase journey.

### Device comparison
- **Desktop** performs slightly better than the other devices at the final stage.
- **Mobile** shows the weakest purchase conversion and the highest checkout drop-off.
- **Tablet** performs close to the overall average.

## Recommended actions
Based on the analysis, the most important improvement areas are:
- simplify checkout steps
- reduce form friction
- support guest checkout
- improve mobile checkout usability
- make payment and delivery information more transparent earlier in the journey

## Visuals
This project includes two main charts:
- **Overall funnel chart** showing the number of users at each stage
- **Device comparison chart** showing conversion performance across Desktop, Mobile, and Tablet

## Repository structure
```text
.
├── data/
├── sql/
├── python/
├── charts/
├── README.md
└── ...
```

## Limitations
- The funnel is based on observed events and user sessions.
- It shows conversion across stages, but it does not capture all possible reasons for abandonment.
- Additional behavioral data would be needed to explain the exact cause of drop-off.

## Conclusion
This project shows that the main challenge is not getting users to browse or add items to cart. The main bottleneck appears at the checkout stage, especially on mobile devices. That makes checkout optimization the highest-priority recommendation.

## Contact
Prepared as a portfolio project for SQL and analytics practice.

