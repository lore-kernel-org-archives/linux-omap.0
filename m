From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 03/11] OMAP4: Add the new voltage to vsel calculation formula
Date: Sat, 25 Sep 2010 18:21:18 +0530
Message-ID: <1285419086-13047-4-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53964 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0IYMvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 08:51:38 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

TWL6030 the power IC used along with OMAP4 in OMAP4 SDPs,
blaze boards and panda boards has a different formula
from that of TWL4030 for voltage to vsel and
vsel to voltage calculation. This patch implements the new
formula depending on the PMIC type.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/opp_twl_tps.c |   71 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-omap/opp_twl_tps.c
index 4448fc5..358b67b 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -15,9 +15,16 @@
 
 #include <linux/module.h>
 
+#include <linux/i2c/twl.h>
+
 #include <plat/opp_twl_tps.h>
 #include <plat/voltage.h>
 
+static bool is_offset_valid;
+static u8 smps_offset;
+
+#define REG_SMPS_OFFSET         0xE0
+
 /**
  * omap_twl_vsel_to_vdc - convert TWL/TPS VSEL value to microvolts DC
  * @vsel: TWL/TPS VSEL value to convert
@@ -27,6 +34,38 @@
  */
 unsigned long omap_twl_vsel_to_uv(const u8 vsel)
 {
+	if (twl_class_is_6030()) {
+		/*
+		 * In TWL6030 depending on the value of SMPS_OFFSET
+		 * efuse register the voltage range supported in
+		 * standard mode can be either between 0.6V - 1.3V or
+		 * 0.7V - 1.4V. In TWL6030 ES1.0 SMPS_OFFSET efuse
+		 * is programmed to all 0's where as starting from
+		 * TWL6030 ES1.1 the efuse is programmed to 1
+		 */
+		if (!is_offset_valid) {
+			twl_i2c_read_u8(TWL6030_MODULE_ID0, &smps_offset, 0xE0);
+			is_offset_valid = true;
+		}
+
+		if (smps_offset & 0x8) {
+			return ((((vsel - 1) * 125) + 7000)) * 100;
+		} else {
+			/*
+			 * In case of the supported voltage range being
+			 * between 0.6V - 1.3V, there is not specific
+			 * formula for voltage to vsel conversion above
+			 * 1.3V. There are special hardcoded values for
+			 * voltages above 1.3V. Currently we are hardcodig
+			 * only for 1.35 V which is used for 1GH OPP for
+			 * OMAP4430.
+			 */
+			if (vsel == 0x3A)
+				return 1350000;
+			return ((((vsel - 1) * 125) + 6000)) * 100;
+		}
+	}
+
 	return (((vsel * 125) + 6000)) * 100;
 }
 
@@ -40,6 +79,38 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
 	/* Round up to higher voltage */
+	if (twl_class_is_6030()) {
+		/*
+		 * In TWL6030 depending on the value of SMPS_OFFSET
+		 * efuse register the voltage range supported in
+		 * standard mode can be either between 0.6V - 1.3V or
+		 * 0.7V - 1.4V. In TWL6030 ES1.0 SMPS_OFFSET efuse
+		 * is programmed to all 0's where as starting from
+		 * TWL6030 ES1.1 the efuse is programmed to 1
+		 */
+		if (!is_offset_valid) {
+			twl_i2c_read_u8(TWL6030_MODULE_ID0, &smps_offset, 0xE0);
+			is_offset_valid = true;
+		}
+
+		if (smps_offset & 0x8) {
+			return DIV_ROUND_UP(uv - 700000, 12500) + 1;
+		} else {
+			/*
+			 * In case of the supported voltage range being
+			 * between 0.6V - 1.3V, there is not specific
+			 * formula for voltage to vsel conversion above
+			 * 1.3V. There are special hardcoded values for
+			 * voltages above 1.3V. Currently we are hardcodig
+			 * only for 1.35 V which is used for 1GH OPP for
+			 * OMAP4430.
+			 */
+			if (uv == 1350000)
+				return 0x3A;
+			return DIV_ROUND_UP(uv - 600000, 12500) + 1;
+		}
+	}
+
 	return DIV_ROUND_UP(uv - 600000, 12500);
 }
 
-- 
1.7.0.4

