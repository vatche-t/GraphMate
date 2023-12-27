# GraphMate

## Introduction
This project involves the analysis and visualization of spatial data using edge bundling techniques. The primary goal is to uncover patterns and relationships within the data and present them in an interpretable manner. The dataset is loaded from an Excel file containing information related to edge bundling.

## Notebook Structure

### 1. Data Loading and Cleaning

#### 1.1 Loading Data
- The provided Excel file, "physical-spatial_Edge Bundling.xlsx," is loaded into memory.
- All sheets from the Excel file are read, and the head of each dataframe is printed.

#### 1.2 Data Cleaning
- Whitespace is removed from column names and cells where possible.

### 2. Hierarchical Clustering

#### 2.1 Dendrogram Visualization
- The first sheet, assumed to contain relevant data for edge bundling, is selected.
- A hierarchical clustering dendrogram is created to identify clusters within the data.

#### 2.2 Agglomerative Clustering
- Agglomerative clustering is applied to the matrix, and cluster labels are added to the dataframe.
- The data is prepared for edge bundling visualization.

### 3. Edge Bundling Visualization
#### 3.1 Network Graph Creation
- A graph is created from the edges dataframe using NetworkX.
- Nodes are colored based on cluster membership.

#### 3.2 Arc Diagram
- An arc diagram is generated to visualize the connections between nodes.

#### 3.3 Weight Analysis
- Intra-cluster and inter-cluster edge weights are analyzed and visualized using bar plots.

#### 3.4 Weight Distribution within Clusters
- The distribution of edge weights within each cluster is visualized using a boxplot.
- Statistics for each cluster, such as mean and quartiles, are calculated and displayed.

### 4. Principal Component Analysis and KMeans Clustering

#### 4.1 Standardization and PCA
- Features are standardized and reduced to two principal components using PCA.

#### 4.2 KMeans Clustering
- KMeans clustering is applied to the PCA-reduced data.
- The clustered data is visualized using a scatter plot.
- Explained variance ratio and cluster centers are printed.

## Conclusion
This comprehensive analysis and visualization project provide insights into spatial data relationships, emphasizing edge bundling techniques. The combination of hierarchical clustering, edge bundling visualization, and advanced analyses contributes to a thorough exploration of the dataset. The results can aid in understanding patterns and structures within complex spatial data.

## Details: Hierarchical Clustering and Edge Bundling

In this section of the code, we perform hierarchical clustering to identify clusters within the dataset. Additionally, we prepare the data for edge bundling visualization using the NetworkX library.

### Hierarchical Clustering

```python
from sklearn.cluster import AgglomerativeClustering

# Determine the number of clusters
n_clusters = 3
# Apply hierarchical clustering to the matrix
hc = AgglomerativeClustering(n_clusters=n_clusters, affinity='euclidean', linkage='ward')
cluster_labels = hc.fit_predict(matrix)
# Add cluster labels to the dataframe
matrix_df['cluster'] = cluster_labels

# Display the head of the dataframe with cluster labels
print(matrix_df.head())
```

1. **Number of Clusters:**
   - The variable `n_clusters` is set to 3, indicating the desired number of clusters.
   
2. **Hierarchical Clustering:**
   - `AgglomerativeClustering` is employed with Euclidean distance and Ward linkage.
   - Cluster labels are assigned to each row in the matrix.
   
3. **Updating Dataframe:**
   - Cluster labels are added to the original dataframe (`matrix_df`).

### Edge Bundling Visualization

```python
# Now we will prepare the data for the edge bundling visualization
# We will create a new dataframe with source, target, and weight for the edges
edges = []
for i in range(len(matrix)):
    for j in range(i+1, len(matrix)):
        if matrix[i][j] > 0:  # Assuming that a weight of 0 means no edge
            edges.append({'source': matrix_df.index[i], 'target': matrix_df.index[j], 'weight': matrix[i][j], 'cluster': cluster_labels[i]})

edges_df = pd.DataFrame(edges)

# Display the head of the edges dataframe
print(edges_df.head())
```

1. **Edge Data Preparation:**
   - A new dataframe (`edges_df`) is created to store edge information (source, target, weight, and cluster).
   - A nested loop iterates through the matrix, identifying edges based on non-zero weights.

2. **Display Edge Data:**
   - The head of the edges dataframe is printed for inspection.

### Network Graph Creation and Visualization

```python
import networkx as nx
from itertools import cycle

# Create a graph from the edges dataframe
G = nx.from_pandas_edgelist(edges_df, 'source', 'target', ['weight', 'cluster'])

# Define colors for clusters
cluster_colors = cycle(['red', 'green', 'blue'])

# Assign colors to nodes based on their cluster
node_colors = [next(cluster_colors) if node in edges_df['source'].values else 'black' for node in G.nodes()]

# Draw the graph
plt.figure(figsize=(12, 12))
pos = nx.spring_layout(G, seed=42)  # Use spring layout
weights = nx.get_edge_attributes(G, 'weight')
nx.draw(G, pos, with_labels=True, node_color=node_colors, width=list(weights.values()))
plt.title('Edge Bundling Visualization')
plt.show()
```

1. **Graph Creation:**
   - A graph (`G`) is created using NetworkX from the edges dataframe.

2. **Cluster Colors:**
   - Colors for clusters are defined cyclically.

3. **Node Colors:**
   - Nodes are assigned colors based on their cluster membership.

4. **Graph Visualization:**
   - The graph is visualized using a spring layout, and edge weights are considered in the visualization.

5. **Result Display:**
   - The resulting edge bundling visualization is displayed.

This section of the code integrates hierarchical clustering and edge bundling to provide a visual representation of clusters and their connections within the spatial dataset. The resulting graph enhances the understanding of spatial relationships and patterns.