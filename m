From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 09/11] arm:omap:am33xx: Integrate AM33XX hwmods to omap HWMOD framework
Date: Sun, 20 Nov 2011 22:49:13 +0530
Message-ID: <1321809555-13833-10-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab1KTRT4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Nov 2011 12:19:56 -0500
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>

Hook up AM33XX HWMOD data to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile     |    1 +
 arch/arm/mach-omap2/io.c         |    2 ++
 arch/arm/mach-omap2/omap_hwmod.c |   13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 19330dc..706a8ef 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -168,6 +168,7 @@ obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2xxx_ipblock_data.o \
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o \
 					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
 					   omap_hwmod_3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o

 # EMU peripherals
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 82e2817..3afe4e6 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -468,6 +468,8 @@ void __init am33xx_init_early(void)
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
+	am33xx_hwmod_init();
+	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6b3088d..dfd3743 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1051,7 +1051,7 @@ static struct omap_hwmod *_lookup(const char *name)
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || (cpu_is_omap34xx() && !cpu_is_am33xx()))
 		return 0;

 	if (!oh->clkdm_name) {
@@ -1134,9 +1134,14 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	/* XXX check clock enable states */

 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
+		if (cpu_is_am33xx())
+			ret = am33xx_cm_wait_module_ready(oh->clkdm->cm_inst,
+						oh->prcm.omap4.clkctrl_offs);
+		else
+			ret = omap2_cm_wait_module_ready(
+						oh->prcm.omap2.module_offs,
+						oh->prcm.omap2.idlest_reg_id,
+						oh->prcm.omap2.idlest_idle_bit);
 	} else if (cpu_is_omap44xx()) {
 		if (!oh->clkdm)
 			return -EINVAL;
--
1.7.0.4

