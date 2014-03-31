From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 19/55] ARM: OMAP3: PRM: remove references to prm-regbits-34xx.h from PRM core code
Date: Mon, 31 Mar 2014 18:15:58 +0300
Message-ID: <1396278994-12624-20-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbaCaPRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:17:51 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make PRM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c |   54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index f1d3e15..8ae209a 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -23,10 +23,62 @@
 #include "prm3xxx.h"
 #include "prm2xxx_3xxx_private.h"
 #include "cm2xxx_3xxx_private.h"
-#include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
+#define OMAP3430_GLOBAL_COLD_RST_MASK			(1 << 0)
+#define OMAP3430_GLOBAL_COLD_RST_SHIFT			0
+#define OMAP3430_GLOBAL_SW_RST_SHIFT			1
+#define OMAP3430_SECURITY_VIOL_RST_SHIFT		3
+#define OMAP3430_MPU_WD_RST_SHIFT			4
+#define OMAP3430_SECURE_WD_RST_SHIFT			5
+#define OMAP3430_EXTERNAL_WARM_RST_SHIFT		6
+#define OMAP3430_VDD1_VOLTAGE_MANAGER_RST_SHIFT		7
+#define OMAP3430_VDD2_VOLTAGE_MANAGER_RST_SHIFT		8
+#define OMAP3430_ICEPICK_RST_SHIFT			9
+#define OMAP3430_ICECRUSHER_RST_SHIFT			10
+
+#define OMAP3430_VP1_TRANXDONE_ST_MASK			(1 << 15)
+#define OMAP3430_VP2_TRANXDONE_ST_MASK			(1 << 21)
+
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK	(1 << 0)
+#define OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK	(1 << 1)
+
+#define OMAP3430_PM_WKEN_DSS_EN_DSS_MASK		(1 << 0)
+
+#define OMAP3430_GRPSEL_GPT1_MASK			(1 << 0)
+#define OMAP3430_GRPSEL_GPT12_MASK			(1 << 1)
+#define OMAP3430_GRPSEL_GPIO1_MASK			(1 << 3)
+#define OMAP3430_GRPSEL_MCBSP2_MASK			(1 << 0)
+#define OMAP3430_GRPSEL_MCBSP3_MASK			(1 << 1)
+#define OMAP3430_GRPSEL_MCBSP4_MASK			(1 << 2)
+#define OMAP3430_GRPSEL_UART3_MASK			(1 << 11)
+#define OMAP3430_GRPSEL_GPIO2_MASK			(1 << 13)
+#define OMAP3430_GRPSEL_GPIO3_MASK			(1 << 14)
+#define OMAP3430_GRPSEL_GPIO4_MASK			(1 << 15)
+#define OMAP3430_GRPSEL_GPIO5_MASK			(1 << 16)
+#define OMAP3430_GRPSEL_GPIO6_MASK			(1 << 17)
+#define OMAP3630_GRPSEL_UART4_MASK			(1 << 18)
+
+#define OMAP3430_EN_IO_MASK				(1 << 8)
+#define OMAP3430_EN_IO_CHAIN_MASK			(1 << 16)
+#define OMAP3430_ST_IO_CHAIN_MASK			(1 << 16)
+
+#define OMAP3430ES2_SAVEANDRESTORE_SHIFT		4
+
+#define OMAP3430_LASTLOGICSTATEENTERED_MASK		(1 << 2)
+#define OMAP3430_LASTMEM1STATEENTERED_MASK		(0x3 << 4)
+#define OMAP3430_LASTMEM2STATEENTERED_MASK		(0x3 << 6)
+#define OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK	(0x3 << 8)
+#define OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK		(0x3 << 10)
+
+#define OMAP3430_RST1_IVA2_MASK				(1 << 0)
+#define OMAP3430_RST2_IVA2_MASK				(1 << 1)
+#define OMAP3430_RST3_IVA2_MASK				(1 << 2)
+
+#define OMAP3430_LASTPOWERSTATEENTERED_MASK		(0x3 << 0)
+#define OMAP3430_LOGICSTATEST_MASK			(1 << 2)
+
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
 	OMAP_PRCM_IRQ("io",	9,	1),
-- 
1.7.9.5

