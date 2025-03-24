import datetime

from ._demo import hard_work_impl, set_log_callback


def log_message(message):
    now = datetime.datetime.now()
    timestamp = now.strftime("%Y-%m-%d %H:%M:%S")
    print(f"{timestamp}: {message}")


set_log_callback(log_message)


def do_hard_work():
    hard_work_impl()
