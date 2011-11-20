From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 06/11] arm:omap:am33xx: Integrate clock & clockdomain to OMAP clock framework
Date: Sun, 20 Nov 2011 22:49:10 +0530
Message-ID: <1321809555-13833-7-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab1KTRTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 12:19:49 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Hook up AM33XX clock & clock domain data to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    4 +++-
 arch/arm/mach-omap2/clock3xxx_data.c       |    5 +++--
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   18 ++++++++++++++++--
 arch/arm/mach-omap2/io.c                   |    1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b5f20d2..19330dc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -81,7 +81,7 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_SOC_OMAPAM33XX)		+= prminst33xx.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= prminst33xx.o cm33xx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
@@ -127,6 +127,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o \
 					   clockdomains3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
@@ -145,6 +146,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock3517.o clock36xx.o \
 					   dpll3xxx.o clock3xxx_data.o \
 					   clkt_iclk.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= clock33xx_data.o clock33xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index c1ab6bc..9fe72da 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -27,6 +27,7 @@
 #include "clock34xx.h"
 #include "clock36xx.h"
 #include "clock3517.h"
+#include "clock33xx.h"

 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
@@ -3518,8 +3519,8 @@ int __init omap3xxx_clk_init(void)
 		cpu_mask = RATE_IN_TI816X;
 		cpu_clkflg = CK_TI816X;
 	} else if (cpu_is_am33xx()) {
-		cpu_mask = RATE_IN_AM33XX;
-		cpu_clkflg = CK_AM33XX;
+		am33xx_clk_init();
+		return 0;
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index a0d68db..edcab10 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -147,6 +147,9 @@ static void _enable_hwsup(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx())
 		omap2xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 					       clkdm->clktrctrl_mask);
+	else if (cpu_is_am33xx())
+		am33xx_cm_clkdm_enable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs,
+					       clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
 		omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 					       clkdm->clktrctrl_mask);
@@ -157,6 +160,9 @@ static void _disable_hwsup(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx())
 		omap2xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);
+	else if (cpu_is_am33xx())
+		am33xx_cm_clkdm_disable_hwsup(clkdm->cm_inst, clkdm->clkdm_offs,
+					       clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
 		omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 						clkdm->clktrctrl_mask);
@@ -211,14 +217,22 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)

 static int omap3_clkdm_sleep(struct clockdomain *clkdm)
 {
-	omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
+	if (cpu_is_am33xx())
+		am33xx_cm_clkdm_force_sleep(clkdm->cm_inst, clkdm->clkdm_offs,
+				clkdm->clktrctrl_mask);
+	else
+		omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 	return 0;
 }

 static int omap3_clkdm_wakeup(struct clockdomain *clkdm)
 {
-	omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
+	if (cpu_is_am33xx())
+		am33xx_cm_clkdm_force_wakeup(clkdm->cm_inst, clkdm->clkdm_offs,
+				clkdm->clktrctrl_mask);
+	else
+		omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7ea23d8..82e2817 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -467,6 +467,7 @@ void __init am33xx_init_early(void)
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
+	am33xx_clockdomains_init();
 	omap3xxx_clk_init();
 }
 #endif
--
1.7.0.4

