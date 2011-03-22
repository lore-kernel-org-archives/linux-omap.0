From: Sriramakrishnan A G <srk@ti.com>
Subject: [PATCH] omap3: am3517evm : Read MAC address from E-Fuses
Date: Tue, 22 Mar 2011 18:55:06 +0530
Message-ID: <1300800306-17846-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189Ab1CVNZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 09:25:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: srk@ti.com, tony@atomide.com

MAC address is programmed in the e-fuses accessible through
Control module space. Board init code reads the programmed value
from e-fuse and passes this information to the driver.

Signed-off-by: Sriramakrishnan A G <srk@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   12 +++++++++++-
 arch/arm/mach-omap2/control.h         |    2 ++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 77541cf..177c65d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -128,7 +128,17 @@ static void am3517_disable_ethernet_int(void)
 
 static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
 {
-	unsigned int regval;
+	u32 regval, mac_lo, mac_hi;
+
+	mac_lo = omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_LSB);
+	mac_hi = omap_ctrl_readl(AM35XX_CONTROL_FUSE_EMAC_MSB);
+
+	pdata->mac_addr[0] = (u_int8_t)((mac_hi & 0xFF0000) >> 16);
+	pdata->mac_addr[1] = (u_int8_t)((mac_hi & 0xFF00) >> 8);
+	pdata->mac_addr[2] = (u_int8_t)((mac_hi & 0xFF) >> 0);
+	pdata->mac_addr[3] = (u_int8_t)((mac_lo & 0xFF0000) >> 16);
+	pdata->mac_addr[4] = (u_int8_t)((mac_lo & 0xFF00) >> 8);
+	pdata->mac_addr[5] = (u_int8_t)((mac_lo & 0xFF) >> 0);
 
 	pdata->ctrl_reg_offset		= AM35XX_EMAC_CNTRL_OFFSET;
 	pdata->ctrl_mod_reg_offset	= AM35XX_EMAC_CNTRL_MOD_OFFSET;
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c2804c1..8b6cc4f 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -198,6 +198,8 @@
 
 /* AM35XX only CONTROL_GENERAL register offsets */
 #define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
+#define AM35XX_CONTROL_FUSE_EMAC_LSB	(OMAP2_CONTROL_GENERAL + 0x0110)
+#define AM35XX_CONTROL_FUSE_EMAC_MSB	(OMAP2_CONTROL_GENERAL + 0x0114)
 #define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
 #define AM35XX_CONTROL_DEVCONF3         (OMAP2_CONTROL_GENERAL + 0x0314)
 #define AM35XX_CONTROL_CBA_PRIORITY     (OMAP2_CONTROL_GENERAL + 0x0320)
-- 
1.6.2.4

