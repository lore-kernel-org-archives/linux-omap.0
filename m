From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/8] time: Add persistent clock support
Date: Wed, 13 Jun 2018 19:32:28 +0800
Message-ID: <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On our Spreadtrum SC9860 platform, we registered the high resolution
ARM generic timer as one clocksource to update the OS time, but the
ARM generic timer will be stopped in suspend state. So we use one 64bit
always-on timer (but low resolution) of Spreadtrum to calculate the
suspend time to compensate the OS time. Though we can register the
always-on timer as one clocksource, we need re-calculate the
mult/shift with one larger conversion range to calculate the suspend
time.

But now we have too many different ways of dealing with persistent
timekeeping across architectures, and there will be many duplicate
code if we register one timer to be one persistent clock. Thus it
will be more helpful if we add one common framework for timer drivers
to be registered as one persistent clock and implement the common
read_persistent_clock64() to compensate the OS time.

Moreover we can register the clocksource with CLOCK_SOURCE_SUSPEND_NONSTOP
to be one persistent clock, then we can simplify the suspend/resume
accounting by removing CLOCK_SOURCE_SUSPEND_NONSTOP timing. After that
we can only compensate the OS time by persistent clock or RTC.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/persistent_clock.h |   23 +++++
 kernel/time/Kconfig              |    4 +
 kernel/time/Makefile             |    1 +
 kernel/time/alarmtimer.c         |    4 +
 kernel/time/persistent_clock.c   |  184 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 216 insertions(+)
 create mode 100644 include/linux/persistent_clock.h
 create mode 100644 kernel/time/persistent_clock.c

diff --git a/include/linux/persistent_clock.h b/include/linux/persistent_clock.h
new file mode 100644
index 0000000..7d42c1a
--- /dev/null
+++ b/include/linux/persistent_clock.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERSISTENT_CLOCK_H__
+#define __PERSISTENT_CLOCK_H__
+
+#ifdef CONFIG_PERSISTENT_CLOCK
+extern int persistent_clock_init_and_register(u64 (*read)(void),
+					      u64 mask, u32 freq,
+					      u64 maxsec);
+extern void persistent_clock_cleanup(void);
+extern void persistent_clock_start_alarmtimer(void);
+#else
+static inline int persistent_clock_init_and_register(u64 (*read)(void),
+						     u64 mask, u32 freq,
+						     u64 maxsec)
+{
+	return 0;
+}
+
+static inline void persistent_clock_cleanup(void) { }
+static inline void persistent_clock_start_alarmtimer(void) { }
+#endif
+
+#endif
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 78eabc4..7188600 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -47,6 +47,10 @@ config GENERIC_CLOCKEVENTS_MIN_ADJUST
 config GENERIC_CMOS_UPDATE
 	bool
 
+# Persistent clock support
+config PERSISTENT_CLOCK
+	bool
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index f1e46f3..f6d368f 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
+obj-$(CONFIG_PERSISTENT_CLOCK)			+= persistent_clock.o
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 639321b..1518fdb 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -29,6 +29,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/persistent_clock.h>
 
 #include "posix-timers.h"
 
@@ -892,6 +893,9 @@ static int __init alarmtimer_init(void)
 		error = PTR_ERR(pdev);
 		goto out_drv;
 	}
+
+	/* Start one alarmtimer to update persistent clock */
+	persistent_clock_start_alarmtimer();
 	return 0;
 
 out_drv:
