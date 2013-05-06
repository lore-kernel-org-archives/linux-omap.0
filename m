From: Tony Lindgren <tony@atomide.com>
Subject: Re: mach-omap2/timer.c: Bug introduced while merging patch -
 ff931c82
Date: Mon, 6 May 2013 16:37:43 -0700
Message-ID: <20130506233743.GJ28721@atomide.com>
References: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
 <20130506152706.GD28721@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC7C93A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC7C93A@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [130506 11:35]:
> 
> Ohh yeah, I already have a patch for it -

Thanks, I'll add that into omap-for-v3.10/fixes. I modified
the comments a bit trying to figure out where it changed, updated
patch below.

Regards,

Tony


From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Mon, 6 May 2013 15:19:01 -0700
Subject: [PATCH] ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a

Looks like the timer.c fixes in commit ff931c82 (ARM: OMAP: clocks:
Delay clk inits atleast until slab is initialized) got lost in a
merge with da4a686a (ARM: smp_twd: convert to use CLKSRC_OF init).

Without the omap_clk_init() calls none of OMAP family of devices
boot.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
[tony@atomide.com: updated comments to describe merge error]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -549,6 +549,8 @@ static inline void __init realtime_counter_init(void)
 			       clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_gptimer_timer_init(void)			\
 {									\
+	if (omap_clk_init)						\
+		omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	omap2_gptimer_clocksource_init((clksrc_nr), clksrc_src,		\
@@ -559,6 +561,8 @@ void __init omap##name##_gptimer_timer_init(void)			\
 				clksrc_nr, clksrc_src, clksrc_prop)	\
 void __init omap##name##_sync32k_timer_init(void)		\
 {									\
+	if (omap_clk_init)						\
+		omap_clk_init();					\
 	omap_dmtimer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src, clkev_prop);	\
 	/* Enable the use of clocksource="gp_timer" kernel parameter */	\
