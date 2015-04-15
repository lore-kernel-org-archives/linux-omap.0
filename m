From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 33/35] ARM: OMAP3: pdata-quirks: add hwmod module platform data
Date: Wed, 15 Apr 2015 15:53:20 +0300
Message-ID: <1429102402-5276-34-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47088 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbbDOMxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:24 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h   |    8 ++++++++
 arch/arm/mach-omap2/pdata-quirks.c |   11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3ff9133..0c7eaf8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -692,6 +692,14 @@ struct omap_hwmod {
 	struct omap_hwmod		*parent_hwmod;
 };
 
+enum {
+	OMAP_HWMOD_PTR_DSS_RESET = 0,
+	OMAP_HWMOD_PTR_HDQ1W_RESET,
+	OMAP_HWMOD_PTR_I2C_RESET,
+	OMAP_HWMOD_PTR_WD_TIMER_DIS,
+	OMAP_HWMOD_PTR_WD_TIMER_RESET,
+};
+
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index ffdccd3..c2c414e 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -27,6 +27,8 @@
 #include "omap-secure.h"
 #include "soc.h"
 #include "clock.h"
+#include "hdq1w.h"
+#include "wd_timer.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -336,6 +338,14 @@ void omap_pcs_legacy_init(int irq, void (*rearm)(void))
 	pcs_pdata.rearm = rearm;
 }
 
+static void *omap_hwmod_pointers[] = {
+	[OMAP_HWMOD_PTR_DSS_RESET] = omap_dss_reset,
+	[OMAP_HWMOD_PTR_HDQ1W_RESET] = omap_hdq1w_reset,
+	[OMAP_HWMOD_PTR_I2C_RESET] = omap_i2c_reset,
+	[OMAP_HWMOD_PTR_WD_TIMER_DIS] = omap2_wd_timer_disable,
+	[OMAP_HWMOD_PTR_WD_TIMER_RESET] = omap2_wd_timer_reset,
+};
+
 /*
  * GPIOs for TWL are initialized by the I2C bus and need custom
  * handing until DSS has device tree bindings.
@@ -379,6 +389,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap3-l3", 0x0, "ocp", &omap_hwmod_pointers),
 	/* Only on am3517 */
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
-- 
1.7.9.5

