From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: control: Add AM33XX control reg & sec
 clkctrl offset
Date: Fri, 27 Apr 2012 18:36:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204271834260.10308@utopia.booyaka.com>
References: <1332327499-29946-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47183 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757665Ab2D1Agl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 20:36:41 -0400
In-Reply-To: <1332327499-29946-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi Vaibhav

On Wed, 21 Mar 2012, Vaibhav Hiremath wrote:

> Define AM33XX control register, in order to allow access to
> control register address space, also add CONTROL_SEC_CLK_CTRL
> register offset; both are required in clock tree data,
> for wdt0 and timer0 clock source select configuration.
> 
> CONTROL.SEC_CLK_CTRL register is provided to select/configure
> clock input for WDT0 and TIMER0.

This patch has been updated so it builds, and also updated to add some 
AM33XX macros needed for the clock tree and to fix some control.h 
whitespace problems; updated version below.  Could you please take a quick 
look and see if it is okay with you?


- Paul

From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Thu, 19 Apr 2012 15:15:37 -0600
Subject: [PATCH] ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl
 offset

Define AM33XX control register, in order to allow access to
control register address space, also add CONTROL_SEC_CLK_CTRL
register offset; both are required in clock tree data,
for wdt0 and timer0 clock source select configuration.

CONTROL.SEC_CLK_CTRL register is provided to select/configure
clock input for WDT0 and TIMER0.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
[paul@pwsan.com: added include of plat/am33xx.h to fix build break;
 added AM33XX_CONTROL_STATUS bitfields that will be needed for the clock
 tree; fixed some control.h whitespace problems while here]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/control.h |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a406fd0..c43f03c 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -21,6 +21,8 @@
 #include <mach/ctrl_module_pad_core_44xx.h>
 #include <mach/ctrl_module_pad_wkup_44xx.h>
 
+#include <plat/am33xx.h>
+
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
@@ -28,6 +30,8 @@
 		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define AM33XX_CTRL_REGADDR(reg)					\
+		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
 #else
 #define OMAP242X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
@@ -35,6 +39,8 @@
 		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define AM33XX_CTRL_REGADDR(reg)					\
+		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -312,15 +318,15 @@
 						OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
-#define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
-#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT   1
-#define AM35XX_VPFE_VBUSP_CLK_SHIFT     2
-#define AM35XX_HECC_VBUSP_CLK_SHIFT     3
-#define AM35XX_USBOTG_FCLK_SHIFT        8
-#define AM35XX_CPGMAC_FCLK_SHIFT        9
-#define AM35XX_VPFE_FCLK_SHIFT          10
-
-/*AM35XX CONTROL_LVL_INTR_CLEAR bits*/
+#define AM35XX_USBOTG_VBUSP_CLK_SHIFT	0
+#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT	1
+#define AM35XX_VPFE_VBUSP_CLK_SHIFT	2
+#define AM35XX_HECC_VBUSP_CLK_SHIFT	3
+#define AM35XX_USBOTG_FCLK_SHIFT	8
+#define AM35XX_CPGMAC_FCLK_SHIFT	9
+#define AM35XX_VPFE_FCLK_SHIFT		10
+
+/* AM35XX CONTROL_LVL_INTR_CLEAR bits */
 #define AM35XX_CPGMAC_C0_MISC_PULSE_CLR	BIT(0)
 #define AM35XX_CPGMAC_C0_RX_PULSE_CLR	BIT(1)
 #define AM35XX_CPGMAC_C0_RX_THRESH_CLR	BIT(2)
@@ -330,21 +336,22 @@
 #define AM35XX_VPFE_CCDC_VD1_INT_CLR	BIT(6)
 #define AM35XX_VPFE_CCDC_VD2_INT_CLR	BIT(7)
 
-/*AM35XX CONTROL_IP_SW_RESET bits*/
+/* AM35XX CONTROL_IP_SW_RESET bits */
 #define AM35XX_USBOTGSS_SW_RST		BIT(0)
 #define AM35XX_CPGMACSS_SW_RST		BIT(1)
 #define AM35XX_VPFE_VBUSP_SW_RST	BIT(2)
 #define AM35XX_HECC_SW_RST		BIT(3)
 #define AM35XX_VPFE_PCLK_SW_RST		BIT(4)
 
-/*
- * CONTROL AM33XX STATUS register
- */
+/* AM33XX CONTROL_STATUS register */
 #define AM33XX_CONTROL_STATUS		0x040
+#define AM33XX_CONTROL_SEC_CLK_CTRL	0x1bc
 
-/*
- * CONTROL OMAP STATUS register to identify OMAP3 features
- */
+/* AM33XX CONTROL_STATUS bitfields (partial) */
+#define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
+#define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
+
+/* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
 #define OMAP3_SGX_SHIFT			13
-- 
1.7.10