diff --git a/kernel/time/persistent_clock.c b/kernel/time/persistent_clock.c
new file mode 100644
index 0000000..edaa659
--- /dev/null
+++ b/kernel/time/persistent_clock.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro, Inc.
+ *
+ * Author: Baolin Wang <baolin.wang@linaro.org>
+ */
+
+#include <linux/alarmtimer.h>
+#include <linux/clocksource.h>
+#include <linux/persistent_clock.h>
+
+/**
+ * persistent_clock_read_data - data required to read persistent clock
+ * @read: Returns a cycle value from persistent clock.
+ * @last_cycles: Clock cycle value at last update.
+ * @last_ns: Time value (nanoseconds) at last update.
+ * @mask: Bitmask for two's complement subtraction of non 64bit clocks.
+ * @mult: Cycle to nanosecond multiplier.
+ * @shift: Cycle to nanosecond divisor.
+ */
+struct persistent_clock_read_data {
+	u64 (*read)(void);
+	u64 last_cycles;
+	u64 last_ns;
+	u64 mask;
+	u32 mult;
+	u32 shift;
+};
+
+/**
+ * persistent_clock - represent the persistent clock
+ * @read_data: Data required to read from persistent clock.
+ * @seq: Sequence counter for protecting updates.
+ * @freq: The frequency of the persistent clock.
+ * @wrap: Duration for persistent clock can run before wrapping.
+ * @alarm: Update timeout for persistent clock wrap.
+ * @alarm_inited: Indicate if the alarm has been initialized.
+ */
+struct persistent_clock {
+	struct persistent_clock_read_data read_data;
+	seqcount_t seq;
+	u32 freq;
+	ktime_t wrap;
+	struct alarm alarm;
+	bool alarm_inited;
+};
+
+static struct persistent_clock p;
+
+void read_persistent_clock64(struct timespec64 *ts)
+{
+	struct persistent_clock_read_data *read_data = &p.read_data;
+	unsigned long seq;
+	u64 delta, nsecs;
+
+	if (!read_data->read) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
+	do {
+		seq = read_seqcount_begin(&p.seq);
+		delta = (read_data->read() - read_data->last_cycles) &
+			read_data->mask;
+
+		nsecs = read_data->last_ns +
+			clocksource_cyc2ns(delta, read_data->mult,
+					   read_data->shift);
+		*ts = ns_to_timespec64(nsecs);
+	} while (read_seqcount_retry(&p.seq, seq));
+}
+
+static void persistent_clock_update(void)
+{
+	struct persistent_clock_read_data *read_data = &p.read_data;
+	u64 cycles, delta;
+
+	write_seqcount_begin(&p.seq);
+
+	cycles = read_data->read();
+	delta = (cycles - read_data->last_cycles) & read_data->mask;
+	read_data->last_ns += clocksource_cyc2ns(delta, read_data->mult,
+						 read_data->shift);
+	read_data->last_cycles = cycles;
+
+	write_seqcount_end(&p.seq);
+}
+
+static enum alarmtimer_restart persistent_clock_alarm_fired(struct alarm *alarm,
+							    ktime_t now)
+{
+	persistent_clock_update();
+
+	alarm_forward(&p.alarm, now, p.wrap);
+	return ALARMTIMER_RESTART;
+}
+
+int persistent_clock_init_and_register(u64 (*read)(void), u64 mask,
+				       u32 freq, u64 maxsec)
+{
+	struct persistent_clock_read_data *read_data = &p.read_data;
+	u64 wrap, res, secs = maxsec;
+
+	if (!read || !mask || !freq)
+		return -EINVAL;
+
+	if (!secs) {
+		/*
+		 * If the timer driver did not specify the maximum conversion
+		 * seconds of the persistent clock, then we calculate the
+		 * conversion range with the persistent clock's bits and
+		 * frequency.
+		 */
+		secs = mask;
+		do_div(secs, freq);
+
+		/*
+		 * Some persistent counter can be larger than 32bit, so we
+		 * need limit the max suspend time to have a good conversion
+		 * precision. So 24 hours may be enough usually.
+		 */
+		if (secs > 86400)
+			secs = 86400;
+	}
+
+	/* Calculate the mult/shift to convert cycles to ns. */
+	clocks_calc_mult_shift(&read_data->mult, &read_data->shift, freq,
+			       NSEC_PER_SEC, (u32)secs);
+
+	/* Calculate how many nanoseconds until we risk wrapping. */
+	wrap = clocks_calc_max_nsecs(read_data->mult, read_data->shift, 0,
+				     mask, NULL);
+	p.wrap = ns_to_ktime(wrap);
+
+	p.freq = freq;
+	read_data->mask = mask;
+	read_data->read = read;
+
+	persistent_clock_update();
+
+	/* Calculate the ns resolution of this persistent clock. */
+	res = clocksource_cyc2ns(1ULL, read_data->mult, read_data->shift);
+
+	pr_info("persistent clock: mask %llu at %uHz, resolution %lluns, wraps every %lluns\n",
+		mask, freq, res, wrap);
+	return 0;
+}
+
+void persistent_clock_cleanup(void)
+{
+	p.read_data.read = NULL;
+
+	if (p.alarm_inited) {
+		alarm_cancel(&p.alarm);
+		p.alarm_inited = false;
+	}
+}
+
+void persistent_clock_start_alarmtimer(void)
+{
+	struct persistent_clock_read_data *read_data = &p.read_data;
+	ktime_t now;
+
+	/*
+	 * If no persistent clock function has been provided or the alarmtimer
+	 * has been initialized at that point, just return.
+	 */
+	if (!read_data->read || p.alarm_inited)
+		return;
+
+	persistent_clock_update();
+
+	/*
+	 * Since the persistent clock will not be stopped when system enters the
+	 * suspend state, thus we need start one alarmtimer to wakeup the system
+	 * to update the persistent clock before wrapping. We should start the
+	 * update alarmtimer after the alarmtimer subsystem was initialized.
+	 */
+	alarm_init(&p.alarm, ALARM_BOOTTIME, persistent_clock_alarm_fired);
+	now = ktime_get_boottime();
+	alarm_start(&p.alarm, ktime_add(now, p.wrap));
+	p.alarm_inited = true;
+}
-- 
1.7.9.5
