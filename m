From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Mon, 08 Dec 2008 10:59:30 +0200
Message-ID: <1228726770.8668.66.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40065 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbYLHI7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 03:59:42 -0500
In-Reply-To: <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> nice test case.
> 
> On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
> 
> > I have had strange clk_enable() crashes with DSS2, and now I managed to
> > isolate it. With the included patch, on OMAP3 SDP board, with default
> > kernel config, I always get the crash below. In this example case it
> > happens at specific time on boot, but with DSS2 it happens randomly at
> > runtime, when I enable the DSS clocks.
> 
> Looks like there's some problem with the DSS driver's usage of 
> dss_tv_fclk.  Enabling dss_tv_fclk before entering your test code's 
> while-loop makes the problem go away here.  Patch below.

Yes, enabling dss_tv_fclk "fixes" it. Also enabling dss1_alwon_fck fixes
it. (Note that I had a bug in the test code: it's dss1_alwon_fck in
omap3, not dss1_fck =). Funny that I didn't get any error.).

So it's the ick that is causing the crashing.

> 
> As an aside, your test patch does not actually disable dss1_fclk, since it 
> is already enabled by the time the while-loop starts.  So you might also 
> want to add a clk_disable(c2) before your while-loop starts, when you 
> test.

What makes you say that? Who would enable it? And clk_get_count returns
0 for dss_ick, dss1_alwon_fck and dss_tv_fclk.

> 
> Based on the traceback that you sent, I'd conjecture that probably some 
> part of the DSS subsystem is generating an interrupt via DSS_IRQ; but then 
> dss_iclk ends up disabled, and the MPU INTC is not able to communicate 
> with the DSS, and the INTC wedges.  (The aborting access is to 0xd8200098, 
> the INTCPS_PENDING_IRQ0 register, rather than a DSS register.)  Probably 
> some IRQs need to be masked before disabling the dss_iclk.

Okay. So, is this a DSS problem or clock framework problem? I made the
following test module to make testing easier, and to turn off any
interrupts. Crashes with DSS interrupts turned off also (although they
should be off by default).

Disable omapfb from kconfig if you try this.



diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index e39e33e..2da9eab 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -138,3 +138,6 @@ obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
 
 #video output switch sysfs driver
 obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o
+
+obj-m += test.o
+
diff --git a/drivers/video/test.c b/drivers/video/test.c
new file mode 100644
index 0000000..285658f
--- /dev/null
+++ b/drivers/video/test.c
@@ -0,0 +1,60 @@
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <mach/clock.h>
+
+#define DISPC_BASE			0x48050400
+#define DISPC_IRQSTATUS			0x0018
+#define DISPC_IRQENABLE			0x001C
+
+static void __iomem *base;
+
+static void inline dispc_write_reg(int idx, u32 val)
+{
+	__raw_writel(val, base + idx);
+}
+
+static u32 inline dispc_read_reg(int idx)
+{
+	return __raw_readl(base + idx);
+}
+
+static int __init omapfb_init(void)
+{
+	struct clk *c1, *c2, *c3;
+
+	c1 = clk_get(NULL, "dss_ick");
+	c2 = clk_get(NULL, "dss1_alwon_fck");
+	c3 = clk_get(NULL, "dss_tv_fck");
+
+	base = ioremap(DISPC_BASE, SZ_1K);
+	printk("mapped to %p\n", base);
+
+	clk_enable(c1);
+	clk_enable(c2);
+
+	dispc_write_reg(DISPC_IRQENABLE, 0);
+	dispc_write_reg(DISPC_IRQSTATUS, 0);
+
+	clk_disable(c1);
+	clk_disable(c2);
+
+	printk("usecounts %d, %d, %d\n", clk_get_usecount(c1),
+			clk_get_usecount(c2),
+			clk_get_usecount(c3));
+
+	/*clk_enable(c2);*/
+	/*clk_enable(c3);*/
+
+	while(1) {
+		clk_enable(c1);
+		clk_disable(c1);
+	}
+
+	return 0;
+}
+
+module_init(omapfb_init);
+MODULE_LICENSE("GPL");
+




