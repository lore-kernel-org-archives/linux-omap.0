From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 4 Apr 2014 15:40:29 +0530
Message-ID: <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbaDDKLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Apr 2014 06:11:08 -0400
In-Reply-To: <cover.1396605300.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

Add support for L2 cache controller (PL310) on
AM437x SoC.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/io.c           |    1 +
 arch/arm/mach-omap2/omap4-common.c |    8 ++++++++
 4 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1124155..1fd34d2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,7 @@ config SOC_AM43XX
 	select ARCH_HAS_OPP
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
+	select MIGHT_HAVE_CACHE_L2X0
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index c64d5f5..fc59b49 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -93,6 +93,7 @@ extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
 int omap4_l2_cache_init(void);
 extern void omap5_realtime_timer_init(void);
+int am43xx_l2_cache_init(void);
 
 void omap2420_init_early(void);
 void omap2430_init_early(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 81bc89c..131c207 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -609,6 +609,7 @@ void __init am43xx_init_early(void)
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	am43xx_l2_cache_init();
 	omap_clk_soc_init = am43xx_dt_clk_init;
 }
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index f8b8dac..6b2a056 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
 
 	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
 }
+
+int __init am43xx_l2_cache_init(void)
+{
+	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
+		       L310_AUX_CTRL_INSTR_PREFETCH;
+
+	return omap_l2_cache_init(aux_ctrl, 0xcfffffff);
+}
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
-- 
1.7.10.1

