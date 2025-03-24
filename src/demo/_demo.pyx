# cython: language_level=3

log = print


def set_log_callback(new_log_message):
    global log
    log = new_log_message


cdef extern from "<threads.h>" nogil:
    ctypedef int (*thrd_start_t)(void*) nogil noexcept
    ctypedef struct thrd_t:
        pass

    int thrd_create(thrd_t*, thrd_start_t, void*)
    int thrd_join(thrd_t, int *res)


cdef int hard_work_helper(void *unused) nogil noexcept:
    with gil:
        log("starting hard work")
    ret = 21 * 2
    with gil:
        log("finished hard work")
    return ret



def hard_work_impl():
    cdef thrd_t thread
    thrd_create(&thread, hard_work_helper, NULL)
    cdef int result
    cdef int rc
    with nogil:
        rc = thrd_join(thread, &result)
    assert rc == 0
    assert result == 42
