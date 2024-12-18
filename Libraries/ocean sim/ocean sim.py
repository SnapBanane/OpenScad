# Ocean Floor Simulation / or just any noise plane simulation
# made by Julius Gerhardus with the help of copilot


# Parameters

plane_size = 100  # Expand plane to 100x100 for ~10k faces

wave_height = 0.2  # Base height for raised points

wave_multipliers = [1.2, 1.5, 1.8, 2.0, 2.5]  # Five different multipliers



# Initialize points list

points = []



# Generate points with height and random multipliers

for x in range(1, plane_size + 1):

    for y in range(1, plane_size + 1):

        z = 0

        # Randomly raise some points

        if random.random() < 0.2:  # 20% chance to raise a point

            z = wave_height

            # Further modify some raised points with a random multiplier

            if random.random() < 0.5:  # 50% chance to apply a multiplier

                z *= random.choice(wave_multipliers)

        points.append([x, y, z])



# Generate faces connecting points

faces = []

for x in range(plane_size - 1):

    for y in range(plane_size - 1):

        top_left = x * plane_size + y

        top_right = top_left + 1

        bottom_left = top_left + plane_size

        bottom_right = bottom_left + 1

        faces.append([top_left, top_right, bottom_right, bottom_left])



# Write the data to a file with variables and expanded content

output_file_10k_faces = "/mnt/data/100x100_plane_points_faces_with_variables.txt"

with open(output_file_10k_faces, "w") as f:

    f.write("// Parameters\n")

    f.write(f"wave_height = {wave_height};\n")

    f.write(f"wave_multipliers = {wave_multipliers};\n\n")

    f.write("points = [\n")

    for point in points:

        z_value = point[2]

        if z_value == 0:

            f.write(f"    [{point[0]}, {point[1]}, 0],\n")

        elif z_value in [wave_height * m for m in wave_multipliers]:

            multiplier_index = [wave_height * m for m in wave_multipliers].index(z_value)

            f.write(f"    [{point[0]}, {point[1]}, wave_height * wave_multipliers[{multiplier_index}]],\n")

        else:  # z_value == wave_height

            f.write(f"    [{point[0]}, {point[1]}, wave_height],\n")

    f.write("];\n\n")

    f.write("faces = [\n")

    for face in faces:

        f.write(f"    {face},\n")

    f.write("];\n")



output_file_10k_faces