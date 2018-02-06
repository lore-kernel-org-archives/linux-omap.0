From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 09:17:37 -0800
Message-ID: <20180206171737.GB21573@atomide.com>
References: <20180204000335.29812776@kemnade.info>
 <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
 <20180204093831.44322452@kemnade.info>
 <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
 <20180206074201.479405e7@aktux>
 <20180206160452.GA21573@atomide.com>
 <20180206175509.4d80e930@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180206175509.4d80e930@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 16:56]:
> On Tue, 6 Feb 2018 08:04:52 -0800
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 06:42]:
> > > rechecked with a board with really nothing connected there
> > > Same behaviour  
> > 
> > I've just verified that my test board power consumption goes
> > back to normal after rmmod ehci-omap with v4.15.
> > 
> yes, for me too, I initially used a test script which does an
> echo rmmod ehci-omap
> 
> without a real
> rmmod ehci-omap

Ah OK :)

> It just seems to be consistent with my observations in a fully booted
> system (where many things can play a role). Sorry for that confusion.

Try with a minimal set of modules first, then modprobe and rmmod one
at a time until you find the module breaking PM?

You probably know this already, but just in case it helps..

First idle the UARTs and enable off mode with something like:

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
	echo enabled > $uart/wakeup 2>&1
	echo auto > $uart/control 2>&1
done

echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode

Then if using omap3, the attached debug hack patch can be used to
see which devices are not idling:

> But suspend current is a problem. I have repeated the measurement with
> another board, so it is not a board problem. 

I also verified v4.15 behaves for suspend current even with
echi-omap loaded just in case.

Regards,

Tony

8< -------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 13 Dec 2017 16:36:45 -0800
Subject: [PATCH] NOT FOR MERGING: Test patch for dumping omap3 off idle
 blocking bits

Allows seeing the deeper idle state blockers in
/sys/kernel/debug/pm_debug/count. For example, when
off idle is working on beaglboard xm, this is what
i see:

# sleep 5; cat /sys/kernel/debug/pm_debug/count
...
0006ffff 48005020 (fa005020) cm_idlest_per blocking bits: 00010000
e7ffffbd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042
0000000d 48004a28 (fa004a28) cm_idlest3_core
---
 arch/arm/mach-omap2/pm-debug.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -142,10 +142,78 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
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
+	if (cpu_is_omap34xx()) {
+		cm_per_dump(s);
+		cm_core_dump(s);
+	}
 
 	return 0;
 }
-- 
2.16.1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
