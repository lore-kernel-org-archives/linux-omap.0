From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 13/23] ARM: OMAP2+: CM: determine CM base address from
 device tree
Date: Sat, 24 Jan 2015 19:39:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501241937570.5450@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-14-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44315 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbbAXTjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 14:39:21 -0500
In-Reply-To: <1417103514-17027-14-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero

On Thu, 27 Nov 2014, Tero Kristo wrote:

> There is no need to provide the CM base address through a low-level API
> from the low-level IO init, as this information is available through DT.
> Re-routed the parsing function to be called from the CM drivers also to
> simplify the implementation under io.c.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This one breaks boot on OMAP2430 (and presumably all other OMAP2xxx).  
Adding something like this seems to get it working.


- Paul

---
 arch/arm/mach-omap2/cm_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index c2d7c7b3002c..1770364f0499 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -234,7 +234,12 @@ static struct omap_prcm_init_data omap3_cm_data = {
 	.offset = -OMAP3430_IVA2_MOD,
 };
 
+static struct omap_prcm_init_data omap2_prcm_data = {
+	.index = CLK_MEMMAP_INDEX_CM1,
+};
+
 static struct of_device_id omap_cm_dt_match_table[] = {
+	{ .compatible = "ti,omap2-prcm", .data = &omap2_prcm_data },
 	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
 	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
 	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
-- 
2.1.4

