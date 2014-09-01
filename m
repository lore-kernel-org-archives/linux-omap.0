From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/26] ARM: AM33xx: PRM: add support for prm_init
Date: Mon, 1 Sep 2014 21:09:02 +0300
Message-ID: <1409594955-1476-14-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675AbaIASKG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:06 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Added support for prm_init for AM33xx SoC. This is needed to register
SoC specific prm_ll_data for these devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c      |    2 ++
 arch/arm/mach-omap2/prm33xx.c |   13 +++++++++++++
 arch/arm/mach-omap2/prm33xx.h |    2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 26055d9..f1db801 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -53,6 +53,7 @@
 #include "cminst44xx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
+#include "prm33xx.h"
 #include "prm44xx.h"
 #include "opp2xxx.h"
 
@@ -583,6 +584,7 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
+	am33xx_prm_init();
 	am33xx_cm_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 62709cd..f149e7c 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -342,3 +342,16 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_wait_transition		= am33xx_pwrdm_wait_transition,
 	.pwrdm_has_voltdm		= am33xx_check_vcvp,
 };
+
+static struct prm_ll_data am33xx_prm_ll_data;
+
+int __init am33xx_prm_init(void)
+{
+	return prm_register(&am33xx_prm_ll_data);
+}
+
+static void __exit am33xx_prm_exit(void)
+{
+	prm_unregister(&am33xx_prm_ll_data);
+}
+__exitcall(am33xx_prm_exit);
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 9b9918d..5cdfdc0 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -127,5 +127,7 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
 extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
+int am33xx_prm_init(void);
+
 #endif /* ASSEMBLER */
 #endif
-- 
1.7.9.5

