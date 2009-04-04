From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Git tree updated, clocks and PM code reset to mainline
Date: Sat, 4 Apr 2009 16:33:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904041630170.8305@utopia.booyaka.com>
References: <20090403001333.GR32530@atomide.com> <20090403091553.82ceacf8.jarkko.nikula@nokia.com> <87k561htu0.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54900 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbZDDWd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 18:33:27 -0400
In-Reply-To: <87k561htu0.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Kalle, Jarkko,

On Sat, 4 Apr 2009, Kalle Valo wrote:

> Jarkko Nikula <jarkko.nikula@nokia.com> writes:
> 
> > Just a test report. N810 is not booting anymore due an oops and Beagle
> > hangs when calibrating the delay loop.
> >
> > Both using their defconfigs + CONFIG_DEBUG_LL=y. N810 boot log below.
> 
> I see the same with N800, same configs as Jarkko had:

Evidently the 24xx clock code/data was never actually tested.  Does this 
patch work for you?


regards,

- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Sat, 4 Apr 2009 16:26:39 -0600

OMAP2 clock fixes rollup: test

This test patch includes three fixes to the OMAP2 clock code and data to 
get N8x0 booting again.

---
 arch/arm/mach-omap2/clock24xx.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e839c5..7625d06 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -60,8 +60,8 @@ struct omap_clk {
 		},			\
 	}
 
-#define CK_243X	(1 << 0)
-#define CK_242X	(1 << 1)
+#define CK_243X		RATE_IN_243X
+#define CK_242X		RATE_IN_242X
 
 static struct omap_clk omap24xx_clks[] = {
 	/* external root sources */
@@ -711,7 +711,7 @@ int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
 	struct omap_clk *c;
-	u32 clkrate, cpu_mask;
+	u32 clkrate;
 
 	if (cpu_is_omap242x())
 		cpu_mask = RATE_IN_242X;
@@ -720,6 +720,8 @@ int __init omap2_clk_init(void)
 
 	clk_init(&omap2_clk_functions);
 
+	clk_init_one(&osc_ck);
+	clk_init_one(&sys_ck);
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
 	propagate_rate(&osc_ck);
 	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
@@ -728,12 +730,6 @@ int __init omap2_clk_init(void)
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
 		clk_init_one(c->lk.clk);
 
-	cpu_mask = 0;
-	if (cpu_is_omap2420())
-		cpu_mask |= CK_242X;
-	if (cpu_is_omap2430())
-		cpu_mask |= CK_243X;
-
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
 		if (c->cpu & cpu_mask) {
 			clkdev_add(&c->lk);
-- 
1.6.2.1.307.g91408

