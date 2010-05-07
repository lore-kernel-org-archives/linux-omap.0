From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/6] OMAP4: hwmod: Enable omap_hwmod build for OMAP4
Date: Fri,  7 May 2010 18:07:00 +0200
Message-ID: <1273248424-15943-3-git-send-email-b-cousson@ti.com>
References: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713Ab0EGQHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 12:07:16 -0400
In-Reply-To: <1273248424-15943-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                 |    3 ++-
 arch/arm/mach-omap2/io.c                     |    6 ++++--
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..5acdba2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,7 +15,7 @@ clock-common				= clock.o clock_common_data.o \
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common) $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -82,6 +82,7 @@ obj-$(CONFIG_ARCH_OMAP2430)		+= opp2430_data.o
 obj-$(CONFIG_ARCH_OMAP2420)		+= omap_hwmod_2420_data.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3cfb425..687c629 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -324,6 +324,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap2430_hwmod_init();
 	else if (cpu_is_omap34xx())
 		omap3xxx_hwmod_init();
+	else if (cpu_is_omap44xx())
+		omap44xx_hwmod_init();
+
 	omap2_mux_init();
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
@@ -340,8 +343,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		pr_err("Could not init clock framework - unknown CPU\n");
 
 	omap_serial_early_init();
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
-		omap_hwmod_late_init();
+	omap_hwmod_late_init();
 	omap_pm_if_init();
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0eccc09..d0daa97 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -530,5 +530,6 @@ int omap_hwmod_for_each_by_class(const char *classname,
 extern int omap2420_hwmod_init(void);
 extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
+extern int omap44xx_hwmod_init(void);
 
 #endif
-- 
1.6.1.3

