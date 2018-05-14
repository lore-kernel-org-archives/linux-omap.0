From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 00/10] Add persistent clock support
Date: Mon, 14 May 2018 16:55:26 +0800
Message-ID: <cover.1526285602.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

We will meet below issues when compensating the suspend time for the timekeeping.

1. We have too many different ways of dealing with persistent timekeeping
across architectures, so it is hard for one driver to compatable with different
architectures.

2. On some platforms (such as Spreadtrum platform), we registered the high
resolution timer as one clocksource to update the OS time, but the high
resolution timer will be stopped in suspend state. So we use another one
always-on timer (but low resolution) to calculate the suspend time to
compensate the OS time. Though we can register the always-on timer as one
clocksource, we need re-calculate the mult/shift with one larger conversion
range to calculate the suspend time and need update the clock in case of
running over the always-on timer.

More duplicate code will be added if other platforms meet this case.

3. Now we have 3 sources that could be used to compensate the OS time:
Nonstop clocksource during suspend, persistent clock and rtc device,
which is complicated. Another hand is that the nonstop clocksource can
risk wrapping if the suspend time is too long, so we need one mechanism
to wake up the system before the nonstop clocksource wrapping.

According to above issues, we can introduce one common persistent clock
framework to compatable with different architectures, in future we will
remove the persistent clock implementation for each architecture. Also
this framework will implement common code to help drivers to register easily.
Moreover if we converted all SUSPEND_NONSTOP clocksource to register to
be one persistent clock, we can remove the SUSPEND_NONSTOP clocksource
accounting in timekeeping, which means we can only compensate the OS time
from persistent clock and RTC.

Will be appreciated for any comments. Thank you all.


Arnd posted some comments as below last time, but we did not get a general
consensus, so I post them again.

Arnd said:

"I was planning to discuss this with Daniel and John during Linaro Connect,
but that didn't happen, so I'd like to bring up the bigger picture here again.

Today, we have a number of subsystem-type interfaces that deal with
time keeping in the wider sense (I might be missing some):
 - clock source
 - clock event
 - sched clock
 - real time clock
 - ptp clock
 - persistent clock

The first five have separate registration interfaces and may all refer
to different hardware blocks, or (more commonly) have some overlap
in the hardware. The fifth one is generalized by your series, without it
it's really architecture specific (as the other ones were one one point).

Are we happy with that structure in the long run? One of my earlier
comments on this series was that I thought it should be combined with
the clocksource registration, but upon talking to Baolin about it more,
I realized that this just follows the same structure that we have for the
others.

In theory, we could have a more abstract way of registering a clock
hardware that interfaces with any combination of the six subsystems
I mentioned above, with a superset of the subsystem specific structures
and a set of flags that indicate what a particular device is usable for.

Combining all six might be a bit too much (in particular rtc, though
it clearly overlaps the persistent-clk case), but what your general
ideas on where we should be heading? Is it worth reworking the
core kernel portion of the subsystems to simplify the individual
drivers?"

Baolin Wang (10):
  time: Add persistent clock support
  clocksource: sprd: Add one persistent timer for Spreadtrum platform
  arm: omap: Convert 32K counter to use persistent clock
  clocksource: tegra20_timer: Remove register_persistent_clock() API
  arm: time: Remove the persistent clock support for ARM
  clocksource: arm_arch_timer: Register the persistent clock
  clocksource: timer-ti-32k: Register the persistent clock
  clocksource: time-pistachio: Register the persistent clock
  x86: tsc: Register the persistent clock
  time: timekeeping: Remove time compensating from nonstop clocksources

 arch/arm/include/asm/mach/time.h     |    4 -
 arch/arm/kernel/time.c               |   36 -------
 arch/arm/plat-omap/Kconfig           |    1 +
 arch/arm/plat-omap/counter_32k.c     |   44 ++-------
 arch/x86/Kconfig                     |    1 +
 arch/x86/kernel/tsc.c                |   16 +++
 drivers/clocksource/Kconfig          |    4 +
 drivers/clocksource/arm_arch_timer.c |   10 ++
 drivers/clocksource/tegra20_timer.c  |   12 ++-
 drivers/clocksource/time-pistachio.c |    3 +
 drivers/clocksource/timer-sprd.c     |   80 +++++++++++++++
 drivers/clocksource/timer-ti-32k.c   |    4 +
 include/linux/persistent_clock.h     |   21 ++++
 kernel/time/Kconfig                  |    4 +
 kernel/time/Makefile                 |    1 +
 kernel/time/persistent_clock.c       |  180 ++++++++++++++++++++++++++++++++++
 kernel/time/timekeeping.c            |   19 +---
 17 files changed, 345 insertions(+), 95 deletions(-)
 create mode 100644 include/linux/persistent_clock.h
 create mode 100644 kernel/time/persistent_clock.c

-- 
1.7.9.5
