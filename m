From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 08/16] ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
Date: Thu, 13 Feb 2014 12:15:39 -0600
Message-ID: <1392315347-32967-9-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50339 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbaBMSWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 13:22:24 -0500
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>

From: Florian Vaussard <florian.vaussard@epfl.ch>

CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
usage by tidspbridge and other iommu users. The same can be achieved
by marking the DT node disabled, so remove this obsolete flag and
the corresponding hwmod data can be enabled.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna@ti.com: revise commit log]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 8 --------
 arch/arm/plat-omap/Kconfig                 | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 4c3b1e6..81dd071 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3029,8 +3029,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-#ifdef CONFIG_OMAP_IOMMU_IVA2
-
 /* mmu iva */
 
 static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
@@ -3082,8 +3080,6 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-#endif
-
 /* l4_per -> gpio4 */
 static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
 	{
@@ -3855,9 +3851,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__hdq1w,
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
-#ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
-#endif
 	&omap34xx_l4_core__ssi,
 	NULL
 };
@@ -3881,9 +3875,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__hdq1w,
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
-#ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
-#endif
 	NULL
 };
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 436ea97..02fc10d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -86,9 +86,6 @@ config OMAP_MUX_WARNINGS
 	  to change the pin multiplexing setup.	 When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
 
-config OMAP_IOMMU_IVA2
-	bool
-
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
 	depends on ARCH_OMAP1
-- 
1.8.5.3

