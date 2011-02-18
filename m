From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] omap4: l2x0: Populate set_debug() function and enable Errata 727915
Date: Fri, 18 Feb 2011 18:05:25 +0530
Message-ID: <1298032525-21115-3-git-send-email-santosh.shilimkar@ti.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43649 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab1BRMfo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 07:35:44 -0500
In-Reply-To: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, catalin.marinas@arm.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Populate the l2x0 set_debug function pointer with OMAP secure call
and enable the PL310 Errata 727915

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/omap4-common.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a2cf62..b69fa0a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,6 +45,7 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 1926864..9ef8c29 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -52,6 +52,12 @@ static void omap4_l2x0_disable(void)
 	omap_smc1(0x102, 0x0);
 }
 
+static void omap4_l2x0_set_debug(unsigned long val)
+{
+	/* Program PL310 L2 Cache controller debug register */
+	omap_smc1(0x100, val);
+}
+
 static int __init omap_l2_cache_init(void)
 {
 	u32 aux_ctrl = 0;
@@ -99,6 +105,7 @@ static int __init omap_l2_cache_init(void)
 	 * specific one
 	*/
 	outer_cache.disable = omap4_l2x0_disable;
+	outer_cache.set_debug = omap4_l2x0_set_debug;
 
 	return 0;
 }
-- 
1.6.0.4

