From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ARM: OMAP2+: make omap_dma_dev_info __initdata
Date: Mon, 18 Sep 2017 22:17:10 +0530
Message-ID: <1505753230-14014-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tony@atomide.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make this __initdata as it is only modified only during the initialisation
phase in the function omap2_system_dma_init_dev and after this it is not
referenced anywhere in the kernel.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-omap2/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 694ce09..a005e2a 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -223,7 +223,7 @@ static unsigned configure_dma_errata(void)
 	.dma_read	= dma_read,
 };
 
-static struct platform_device_info omap_dma_dev_info = {
+static struct platform_device_info omap_dma_dev_info __initdata = {
 	.name = "omap-dma-engine",
 	.id = -1,
 	.dma_mask = DMA_BIT_MASK(32),
-- 
1.9.1
