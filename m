From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 25/35] ARM: OMAP2+: DMA: remove omap2_system_dma_init from __init section
Date: Wed, 15 Apr 2015 15:53:12 +0300
Message-ID: <1429102402-5276-26-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbbDOMxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:12 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

With the introduction of the hwmod data modules, the DMA init also needs
to happen later in boot. Thus, remove it from the __init section, and
also make the API publicly available.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h |    2 ++
 arch/arm/mach-omap2/dma.c    |    6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 54cf6ca..172b902 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -324,5 +324,7 @@ int omap_clk_init(void);
 int omapdss_init_of(void);
 void omapdss_early_init_of(void);
 
+void omap2_system_dma_init(void);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 3ff450b..946f355 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -204,7 +204,7 @@ static unsigned configure_dma_errata(void)
 	return errata;
 }
 
-static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+static struct omap_system_dma_plat_info dma_plat_info = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
 	.show_dma_caps	= omap2_show_dma_caps,
@@ -220,7 +220,7 @@ static struct platform_device_info omap_dma_dev_info = {
 };
 
 /* One time initializations */
-static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
+static int omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 {
 	struct platform_device			*pdev;
 	struct omap_system_dma_plat_info	p;
@@ -270,7 +270,7 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	return 0;
 }
 
-static int __init omap2_system_dma_init(void)
+int omap2_system_dma_init(void)
 {
 	struct platform_device *pdev;
 	int res;
-- 
1.7.9.5

