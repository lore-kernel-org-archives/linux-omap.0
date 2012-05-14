From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 15/19] ARM: OMAP4430: PM: workaround for DDR corruption on second CS
Date: Mon, 14 May 2012 13:18:46 +0300
Message-ID: <1336990730-26892-16-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755889Ab2ENKTq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 06:19:46 -0400
In-Reply-To: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
The issue occurs when EMIF_SDRAM_CONFIG is restored first before
EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
is not set properly, we apply the required workaround allowing
the restore sequence to work properly.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../include/mach/ctrl_module_wkup_44xx.h           |    2 +
 arch/arm/mach-omap2/pm44xx.c                       |   37 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
index a0af9ba..b763a79 100644
--- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
+++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
@@ -28,6 +28,8 @@
 #define OMAP4_CTRL_MODULE_WKUP_IP_REVISION		0x0000
 #define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO		0x0004
 #define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG		0x0010
+#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG	0x0114
+#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG	0x011c
 #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0	0x0460
 #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1	0x0464
 #define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2	0x0468
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 215b80e..dfaa254 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -17,12 +17,18 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <asm/system_misc.h>
+#include <linux/io.h>
+
+#include <mach/ctrl_module_wkup_44xx.h>
+#include <mach/hardware.h>
 
 #include "common.h"
 #include "clockdomain.h"
 #include "powerdomain.h"
 #include "pm.h"
 
+#define EMIF_SDRAM_CONFIG2_OFFSET	0xc
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -215,6 +221,37 @@ static int __init omap4_pm_init(void)
 
 	pr_err("Power Management for TI OMAP4.\n");
 
+	/*
+	 * Work around for OMAP443x Errata i632: "LPDDR2 Corruption After OFF
+	 * Mode Transition When CS1 Is Used On EMIF":
+	 * Overwrite EMIF1/EMIF2
+	 * SECURE_EMIF1_SDRAM_CONFIG2_REG
+	 * SECURE_EMIF2_SDRAM_CONFIG2_REG
+	 */
+	if (cpu_is_omap443x()) {
+		void __iomem *secure_ctrl_mod;
+		void __iomem *emif1;
+		void __iomem *emif2;
+		u32 val;
+
+		secure_ctrl_mod = ioremap(OMAP4_CTRL_MODULE_WKUP, SZ_4K);
+		emif1 = ioremap(OMAP44XX_EMIF1_BASE, SZ_1M);
+		emif2 = ioremap(OMAP44XX_EMIF2_BASE, SZ_1M);
+
+		BUG_ON(!secure_ctrl_mod || !emif1 || !emif2);
+
+		val = __raw_readl(emif1 + EMIF_SDRAM_CONFIG2_OFFSET);
+		__raw_writel(val, secure_ctrl_mod +
+			     OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG);
+		val = __raw_readl(emif2 + EMIF_SDRAM_CONFIG2_OFFSET);
+		__raw_writel(val, secure_ctrl_mod +
+			     OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG);
+		wmb();
+		iounmap(secure_ctrl_mod);
+		iounmap(emif1);
+		iounmap(emif2);
+	}
+
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		pr_err("Failed to setup powerdomains\n");
-- 
1.7.4.1

