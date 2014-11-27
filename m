From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 22/23] ARM: OMAP4+: PRM: setup prm_features from the PRM init time flags
Date: Thu, 27 Nov 2014 17:51:53 +0200
Message-ID: <1417103514-17027-23-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37136 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaK0PwS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:18 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
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
index 1994dcc..af12302b 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -706,10 +706,10 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
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
index b828352..d5bb649 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -651,18 +651,21 @@ static struct omap_prcm_init_data omap4_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP4430_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
 };
 
 static struct omap_prcm_init_data omap5_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = OMAP54XX_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP | PRM_HAS_VOLTAGE,
 };
 
 static struct omap_prcm_init_data dra7_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 	.init = omap44xx_prm_init,
 	.device_inst_offset = DRA7XX_PRM_DEVICE_INST,
+	.flags = PRM_HAS_IO_WAKEUP,
 };
 
 static struct omap_prcm_init_data am4_prm_data __initdata = {
-- 
1.7.9.5