mapped to d8050400
usecounts 0, 0, 0
Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8200098
Internal error: : 1028 [#1]
Modules linked in: test(+)
CPU: 0    Not tainted  (2.6.28-rc6-omap1-05264-g1705711-dirty #27)
PC is at __irq_svc+0x34/0x80
LR is at _omap2_clk_enable+0xa0/0xe0
pc : [<c0029a14>]    lr : [<c0033404>]    psr: 60000193
sp : c7a01de0  ip : c7a01df0  fp : c7a01e3c
r10: bf003000  r9 : 00000000  r8 : c0029f68
r7 : c0364c4c  r6 : c0364aec  r5 : d8200000  r4 : ffffffff
r3 : 60000013  r2 : c0037f78  r1 : c0033404  r0 : c7a01e28
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387f  Table: 87930018  DAC: 00000015
Process insmod (pid: 434, stack limit = 0xc7a002e0)
Stack: (0xc7a01de0 to 0xc7a02000)
1de0: 00000000 00000000 00000010 00000001 80000013 00000000 c0364aec c0364c4c 
1e00: c0029f68 00000000 bf003000 c7a01e3c c7a01df0 c7a01e28 c0033404 c0037f78 
1e20: 60000013 ffffffff 00000000 00000000 c7a01e5c c7a01e40 bf0030d0 c0037f40 
1e40: c038a3a0 bf000440 000de220 00000000 c7a01f7c c7a01e60 c0029310 bf00300c 
1e60: c79deaa0 00000001 c8863d68 c885f000 c7a01e8c c7a01e80 c007b6b4 c007b454 
1e80: 00000007 c885f000 c79deaa0 00000001 c7a01ebc c7a01ea0 c008eaf8 c0096ad4 
1ea0: c79b64a0 00000001 bf000440 00000001 c7a01ecc c7a01ec0 c008eb8c c008ea40 
1ec0: c7a01f7c c7a01ed0 c0070704 c008eb58 00000000 c7a01f48 000de068 c8863ed0 
1ee0: c8864268 c8863c22 c79deae0 c88658e0 00000020 00000007 00000000 0000002e 
1f00: 0000002e bf00006c c0037f34 c7a00000 0000002b 00000022 c88642b8 c88642b8 
1f20: c8864290 00000022 00000000 00000000 00000000 00000000 000069b9 c036a548 
1f40: c7a01f6c 000069b9 bf000440 000de220 00000000 000069b9 bf000440 000de220 
1f60: 00000000 c0029f68 c7a00000 00000000 c7a01fa4 c7a01f80 c00708a4 c00292bc 
1f80: ffffffff 03d47e88 00000000 00000000 00000000 00000080 00000000 c7a01fa8 
1fa0: c0029dc0 c0070818 00000000 00000000 000de220 000069b9 000de068 00000000 
1fc0: 00000000 00000000 00000000 00000080 000de038 03d4776c 000db8d8 03d47e84 
1fe0: 03d46ef8 03d46ee8 00021b50 4018aec0 60000010 000de220 00000000 00000000 
Backtrace: 
[<c0037f34>] (clk_enable+0x0/0x54) from [<bf0030d0>] (omapfb_init+0xd0/0xf8 [test])
 r5:00000000 r4:00000000
[<bf003000>] (omapfb_init+0x0/0xf8 [test]) from [<c0029310>] (__exception_text_end+0x60/0x18c)
 r7:00000000 r6:000de220 r5:bf000440 r4:c038a3a0
[<c00292b0>] (__exception_text_end+0x0/0x18c) from [<c00708a4>] (sys_init_module+0x98/0x188)
[<c007080c>] (sys_init_module+0x0/0x188) from [<c0029dc0>] (ret_fast_syscall+0x0/0x2c)
 r7:00000080 r6:00000000 r5:00000000 r4:00000000
Code: e58d1000 e1a0100e e885001f e59f503c (e5950098) 
---[ end trace f89d026fb0e69049 ]---



