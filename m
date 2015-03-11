From: Xunlei Pang <xlpang-KN7UnAbNpbg@public.gmane.org>
Subject: [PATCH 0/8] Add y2038 safe replacements for read_boot_clock(), read_persistent_clock() and update_persistent_clock()
Date: Wed, 11 Mar 2015 11:15:07 +0800
Message-ID: <1426043715-22043-1-git-send-email-xlpang@126.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux390-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

read_boot_clock(), read_persistent_clock() and update_persistent_clock()
all use timespec which may have "y2038 problem", thus we are planning on
converting all of them to use timespec64.

The approach we're using is:
1) First of all, add the "__weak" implementaion of xxx_clock64() which uses
   xxx_clock() and timespec64.

   Let's take read_persistent_clock() as an example. We can create its
   y2038-safe version below:
        void __weak read_persistent_clock64(struct timespec64 *ts64)
        {
             struct timespec ts;

            read_persistent_clock(&ts);
            *ts64 = timespec_to_timespec64(ts);
        }

   Then, replace all the call sites of xxx_clock() with xxx_clock64() except
   the one used by xxx_clock64().

2) Convert every architecture specific xxx_clock() to xxx_clock64() one by one.
   At this point, we can convert the three functions at a time if needed, because
   most time they're correlated.

3) Remove xxx_clock() after all its architecture specific implementations have been
   converted to use corresponding y2038 safe xxx_clock64().

This patchset firstly finished the step1 for all the three functions, then focused
on read_boot_clock() which is simple to go on with step2 and step3 as a whole show.

As for read_persistent_clock() and update_persistent_clock() which are more complex,
requiring many efforts to convert every architecture specific implementation gradually.

The approach used here is Suggested-by: "Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>"

Xunlei Pang (8):
  time: Add y2038 safe read_boot_clock64()
  time: Add y2038 safe read_persistent_clock64()
  time: Add y2038 safe update_persistent_clock64()
  ARM: OMAP: 32k counter: Provide y2038-safe
    omap_read_persistent_clock() replacement
  ARM: tegra: clock: Provide y2038-safe tegra_read_persistent_clock()
    replacement
  ARM: time: Provide read_boot_clock64() and read_persistent_clock64()
  s390: time: Provide read_boot_clock64() and read_persistent_clock64()
  time: Remove read_boot_clock()

 arch/arm/include/asm/mach/time.h    |  3 +--
 arch/arm/kernel/time.c              |  6 +++---
 arch/arm/plat-omap/counter_32k.c    | 18 ++++++------------
 arch/mips/lasat/sysctl.c            |  4 ++--
 arch/s390/include/asm/timex.h       |  4 ++--
 arch/s390/kernel/debug.c            |  4 ++--
 arch/s390/kernel/time.c             |  6 +++---
 drivers/clocksource/tegra20_timer.c | 15 +++++++--------
 drivers/rtc/systohc.c               |  2 +-
 include/linux/timekeeping.h         |  4 +++-
 kernel/time/ntp.c                   | 13 ++++++++++++-
 kernel/time/timekeeping.c           | 31 ++++++++++++++++---------------
 12 files changed, 58 insertions(+), 52 deletions(-)

-- 
1.9.1
