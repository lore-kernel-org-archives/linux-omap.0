From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 13:41:10 +0530
Message-ID: <1285834270-32766-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51458 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab0I3ILe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 04:11:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

With OMAP2PLUS watchdog implemented in hwmod fw way, the
module is reset during init.

After a watchdog timer module reset, the WDTs are enabled. The
default time for a system reset after a watchdog module reset
is ~10s as per the default value of the WDT registers. Hence
the system would be reset after 10s, if watchdog is not disabled
within 10s.

This patch fixes the above issue by disabling the watchdog timer
after reset during initialization of devices.

Signed-off-by: Charulatha V <charu@ti.com>
Reported-by: Kevin Hilman <khilman@deeprootsystems.com>
---
This patch is dependent on the below patch series (wdt hwmod) and
is created on top of pm-core branch.
http://www.spinics.net/lists/linux-omap/msg37043.html

 arch/arm/mach-omap2/devices.c |   44 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8e2f0aa..9f44fc6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -916,11 +916,55 @@ static inline void omap_init_vout(void) {}
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * WDT mdoule is reset during init which enables the watchdog.
+ * Hence it is required to disable the watchdog after the WDT reset
+ * during init. Otherwise the system would reboot as per the default
+ * watchdog timer registers settings.
+ */
+#define OMAP_WDT_WPS	(0x34)
+#define OMAP_WDT_SPR	(0x48)
+
+static int omap2_disable_wdt(struct omap_hwmod *oh, void *user)
+{
+	void __iomem *base;
+
+	if (!oh)
+		pr_err("Could not look up wdtimer_hwmod\n");
+
+	base = oh->_mpu_rt_va;
+
+	/* Enable the clocks before accessing the WDT registers */
+	omap_hwmod_enable(oh);
+
+	/* sequence required to disable watchdog */
+	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);	/* TIMER_MODE */
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	__raw_writel(0x5555, base + OMAP_WDT_SPR);	/* TIMER_MODE */
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	omap_hwmod_idle(oh);
+
+	return 0;
+}
+
+static void __init omap_disable_wdt(void)
+{
+	if (cpu_class_is_omap2())
+		omap_hwmod_for_each_by_class("wd_timer",
+						omap2_disable_wdt, NULL);
+	return;
+}
+
 static int __init omap2_init_devices(void)
 {
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_disable_wdt();
 	omap_hsmmc_reset();
 	omap_init_camera();
 	omap_init_mbox();
-- 
1.7.0.4

