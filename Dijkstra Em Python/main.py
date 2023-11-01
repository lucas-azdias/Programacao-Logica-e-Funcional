from heapq import heappush, heappop


def dijkstra(graph: dict, origin: str) -> dict:
    """
    .. function:: dijkstra(graph: dict, origin: str) -> dict

    Dijkstra's Shortest Path Algorithm
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This function implements Dijkstra's algorithm to find the minimum distances and shortest paths
    from a given origin node to all other nodes in a weighted directed graph.

    :param dict graph: A dictionary representing a weighted directed graph, where keys are nodes
                        and values are dictionaries containing neighbouring nodes as keys and their
                        corresponding edge weights as values.
    :param str origin: The origin node from which to find the minimum distances and shortest paths
                        to all other nodes in the graph.
    :return: A dictionary containing the minimum distances from the origin node to all other nodes
            in the graph, and a dictionary containing the shortest paths from the origin node to
            all other nodes. The shortest paths are represented as lists of nodes.
    :rtype: dict

    The function initializes two dictionaries:

    - "dists_map": A dictionary to store minimum distances from the origin to all nodes. Initially,
        all distances are set to "infinity" except for the origin node, which is set to 0.
    - "paths_map": A dictionary to store the shortest paths from the origin to all nodes. Initially,
        all paths are set to None for each node except the origin node, which has a path containing
        only itself.

    It then creates a priority queue, "non_visited_nodes", to keep track of non-visited nodes
    along with their current distances from the origin node.

    The main loop of the algorithm continues until all nodes have been visited. In each iteration,
    the node with the smallest current distance, "cur_dist", is removed from the priority queue,
    and its neighbours are examined. If a shorter path to a neighbour is found through the current
    node, the distance and path to that neighbour are updated, and the neighbour is added back to
    the priority queue for further exploration.

    Finally, the function returns two dictionaries: "dists_map" containing the minimum distances
    from the origin node to all nodes, and "paths_map" containing the shortest paths from the origin
    node to all nodes.
    """
    # Initialize a dictionary to store minimum distances from the origin to all nodes.
    # Initially, set all distances to "infinity" for each node in the graph.
    dists_map = {node: float('inf') for node in graph}

    # Set the distance from the origin node to itself as 0
    dists_map[origin] = 0

    # Initialize a dictionary to store the shortest paths from the origin to all nodes.
    # Initially, set paths to None for each node in the graph.
    paths_map = {node: None for node in graph}

    # Initialize the path for the origin node as a list containing only the origin node
    paths_map[origin] = [origin]

    # Create a priority queue to keep track of non-visited nodes and their distances
    non_visited_nodes = [(0, origin)]

    # Main loop for Dijkstra's algorithm
    while non_visited_nodes:
        # Get the node with the smallest current distance
        cur_dist, cur_node = heappop(non_visited_nodes)

        # If the current distance is greater than the recorded distance, skip
        if cur_dist > dists_map[cur_node]:
            continue

        # Iterate through neighbours of the current node
        for neighbour_node, dist in graph[cur_node].items():
            # Calculate the total distance to the neighbour through the current node
            total_dist = cur_dist + dist

            # If the total distance is less than the recorded distance to the neighbour
            if total_dist < dists_map[neighbour_node]:
                # Update the distance to the neighbour
                dists_map[neighbour_node] = total_dist

                # Construct the path to the neighbour by copying the path to the current node
                path = paths_map[cur_node][:]
                path.append(neighbour_node)
                paths_map[neighbour_node] = path

                # Add the neighbour to the priority queue with its updated distance
                heappush(non_visited_nodes, (total_dist, neighbour_node))

    # Return the dictionaries containing distances and paths
    return dists_map, paths_map


def invert_paths(paths_map: dict) -> dict:
    """
    .. function:: invert_paths(paths_map)

    Inverts Paths in a Paths Map
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    This function takes a dictionary of nodes and their corresponding paths and
    returns a new dictionary with inverted paths. The inversion involves reversing
    the order of nodes in each path, effectively providing paths from destination
    nodes back to the source node.

    :param dict paths_map: A dictionary where keys represent nodes, and values
                            are lists representing paths from a source node to the
                            respective key node.
    :return: A dictionary containing inverted paths, where keys represent nodes,
            and values are lists representing paths from the key node back to
            the source node.
    :rtype: dict
    """
    # Initialize an empty dictionary to store inverted paths
    inverted_paths = {}

    # Iterate through the nodes and paths in the input paths_map
    for node, path in paths_map.items():
        # Reverse the path (i.e., flip it in reverse order)
        inverted_paths[node] = path[::-1]

    # Return the dictionary of inverted paths
    return inverted_paths


if __name__ == "__main__":
    # Graphs for tests
    graphs = [
        {
            "A": {"B": 1, "C": 2},
            "B": {"A": 1, "C": 4, "G": 3},
            "C": {"A": 4, "B": 4, "D": 4},
            "D": {"C": 4, "E": 5},
            "E": {"D": 5, "F": 6},
            "F": {"E": 6, "G": 7, "H": 8},
            "G": {"B": 3, "F": 7, "H": 9},
            "H": {"G": 9, "F": 8}
        },
        {
            "A": {"B": 1, "C": 2, "D": 5, "E": 10, "F": 3, "G": 7, "H": 8},
            "B": {"A": 1, "I": 3, "J": 4},
            "C": {"A": 2, "K": 2},
            "D": {"A": 5, "L": 1},
            "E": {"A": 10, "M": 6},
            "F": {"A": 3},
            "G": {"A": 7},
            "H": {"A": 8},
            "I": {"B": 3},
            "J": {"B": 4},
            "K": {"C": 2},
            "L": {"D": 1},
            "M": {"E": 6},
        },
        {
            "X": {"Y": 2, "Z": 5, "W": 10, "V": 7, "U": 8, "T": 6, "S": 9, "R": 4},
            "Y": {"X": 2, "Z": 1, "W": 4},
            "Z": {"X": 5, "Y": 1, "W": 2},
            "W": {"X": 10, "Y": 4, "Z": 2},
            "V": {"X": 7},
            "U": {"X": 8},
            "T": {"X": 6},
            "S": {"X": 9},
            "R": {"X": 4}
        }
    ]

    # Origins for tests
    origins = [
        "A",
        "M",
        "X"
    ]

    # Print a header for the Dijkstra algorithm section
    print("\nDIJKSTRA ALGORITHM")

    # Loop through the list of graphs
    for i in range(len(graphs)):
        # Print a header for the current test run
        print(f"\nRUNNING TEST {i + 1}...\n")

        # Print the graph and origin node used for this test
        print(f"Graph used: {graphs[i]}")
        print(f"Origin applied: {origins[i]}")

        # Run Dijkstra's algorithm on the current graph and origin node
        result_dists, result_paths = dijkstra(graphs[i], origins[i])
        print(f"\nMinimum distances from {origins[i]} to all nodes:\n{result_dists}")
        print(f"\nMinimum paths from {origins[i]} to all nodes:\n{result_paths}")

        # Invert the paths to show minimum paths from all nodes to the origin
        inverted_paths = invert_paths(result_paths)
        print(f"\nMinimum paths from all nodes to {origins[i]}:\n{inverted_paths}")

        # Wait for user input before proceeding to the next test
        input("\n > Press a key to continue.")

    print("\nProgram ended successfully.\n")
