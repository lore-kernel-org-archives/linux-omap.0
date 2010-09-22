From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 11/11] OMAP3: PM: Register TWL4030 pmic info with the voltage driver.
Date: Wed, 22 Sep 2010 20:15:19 +0530
Message-ID: <1285166719-19352-12-git-send-email-thara@ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956Ab0IVOpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:45:55 -0400
In-Reply-To: <1285166719-19352-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch registers the TWL4030 PMIC specific informtion
with the voltage driver. Failing this patch the voltage driver
is unware of the formula to use for vsel to voltage and vice versa
conversion.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp_twl_tps.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index 112f106..4448fc5 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -13,7 +13,10 @@
  * XXX This code should be part of some other TWL/TPS code.
  */
 
+#include <linux/module.h>
+
 #include <plat/opp_twl_tps.h>
+#include <plat/voltage.h>
 
 /**
  * omap_twl_vsel_to_vdc - convert TWL/TPS VSEL value to microvolts DC
@@ -39,3 +42,17 @@ u8 omap_twl_uv_to_vsel(unsigned long uv)
 	/* Round up to higher voltage */
 	return DIV_ROUND_UP(uv - 600000, 12500);
 }
+
+static struct omap_volt_pmic_info twl_volt_info = {
+	.slew_rate	= 4000,
+	.step_size	= 12500,
+	.vsel_to_uv	= omap_twl_vsel_to_uv,
+	.uv_to_vsel	= omap_twl_uv_to_vsel,
+};
+
+static int __init omap_twl_init(void)
+{
+	omap_voltage_register_pmic(&twl_volt_info);
+	return 0;
+}
+arch_initcall(omap_twl_init);
-- 
1.7.1.GIT

