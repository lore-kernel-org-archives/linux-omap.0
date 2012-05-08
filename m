From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 4/4] ARM: OMAP2+: CLEANUP: Add new config option for different DPLL features
Date: Wed, 9 May 2012 01:22:04 +0530
Message-ID: <1336506724-5494-5-git-send-email-hvaibhav@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755597Ab2EHUER (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 16:04:17 -0400
In-Reply-To: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

This patch cleans up dpll_data structure, making structure
fields definition based on feature availability for given SoC,
managed using Kconfig rules.

SOC_HAS_OMAP3_DPLL_IDLE: idle state
SOC_HAS_OMAP3_DPLL_RECAL: recalibration capability
SOC_HAS_OMAP3_DPLL_DCO_SEL: dco selection
SOC_HAS_OMAP3_DPLL_SDDIV: sigma-delta div factor
SOC_HAS_OMAP3_DPLL_FREQSEL: frequency selection

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Kconfig             |   34 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |   14 ++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a432f3e..23999eb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -20,6 +20,21 @@ config ARCH_OMAP2PLUS_TYPICAL
 	help
 	  Compile a kernel suitable for booting most boards

+config SOC_HAS_OMAP3_DPLL_IDLE
+	bool "OMAP3 DPLL idle state support"
+
+config SOC_HAS_OMAP3_DPLL_RECAL
+	bool "OMAP3 DPLL Recalibration support"
+
+config SOC_HAS_OMAP3_DPLL_DCO_SEL
+	bool "OMAP3 DPLL DCO (Digitally Controlled Oscilators) support"
+
+config SOC_HAS_OMAP3_DPLL_SDDIV
+	bool "OMAP3 DPLL Sigma-Delta Divider support"
+
+config SOC_HAS_OMAP3_DPLL_FREQSEL
+	bool "OMAP3 DPLL Freq Select support"
+
 config SOC_HAS_OMAP2_SDRC
 	bool "OMAP2 SDRAM Controller support"

@@ -42,6 +57,11 @@ config ARCH_OMAP3
 	select ARM_CPU_SUSPEND if PM
 	select MULTI_IRQ_HANDLER
 	select SOC_HAS_OMAP2_SDRC
+	select SOC_HAS_OMAP3_DPLL_IDLE
+	select SOC_HAS_OMAP3_DPLL_RECAL
+	select SOC_HAS_OMAP3_DPLL_DCO_SEL
+	select SOC_HAS_OMAP3_DPLL_SDDIV
+	select SOC_HAS_OMAP3_DPLL_FREQSEL

 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -59,6 +79,9 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
+	select SOC_HAS_OMAP3_DPLL_IDLE
+	select SOC_HAS_OMAP3_DPLL_RECAL
+	select SOC_HAS_OMAP3_DPLL_SDDIV

 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
@@ -84,16 +107,27 @@ config SOC_OMAP3430
 	default y
 	select ARCH_OMAP_OTG
 	select SOC_HAS_OMAP2_SDRC
+	select SOC_HAS_OMAP3_DPLL_IDLE
+	select SOC_HAS_OMAP3_DPLL_RECAL
+	select SOC_HAS_OMAP3_DPLL_DCO_SEL
+	select SOC_HAS_OMAP3_DPLL_SDDIV
+	select SOC_HAS_OMAP3_DPLL_FREQSEL

 config SOC_OMAPTI81XX
 	bool "TI81XX support"
 	depends on ARCH_OMAP3
 	default y
+	select SOC_HAS_OMAP3_DPLL_IDLE
+	select SOC_HAS_OMAP3_DPLL_RECAL
+	select SOC_HAS_OMAP3_DPLL_SDDIV

 config SOC_OMAPAM33XX
 	bool "AM33XX support"
 	depends on ARCH_OMAP3
 	default y
+	select SOC_HAS_OMAP3_DPLL_IDLE
+	select SOC_HAS_OMAP3_DPLL_RECAL
+	select SOC_HAS_OMAP3_DPLL_SDDIV

 config OMAP_PACKAGE_ZAF
        bool
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..8d40de8 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -156,18 +156,26 @@ struct dpll_data {
 	u8			min_divider;
 	u16			max_divider;
 	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#if defined(CONFIG_SOC_HAS_OMAP3_DPLL_IDLE)
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
-	u32			freqsel_mask;
 	u32			idlest_mask;
+#endif
+#if defined(CONFIG_SOC_HAS_OMAP3_DPLL_FREQSEL)
+	u32			freqsel_mask;
+#endif
+#if defined(CONFIG_SOC_HAS_OMAP3_DPLL_DCO_SEL)
 	u32			dco_mask;
+#endif
+#if defined(CONFIG_SOC_HAS_OMAP3_DPLL_SDDIV)
 	u32			sddiv_mask;
+#endif
+#if defined(CONFIG_SOC_HAS_OMAP3_DPLL_RECAL)
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-#  endif
+#endif
 	u8			flags;
 };

--
1.7.0.4

