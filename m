From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Beagle x15: perf test -v hangs on Linux 4.9 and 4.14
Date: Mon, 22 Apr 2019 19:16:54 +0530
Message-ID: <CA+G9fYvy8gcJO2hLZpwtTjD10Aw8G-eawLjOKi68dTfrmM2KAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org
Cc: lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>
List-Id: linux-omap@vger.kernel.org

Perf test -v hangs on beagle x15 device running Linux version stable
4.9 and 4.14 kernel. ( gcc version 7.3.0).

X15
----
Test breakpoint overflow signal handler: FAILED
Test breakpoint overflow sampling                        :
--- start ---
test child forked, pid 381
***Hangs Forever***

Debug log with strace output,

strace -f perf test -v
...
[pid   346] perf_event_open({type=PERF_TYPE_BREAKPOINT,
size=PERF_ATTR_SIZE_VER5, config=0, ...}, 0, -1, -1,
PERF_FLAG_FD_CLOEXEC) = 3
[pid   346] fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK|O_ASYNC) = 0
[pid   346] fcntl64(3, F_SETSIG, SIGIO) = 0
[pid   346] getpid()                    = 346
[pid   346] fcntl64(3, F_SETOWN, 346)   = 0
[pid   346] ioctl(3, PERF_EVENT_IOC_RESET, 0) = 0
[pid   346] ioctl(3, PERF_EVENT_IOC_ENABLE, 0) = 0
[pid   346] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid   346] rt_sigreturn({mask=[WINCH]}) = 0
...
popping up this log continuesly
....
[pid   346] --- SIGIO {si_signo=SIGIO, si_code=POLL_IN, si_band=65} ---
[pid   346] rt_sigreturn({mask=[WINCH]}) = 0"}

Ref:
Juno/x15: perf: Test breakpoint overflow sampling and test hangs
https://bugs.linaro.org/show_bug.cgi?id=4321
Full test log,
https://lkft.validation.linaro.org/scheduler/job/655038#L1794
Kernel Config,
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/am57xx-evm/lkft/linux-stable-rc-4.9/524/config

Best regards
Naresh Kamboju
