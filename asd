import rclpy
import DR_init
import math
from time import sleep



# for single robot
ROBOT_ID = "dsr01"
ROBOT_MODEL = "m0609"
VEL, ACC = 50, 50
DR_init.__dsr__id = ROBOT_ID
DR_init.__dsr__model = ROBOT_MODEL

target1 = [-503.86, 77.04, 309.37, 52.77, 180, -1]
target2 = [-384.36, 246.50, 150.48, 52.87, -124.423, -0.96]
target3 = [-680, 34.55, 325, 0, 180, -20]


def main(args=None):
    rclpy.init(args=args)
    node = rclpy.create_node("visual_servoing2", namespace=ROBOT_ID)

    DR_init.__dsr__node = node

    try:
        from DSR_ROBOT2 import (
            movej,
            movel,
            get_current_posx
        )

        from DR_common2 import posx, posj

    except ImportError as e:
        print(f"Error importing DSR_ROBOT2 : {e}")
        return

    JReady = [0, 0, -90, 0, -90, 0]
    movej(JReady, vel=VEL, acc=ACC)
    sleep(0.5)

    # target_xyz = [
    #     object_xyz[0],
    #     object_xyz[1],
    #     object_xyz[2] + 200.0  # 위쪽
    # ]

    # target_rpy = [90.0, 180.0, 90.0]

    # target_pose = target_xyz + target_rpy
    # print("Current Pose:", get_current_posx()[0])
    # print("Pose to move:", target_pose)

    movel(posx(target_pose), vel=100, acc=100)
    print("Current Pose:", get_current_posx()[0])


    movel(posx(pose), vel=50, acc=50)

# ==============================================

    print("이동 완료")
    rclpy.shutdown()

if __name__ == "__main__":
    main()
