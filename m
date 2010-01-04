From: hvaibhav@ti.com
Subject: [PATCH 1/3] AM35xx: Add AM35xx intr_clr & sw_rst cntrl reg bit defination
Date: Mon,  4 Jan 2010 19:21:54 +0530
Message-ID: <1262613116-20185-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0ADNwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 08:52:05 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

AM3517/05 has few additional control module registers to control
the new IP's, like VPFE, USBOTG, CPGMAC.

This patch adds the bit defination for INTR_CLR and SW_RST control
register.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 6683419..5c15154 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -274,6 +274,23 @@
 #define AM35XX_CPGMAC_FCLK_SHIFT        9
 #define AM35XX_VPFE_FCLK_SHIFT          10
 
+/*AM35XX CONTROL_LVL_INTR_CLEAR bits*/
+#define AM35XX_CPGMAC_C0_MISC_PULSE_CLR	BIT(0)
+#define AM35XX_CPGMAC_C0_RX_PULSE_CLR	BIT(1)
+#define AM35XX_CPGMAC_C0_RX_THRESH_CLR	BIT(2)
+#define AM35XX_CPGMAC_C0_TX_PULSE_CLR	BIT(3)
+#define AM35XX_USBOTGSS_INT_CLR		BIT(4)
+#define AM35XX_VPFE_CCDC_VD0_INT_CLR	BIT(5)
+#define AM35XX_VPFE_CCDC_VD1_INT_CLR	BIT(6)
+#define AM35XX_VPFE_CCDC_VD2_INT_CLR	BIT(7)
+
+/*AM35XX CONTROL_IP_SW_RESET bits*/
+#define AM35XX_USBOTGSS_SW_RST		BIT(0)
+#define AM35XX_CPGMACSS_SW_RST		BIT(1)
+#define AM35XX_VPFE_VBUSP_SW_RST	BIT(2)
+#define AM35XX_HECC_SW_RST		BIT(3)
+#define AM35XX_VPFE_PCLK_SW_RST		BIT(4)
+
 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */
-- 
1.6.2.4

