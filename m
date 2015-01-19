From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Add board-generic.c entry for ti81xx
Date: Mon, 19 Jan 2015 11:18:34 -0800
Message-ID: <20150119191833.GC18552@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-2-git-send-email-tony@atomide.com>
 <54B67461.9010402@cogentembedded.com>
 <20150115000713.GV2419@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11455 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751423AbbASTWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 14:22:02 -0500
Content-Disposition: inline
In-Reply-To: <20150115000713.GV2419@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150114 16:14]:
> * Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [150114 05:54]:
> > Hello.
> > 
> > On 1/14/2015 2:37 AM, Tony Lindgren wrote:
> > 
> > >This allows booting ti81xx boards with with when a .dts
> > 
> >    So, with, with or when? :-)
> 
> Heh thanks will updated to:
> 
> This allows booting ti81xx boards when a .dts file
> is in place.

This too needs to be in a separate ifdef CONFIG_SOC_TI81XX block
to avoid make randconfig build errors. Updated patch below.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Jan 2015 10:38:07 -0800
Subject: [PATCH] ARM: OMAP2+: Add board-generic.c entry for ti81xx

This allows booting ti81xx boards when a .dts file
is in place.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -142,6 +142,42 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
 	.dt_compat	= am3517_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
+
+static const char *const ti814x_boards_compat[] __initconst = {
+	"ti,dm8148",
+	"ti,dm814",
+	NULL,
+};
+#endif
+
+#ifdef CONFIG_SOC_TI81XX
+DT_MACHINE_START(TI81XX_DT, "Generic ti814x (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti814x_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= ti81xx_init_late,
+	.init_time	= omap3_gptimer_timer_init,
+	.dt_compat	= ti814x_boards_compat,
+	.restart	= ti81xx_restart,
+MACHINE_END
+
+static const char *const ti816x_boards_compat[] __initconst = {
+	"ti,dm8168",
+	"ti,dm816",
+	NULL,
+};
+
+DT_MACHINE_START(TI816X_DT, "Generic ti816x (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti816x_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= ti81xx_init_late,
+	.init_time	= omap3_gptimer_timer_init,
+	.dt_compat	= ti816x_boards_compat,
+	.restart	= ti81xx_restart,
+MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
