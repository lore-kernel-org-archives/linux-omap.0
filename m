From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 08/11] OMAP3: PRCM: Consider UART4 for 3630 chip in
     prcm_setup_regs
Date: Fri, 17 Sep 2010 21:37:33 +0530 (IST)
Message-ID: <14179.10.24.255.18.1284739653.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755067Ab0IQQHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 12:07:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

To standarize among other uarts (1 to 3), we shall now:

 - Enable uart4 autodile bit.
 - Enable uart4 wakeup in PER.
 - Allow uart4 to wakeup the MPU.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h  |    2 ++
 arch/arm/mach-omap2/pm34xx.c           |   15 +++++++++++++--
 arch/arm/mach-omap2/prcm-common.h      |    2 ++
 arch/arm/mach-omap2/prm-regbits-34xx.h |    1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index fe82b79..4f959a7 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -649,6 +649,8 @@
 #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)

 /* CM_AUTOIDLE_PER */
+#define OMAP3630_AUTO_UART4_MASK			(1 << 18)
+#define OMAP3630_AUTO_UART4_SHIFT			18
 #define OMAP3430_AUTO_GPIO6_MASK			(1 << 17)
 #define OMAP3430_AUTO_GPIO6_SHIFT			17
 #define OMAP3430_AUTO_GPIO5_MASK			(1 << 16)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b03426..13bf73f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -756,6 +756,14 @@ static void __init omap3_d2d_idle(void)

 static void __init prcm_setup_regs(void)
 {
+	u32 omap3630_auto_uart4_mask = cpu_is_omap3630() ?
+					OMAP3630_AUTO_UART4_MASK : 0;
+	u32 omap3630_en_uart4_mask = cpu_is_omap3630() ?
+					OMAP3630_EN_UART4_MASK : 0;
+	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
+					OMAP3630_GRPSEL_UART4_MASK : 0;
+
+
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
@@ -842,6 +850,7 @@ static void __init prcm_setup_regs(void)
 		CM_AUTOIDLE);

 	cm_write_mod_reg(
+		omap3630_auto_uart4_mask |
 		OMAP3430_AUTO_GPIO6_MASK |
 		OMAP3430_AUTO_GPIO5_MASK |
 		OMAP3430_AUTO_GPIO4_MASK |
@@ -918,14 +927,16 @@ static void __init prcm_setup_regs(void)
 				OMAP3430_DSS_MOD, PM_WKEN);

 	/* Enable wakeups in PER */
-	prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
+	prm_write_mod_reg(omap3630_en_uart4_mask |
+			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
 			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
 			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
 			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
 			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
+	prm_write_mod_reg(omap3630_grpsel_uart4_mask |
+			  OMAP3430_GRPSEL_GPIO2_MASK |
 			  OMAP3430_GRPSEL_GPIO3_MASK |
 			  OMAP3430_GRPSEL_GPIO4_MASK |
 			  OMAP3430_GRPSEL_GPIO5_MASK |
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 86edcf9..298a22a 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -425,6 +425,8 @@
 #define OMAP3430_EN_MCBSP2_SHIFT			0

 /* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3630_ST_UART4_SHIFT				18
+#define OMAP3630_ST_UART4_MASK				(1 << 18)
 #define OMAP3430_ST_GPIO6_SHIFT				17
 #define OMAP3430_ST_GPIO6_MASK				(1 << 17)
 #define OMAP3430_ST_GPIO5_SHIFT				16
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 7fd6023..9e63cb7 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -122,6 +122,7 @@
 #define OMAP3430_MEMRETSTATE_MASK			(1 << 8)

 /* PM_MPUGRPSEL_PER, PM_IVA2GRPSEL_PER shared bits */
+#define OMAP3630_GRPSEL_UART4_MASK			(1 << 18)
 #define OMAP3430_GRPSEL_GPIO6_MASK			(1 << 17)
 #define OMAP3430_GRPSEL_GPIO5_MASK			(1 << 16)
 #define OMAP3430_GRPSEL_GPIO4_MASK			(1 << 15)
-- 
1.6.3.3




