import time


def start_job():
    for i in range(1, 10):
        print(i)
        time.sleep(2)
    print("Done")


if __name__ == '__main__':
    start_job()
