From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 19/35] ARM: OMAP4+: PRM: setup prm_features from the PRM init time flags
Date: Wed, 25 Feb 2015 21:04:29 +0200
Message-ID: <1424891085-10392-20-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51322 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbbBYTFU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:20 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Currently some cpu_is_X checks are used to setup prm_features, however
the same can be accomplished by just passing these flags from the PRM
init data. This is done in preparation to make PRM a separate driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c    |    4 ++--
 arch/arm/mach-omap2/prm_common.c |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index a980d245..243133c 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -707,10 +707,10 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 {
 	omap_prm_base_init();
 
-	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
+	if (data->flags & PRM_HAS_IO_WAKEUP)
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
-	if (!soc_is_dra7xx())
+	if (data->flags & PRM_HAS_VOLTAGE)
 		prm_features |= PRM_HAS_VOLTAGE;
 
 	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 9850828..d964e41 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -662,18 +662,21 @@ static struct omap_prcm_init_data omap4_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP4430_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
 };
 
 static struct omap_prcm_init_data omap5_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP54XX_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
 };
 
 static struct omap_prcm_init_data dra7_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = DRA7XX_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP,
 };
 
 static struct omap_prcm_init_data am4_prm_data __initdata = {
-- 
1.7.9.5

