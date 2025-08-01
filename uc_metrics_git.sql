-- Create a Metric View with business-friendly dimensions and measures
CREATE VIEW IF NOT EXISTS sb.theme_park.theme_park_metric_view
WITH METRICS
LANGUAGE YAML
COMMENT 'Metric view demonstration'
AS $$
version: 0.1

source: sb.theme_park.theme_park_visitors

dimensions:
  - name: VisitFrequency
    expr: VisitFrequency

  - name: TotalSpendingUSD
    expr: TotalSpendingUSD

  - name: AvgQueueTimeMin
    expr: AvgQueueTimeMin

  - name: PastSkipPass
    expr: PastSkipPass
  
  - name: Month
    expr: date_trunc('month', LastVisitDate)

measures:
  - name: UniqueVisitors
    expr: COUNT(DISTINCT CustomerId)

  - name: TotalVisits
    expr: SUM(ROUND(VisitFrequency,0))  

  - name: TotalSpendingPerCustomer
    expr: SUM(TotalSpendingUSD) / COUNT(DISTINCT CustomerID)

  - name: AvgSpendingPerVisit
    expr: SUM(TotalSpendingUSD) / SUM(ROUND(VisitFrequency,0))

  - name: TotalRevenue
    expr: SUM(TotalSpendingUSD)

  - name: AvgQueueTimePerVisit
    expr: AVG(AvgQueueTimeMin)

  - name: TotalSkipPass
    expr: SUM(PastSkipPass)
$$;