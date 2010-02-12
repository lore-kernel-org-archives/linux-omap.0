From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/19] AM35xx: Add AM35xx intr_clr & sw_rst cntrl reg bit
	definition
Date: Thu, 11 Feb 2010 16:51:41 -0800
Message-ID: <20100212005140.24958.84990.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53812 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab0BLAu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:50:59 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

AM3517/05 has few additional control module registers to control
the new IP's, like VPFE, USBOTG, CPGMAC.

This patch adds the bit defination for INTR_CLR and SW_RST control
register.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index fcdc71b..2074473 100644
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

