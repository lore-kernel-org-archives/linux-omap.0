From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix CONFIG_LOCAL_TIMERS initialization for multi-omap
Date: Tue, 7 Sep 2010 20:17:48 -0700
Message-ID: <20100908031748.GK22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100906180346.GC20849@atomide.com>
 <20100908030951.GH22507@atomide.com>
 <20100908031214.GI22507@atomide.com>
 <20100908031404.GJ22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57092 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab0IHDR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 23:17:59 -0400
Content-Disposition: inline
In-Reply-To: <20100908031404.GJ22507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

Fix CONFIG_LOCAL_TIMERS initialization for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..5a3e606 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -228,8 +228,10 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
-	BUG_ON(!twd_base);
+	if (cpu_is_omap44xx()) {
+		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
+		BUG_ON(!twd_base);
+	}
 #endif
 	omap_dm_timer_init();
 
