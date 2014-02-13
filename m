From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 13/16] ARM: OMAP2+: extend iommu pdata-quirks to OMAP5
Date: Thu, 13 Feb 2014 12:15:44 -0600
Message-ID: <1392315347-32967-14-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45858 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbaBMSR7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 13:17:59 -0500
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

OMAP5 has the same iommus as OMAP4, so extend the OMAP4
iommu pdata quirks for OMAP5 as well.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 74e094a..551877f 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -193,7 +193,9 @@ static void __init omap4_panda_legacy_init(void)
 	legacy_init_ehci_clk("auxclk3_ck");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
+#endif
 
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 static struct iommu_platform_data omap4_iommu_pdata = {
 	.reset_name = "mmu_cache",
 	.assert_reset = omap_device_assert_hardreset,
@@ -264,6 +266,8 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
+#endif
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
 		       &omap4_iommu_pdata),
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
-- 
1.8.5.3

