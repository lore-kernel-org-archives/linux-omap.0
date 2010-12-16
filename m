From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/13] ARM: sched_clock: provide common infrastructure
	for sched_clock()
Date: Thu, 16 Dec 2010 12:52:22 +0000
Message-ID: <20101216125222.GQ9937@n2100.arm.linux.org.uk>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk> <E1PTA7n-00079H-Ep@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50455 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab0LPMwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 07:52:43 -0500
Content-Disposition: inline
In-Reply-To: <E1PTA7n-00079H-Ep@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>, linux-omap@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>, Krzysztof Halasa <khc@pm.waw.pl>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>

On Thu, Dec 16, 2010 at 09:27:47AM +0000, Russell King - ARM Linux wrote:
> Provide common sched_clock() infrastructure for platforms to use to
> create a 64-bit ns based sched_clock() implementation from a counter
> running at a non-variable clock rate.

Some of the comments in the patch were only relevant to a previous
version.  He's an updated version with proper comments to avoid
confusion.

 arch/arm/Kconfig                   |    3 +
 arch/arm/include/asm/sched_clock.h |  115 ++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile           |    1 +
 arch/arm/kernel/sched_clock.c      |   69 +++++++++++++++++++++
 4 files changed, 188 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49778bb..ed7a0a7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -38,6 +38,9 @@ config HAVE_PWM
 config SYS_SUPPORTS_APM_EMULATION
 	bool
 
+config HAVE_SCHED_CLOCK
+	bool
+
 config GENERIC_GPIO
 	bool
 
diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
new file mode 100644
index 0000000..82d4d3f
--- /dev/null
+++ b/arch/arm/include/asm/sched_clock.h
@@ -0,0 +1,115 @@
+/*
+ * sched_clock.h: support for extending counters to full 64-bit ns counter
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_SCHED_CLOCK
+#define ASM_SCHED_CLOCK
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct clock_data {
+	u64 epoch_ns;
+	u32 epoch_cyc;
+	u32 epoch_cyc_copy;
+	u32 mult;
+	u32 shift;
+};
+
+#define DEFINE_CLOCK_DATA(name)	struct clock_data name
+
+static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+{
+	return (cyc * mult) >> shift;
+}
+
+/*
+ * Atomically update the sched_clock epoch.  Your update callback will
+ * be called from a timer before the counter wraps - read the current
+ * counter value, and call this function to safely move the epochs
+ * forward.
+ */
+static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
+{
+	u64 ns = cd->epoch_ns +
+		cyc_to_ns((cyc - cd->epoch_cyc) & mask, cd->mult, cd->shift);
+
+	/*
+	 * Write epoch_cyc and epoch_ns in a way that the update is
+	 * detectable in cyc_to_fixed_sched_clock().
+	 */
+	cd->epoch_cyc = cyc;
+	smp_wmb();
+	cd->epoch_ns = ns;
+	smp_wmb();
+	cd->epoch_cyc_copy = cyc;
+}
+
+/*
+ * If your clock rate is known at compile time, using this will allow
+ * you to optimize the mult/shift loads away.  This is paired with
+ * init_fixed_sched_clock() to ensure that your mult/shift are correct.
+ */
+static inline unsigned long long cyc_to_fixed_sched_clock(struct clock_data *cd,
+	u32 cyc, u32 mask, u32 mult, u32 shift)
+{
+	u64 epoch_ns;
+	u32 epoch_cyc;
+
+	/*
+	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
+	 * ensuring that we always write epoch_cyc, epoch_ns and
+	 * epoch_cyc_copy in strict order, and read them in strict order.
+	 * If epoch_cyc and epoch_cyc_copy are not equal, then we're in
+	 * the middle of an update, and we should repeat the load.
+	 */
+	do {
+		epoch_cyc = cd->epoch_cyc;
+		smp_rmb();
+		epoch_ns = cd->epoch_ns;
+		smp_rmb();
+	} while (epoch_cyc != cd->epoch_cyc_copy);
+
+	return epoch_ns + cyc_to_ns((cyc - epoch_cyc) & mask, mult, shift);
+}
+
+/*
+ * Otherwise, you need to use this, which will obtain the mult/shift
+ * from the clock_data structure.  Use init_sched_clock() with this.
+ */
+static inline unsigned long long cyc_to_sched_clock(struct clock_data *cd,
+	u32 cyc, u32 mask)
+{
+	return cyc_to_fixed_sched_clock(cd, cyc, mask, cd->mult, cd->shift);
+}
+
+/*
+ * Initialize the clock data - calculate the appropriate multiplier
+ * and shift.  Also setup a timer to ensure that the epoch is refreshed
+ * at the appropriate time interval, which will call your update
+ * handler.
+ */
+void init_sched_clock(struct clock_data *, void (*)(void),
+	unsigned int, unsigned long);
+
+/*
+ * Use this initialization function rather than init_sched_clock() if
+ * you're using cyc_to_fixed_sched_clock, which will warn if your
+ * constants are incorrect.
+ */
+static inline void init_fixed_sched_clock(struct clock_data *cd,
+	void (*update)(void), unsigned int bits, unsigned long rate,
+	u32 mult, u32 shift)
+{
+	init_sched_clock(cd, update, bits, rate);
+	if (cd->mult != mult || cd->shift != shift) {
+		pr_crit("sched_clock: wrong multiply/shift: %u>>%u vs calculated %u>>%u\n"
+			"sched_clock: fix multiply/shift to avoid scheduler hiccups\n",
+			mult, shift, cd->mult, cd->shift);
+	}
+}
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 679851a..fd3ec49 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
+obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
new file mode 100644
index 0000000..b10b02b
--- /dev/null
+++ b/arch/arm/kernel/sched_clock.c
@@ -0,0 +1,69 @@
+/*
+ * sched_clock.c: support for extending counters to full 64-bit ns counter
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+
+#include <asm/sched_clock.h>
+
+static void sched_clock_poll(unsigned long wrap_ticks);
+static DEFINE_TIMER(sched_clock_timer, sched_clock_poll, 0, 0);
+static void (*sched_clock_update_fn)(void);
+
+static void sched_clock_poll(unsigned long wrap_ticks)
+{
+	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
+	sched_clock_update_fn();
+}
+
+void __init init_sched_clock(struct clock_data *cd, void (*update)(void),
+	unsigned int clock_bits, unsigned long rate)
+{
+	unsigned long r, w;
+	u64 res, wrap;
+	char r_unit;
+
+	sched_clock_update_fn = update;
+
+	/* calculate the mult/shift to convert counter ticks to ns. */
+	clocks_calc_mult_shift(&cd->mult, &cd->shift, rate, NSEC_PER_SEC, 60);
+
+	r = rate;
+	if (r >= 4000000) {
+		r /= 1000000;
+		r_unit = 'M';
+	} else {
+		r /= 1000;
+		r_unit = 'k';
+	}
+
+	/* calculate how many ns until we wrap */
+	wrap = cyc_to_ns((1ULL << clock_bits) - 1, cd->mult, cd->shift);
+	do_div(wrap, 1000000);
+	w = wrap;
+
+	/* calculate the ns resolution of this counter */
+	res = cyc_to_ns(1ULL, cd->mult, cd->shift);
+	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every %lums\n",
+		clock_bits, r, r_unit, res, w);
+
+	/*
+	 * Start the timer to keep sched_clock() properly updated and
+	 * sets the initial epoch.
+	 */
+	sched_clock_timer.data = msecs_to_jiffies(w - (w / 10));
+	sched_clock_poll(sched_clock_timer.data);
+
+	/*
+	 * Ensure that sched_clock() starts off at 0ns
+	 */
+	cd->epoch_ns = 0;
+}

