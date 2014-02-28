From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 09/13] ARM: OMAP3: fix iva mmu programming issues
Date: Fri, 28 Feb 2014 14:42:40 -0600
Message-ID: <1393620164-14633-10-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbaB1Uoz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 15:44:55 -0500
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The IVA MMU is not functional when used through the hwmod and
omap_device layers. Add fixes to clockdomain and hwmod data
to have it functional. The hwmod changes are needed to enable
the clock, and the SWSUP change is needed to wakeup the domain
because the power domain is programmed to be in RET, and there
is no automatic power domain switching to ON.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c | 2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index e6b91e5..f03dc97 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -247,7 +247,7 @@ static struct clockdomain neon_clkdm = {
 static struct clockdomain iva2_clkdm = {
 	.name		= "iva2_clkdm",
 	.pwrdm		= { .name = "iva2_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.flags		= CLKDM_CAN_SWSUP,
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
 	.wkdep_srcs	= iva2_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 81dd071..9c7e23a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3068,12 +3068,16 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.name		= "mmu_iva",
 	.class		= &omap3xxx_mmu_hwmod_class,
 	.mpu_irqs	= omap3xxx_mmu_iva_irqs,
+	.clkdm_name	= "iva2_clkdm",
 	.rst_lines	= omap3xxx_mmu_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_mmu_iva_resets),
 	.main_clk	= "iva2_ck",
 	.prcm = {
 		.omap2 = {
 			.module_offs = OMAP3430_IVA2_MOD,
+			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
 		},
 	},
 	.dev_attr	= &mmu_iva_dev_attr,
-- 
1.9.0

