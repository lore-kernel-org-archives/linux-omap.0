From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 33/55] ARM: AM33xx: PRM: move global warm reset implementation to driver
Date: Mon, 31 Mar 2014 18:16:12 +0300
Message-ID: <1396278994-12624-34-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39151 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbaCaPSX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:18:23 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Moved the implementation from am33xx-restart.c to the prm33xx.c file to
isolate the PRM register accesses to be private for PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/am33xx-restart.c |    9 +--------
 arch/arm/mach-omap2/prm33xx.c        |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx-restart.c b/arch/arm/mach-omap2/am33xx-restart.c
index c88d8df7..7286389 100644
--- a/arch/arm/mach-omap2/am33xx-restart.c
+++ b/arch/arm/mach-omap2/am33xx-restart.c
@@ -24,12 +24,5 @@ void am33xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	/* TODO: Handle mode and cmd if necessary */
 
-	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
-				AM33XX_RST_GLOBAL_WARM_SW_MASK,
-				AM33XX_PRM_DEVICE_MOD,
-				AM33XX_PRM_RSTCTRL_OFFSET);
-
-	/* OCP barrier */
-	(void)am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
-				  AM33XX_PRM_RSTCTRL_OFFSET);
+	am33xx_prm_global_warm_sw_reset();
 }
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 877d7c7..a08b1da 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -29,6 +29,10 @@
 #define AM33XX_LOWPOWERSTATECHANGE_SHIFT	4
 #define AM33XX_LOWPOWERSTATECHANGE_MASK		(1 << 4)
 
+#define AM33XX_PRM_RSTCTRL_OFFSET		0x0000
+
+#define AM33XX_RST_GLOBAL_WARM_SW_MASK		(1 << 0)
+
 /* Read a register in a PRM instance */
 u32 am33xx_prm_read_reg(s16 inst, u16 idx)
 {
@@ -331,6 +335,18 @@ static int am33xx_check_vcvp(void)
 	return 0;
 }
 
+void am33xx_prm_global_warm_sw_reset(void)
+{
+	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
+				AM33XX_RST_GLOBAL_WARM_SW_MASK,
+				AM33XX_PRM_DEVICE_MOD,
+				AM33XX_PRM_RSTCTRL_OFFSET);
+
+	/* OCP barrier */
+	(void)am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
+				  AM33XX_PRM_RSTCTRL_OFFSET);
+}
+
 struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
-- 
1.7.9.5

