From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v2] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Sat,  2 Oct 2010 16:06:11 +0530
Message-ID: <1286015771-22041-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58265 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086Ab0JBKhS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Oct 2010 06:37:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Inorder to avoid any assumptions from bootloader, the watchdog
timer module is reset during init. This enables the watchdog
timer.

Therefore, it is required to disable WDT after it is reset
during init. Otherwise the system would reboot as per the default
watchdog timer registers settings.

Later, when the watchdog driver is loaded, the watchdog timer settings
is adjusted as per the default timer_margin set in the driver and the
driver would supports the normal operations supported by OMAP watchdog
timer.

Link to related discussions:
https://patchwork.kernel.org/patch/219072/

Issue reported by Kevin can be found at:
https://patchwork.kernel.org/patch/217262/

Signed-off-by: Charulatha V <charu@ti.com>
Reported-by: Kevin Hilman <khilman@deeprootsystems.com>
---
This patch is dependent on the below patch series (wdt hwmod) and
is created on top of pm-core branch. It also applies on pm-hwmods branch.
http://www.spinics.net/lists/linux-omap/msg37043.html

 arch/arm/mach-omap2/devices.c |   59 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8e2f0aa..6eaec8d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -916,11 +916,72 @@ static inline void omap_init_vout(void) {}
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Inorder to avoid any assumptions from bootloader regarding WDT
+ * settings, WDT module is reset during init. This enables the watchdog
+ * timer. Hence it is required to disable the watchdog after the WDT reset
+ * during init. Otherwise the system would reboot as per the default
+ * watchdog timer registers settings.
+ */
+#define OMAP_WDT_WPS	(0x34)
+#define OMAP_WDT_SPR	(0x48)
+
+static int omap2_disable_wdt(struct omap_hwmod *oh, void *unused)
+{
+	void __iomem *base;
+	int ret;
+
+	if (!oh) {
+		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
+		return -EINVAL;
+	}
+
+	base = omap_hwmod_get_mpu_rt_va(oh);
+	if (!base) {
+		pr_err("%s: Could not get the base address for %s\n",
+				oh->name, __func__);
+		return -EINVAL;
+	}
+
+	/* Enable the clocks before accessing the WDT registers */
+	ret = omap_hwmod_enable(oh);
+	if (ret) {
+		pr_err("%s: Could not enable clocks for %s\n",
+				oh->name, __func__);
+		return ret;
+	}
+
+	/* sequence required to disable watchdog */
+	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	__raw_writel(0x5555, base + OMAP_WDT_SPR);
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	ret = omap_hwmod_idle(oh);
+	if (ret)
+		pr_err("%s: Could not disable clocks for %s\n",
+				oh->name, __func__);
+
+	return ret;
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

