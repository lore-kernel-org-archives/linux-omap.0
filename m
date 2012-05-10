From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
Date: Thu, 10 May 2012 22:36:52 +0530
Message-ID: <1336669615-16454-2-git-send-email-r.sricharan@ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab2EJRHO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:07:14 -0400
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com, paul@pswan.com

The DPLL ip was introduced and used in the OMAP3PLUS socs, while
OMAP2 had the APLL IP. There are some features which are common
to both ips, and some which are only applicable to DPLL ip's.
Currently CONFIG_ARCH_OMAP_XXX checks is used to conditionally
compile the additional features for every applicable SOC. This
makes it nessecary to add new a check for every new SOC added
in the future.

So by introducing a new "SOC_HAS_OMAP_DPLL" config such new #ifdefs
can be avoided for the future socs and also to cleanup the existing
 ifdefferies.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/Kconfig             |    5 +++++
 arch/arm/mach-omap2/clock.c             |    2 +-
 arch/arm/plat-omap/include/plat/clock.h |    4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0685dc8..9a8d691 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -27,9 +27,13 @@ config ARCH_OMAP2
 	select CPU_V6
 	select MULTI_IRQ_HANDLER
 
+config SOC_HAS_OMAP_DPLL
+	bool
+
 config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_OMAP2PLUS
+	select SOC_HAS_OMAP_DPLL
 	default y
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
@@ -42,6 +46,7 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	default y
 	depends on ARCH_OMAP2PLUS
+	select SOC_HAS_OMAP_DPLL
 	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d9f4931..629cd2d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -400,7 +400,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 
 /* OMAP3/4 non-CORE DPLL clkops */
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_SOC_HAS_OMAP_DPLL
 
 const struct clkops clkops_omap3_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index d0ef57c..095bee8 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -156,7 +156,7 @@ struct dpll_data {
 	u8			min_divider;
 	u16			max_divider;
 	u8			modes;
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#ifdef CONFIG_SOC_HAS_OMAP_DPLL
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
@@ -167,7 +167,7 @@ struct dpll_data {
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-#  endif
+#endif
 	u8			flags;
 };
 
-- 
1.7.1

