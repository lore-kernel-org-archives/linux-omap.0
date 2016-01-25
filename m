From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 25 Jan 2016 08:33:33 -0800
Message-ID: <20160125163332.GT19432@atomide.com>
References: <20160123121022.GB12497@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160123121022.GB12497@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160123 04:11]:
> 
> So far, the LEDs stubbornly stay on :-(. Machine is booted off
> sd-card, and I'm connected to it over wifi. GSM is active, X is
> running.

If LEDs stay on, you're not entering deeper idle states.

> Normally, ping looks like this:
> 
> 64 bytes from 192.168.43.15: icmp_seq=371 ttl=64 time=2.18 ms
> 64 bytes from 192.168.43.15: icmp_seq=372 ttl=64 time=2.21 ms
> 64 bytes from 192.168.43.15: icmp_seq=373 ttl=64 time=2.94 ms
> 
> When I enable the off mode:
> echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
> 
> Wifi is no longer happy:
> 
> 64 bytes from 192.168.43.15: icmp_seq=426 ttl=64 time=351 ms
> 64 bytes from 192.168.43.15: icmp_seq=427 ttl=64 time=178 ms
> 64 bytes from 192.168.43.15: icmp_seq=428 ttl=64 time=2.36 ms

Latencies of several hundred ms are expected when hitting off
mode during idle as the latency for power off the system during
idle is long. It could also be that there's a wakeirq config
missing somewhere. Does the WLAN have a separate GPIO irq?

> and touchscreen stops working:
> 
> [99480.564910] tsc2005 spi1.0: TSC200X not responding - resetting
> [99486.995758] bq27xxx-battery 2-0055: battery is not calibrated!
> ignoring capacity values
> [99488.564147] tsc2005 spi1.0: TSC200X not responding - resetting
> [99495.550018] bq27xxx-battery 2-0055: battery is not calibrated!
> ignoring capacity values
> [99496.564208] tsc2005 spi1.0: TSC200X not responding - resetting
> [99504.129852] bq27xxx-battery 2-0055: battery is not calibrated!
> ignoring capacity values
> [99504.564208] tsc2005 spi1.0: TSC200X not responding - resetting

This could be because we're still lacking i2c-omap + pinctrl
handling for erratum 1.158. Without that, any GPIO pins not in
GPIO bank 1 used for enabling devices may have glitches during
off-mode.

The workaround for now is to mux those pins permanently with
PIN_INPUT_PULLUP | MUX_MODE7 to keep them high using the
internal pull. So in this case, maybe give a try for adding
a pinctrl entry for tsc2005 for gpio104 to have it always
in PIN_INPUT_PULLUP | MUX_MODE7.

The long term solution is to do this dynamically for each GPIO
pin.. I do have some WIP patches for that but those still need
work before I dare to post them.

> echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode
> 
> Fixes both wifi and touchscreen. Is off_mode expected to break
> touchscreen? Any ideas what needs to be shut down so that the sleep
> leds go off?

Yes you can dump the idlest regs during idle and see the blockers.
Below is a hack patch I've been using, that could potentially
be turned into something we could actually merge. Needs to have
separate hooks for various SoCs though, this works only on omap3..

> Power consumption seems to be in 500mA range, regardless of
> off_mode. That would mean about 2 hours of battery life, AFAICT.

Sounds like you have USB connected and charging? You can
get into just few mW range with the mainline kernel for sure
on omap3. It's just a quetion of fixing whatever few drivers
that are still causing issues on n900.

Typically you need at least USB disconnected and LCD blanked
to start hitting the deeper idle states :)

Regards,

Tony

8< -----------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 26 Mar 2015 14:01:31 -0700
Subject: [PATCH] Test patch for dumping omap3 off idle blocking bits

Not for merging.

Allows seeing the deeper idle state blockers in
/sys/kernel/debug/pm_debug/count. For example, when
off idle is working on beaglboard xm, this is what
I see:

# sleep 5; cat /sys/kernel/debug/pm_debug/count
...
0006ffff 48005020 (fa005020) cm_idlest_per blocking bits: 00010000
e7ffffbd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042
0000000d 48004a28 (fa004a28) cm_idlest3_core

--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -142,10 +142,76 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 	return 0;
 }
 
+#include "iomap.h"
+
+struct dregs {
+	const char	*desc;
+	u32		phys;
+	void __iomem	*virt;
+	u32		mask;
+};
+
+#define PER_CM_BASE	0x48005000
+#define PER_CM_REG(name, offset, mask)				\
+	{ name, PER_CM_BASE + offset,				\
+	OMAP2_L4_IO_ADDRESS(PER_CM_BASE + offset), mask, }
+
+static struct dregs cm_per[] = {
+	PER_CM_REG("cm_idlest_per", 0x20, 0xfff80000), /* p 513 */
+	{ NULL, },
+};
+
+#define CORE_CM_BASE	0x48004a00
+#define CORE_CM_REG(name, offset, mask)				\
+	{ name, CORE_CM_BASE + offset,				\
+	OMAP2_L4_IO_ADDRESS(CORE_CM_BASE + offset), mask, }
+
+static struct dregs cm_core[] = {
+	CORE_CM_REG("cm_idlest1_core", 0x20, 0x9c800109), /* p 467 */
+	CORE_CM_REG("cm_idlest3_core", 0x28, 0xfffffffb),
+	{ NULL, },
+};
+
+void __dregs_dump(struct dregs *dregs, struct seq_file *s)
+{
+	for (; dregs->desc; dregs++) {
+		u32 val, blockers;
+
+		val = __raw_readl(dregs->virt);
+
+		seq_printf(s, "%08x %08x (%p) %s",
+			   val, dregs->phys, dregs->virt,
+			   dregs->desc);
+
+		if (dregs->mask) {
+			blockers = ~val;
+			blockers &= ~dregs->mask;
+
+			if (blockers)
+				seq_printf(s, " blocking bits: %08x",
+					   blockers);
+		}
+
+		seq_printf(s, "\n");
+	}
+}
+
+void cm_per_dump(struct seq_file *s)
+{
+	__dregs_dump(cm_per, s);
+}
+
+void cm_core_dump(struct seq_file *s)
+{
+	__dregs_dump(cm_core, s);
+}
+
 static int pm_dbg_show_counters(struct seq_file *s, void *unused)
 {
 	pwrdm_for_each(pwrdm_dbg_show_counter, s);
 	clkdm_for_each(clkdm_dbg_show_counter, s);
+	cm_per_dump(s);
+	cm_core_dump(s);
 
 	return 0;
 }
