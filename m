From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v7 06/11] ARM: OMAP2+: gpmc: find features by ip rev check
Date: Wed, 19 Sep 2012 18:53:23 +0530
Message-ID: <a5273783a3480a1fc32b273c7ce12896a6779a66.1348058726.git.afzal@ti.com>
References: <cover.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37230 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310Ab2ISNX3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 09:23:29 -0400
In-Reply-To: <cover.1348058726.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Newer IP's have wr_access and wr_data_mux_bus fields. Use
IP revision values to determine availability of these
fields and hence decide on whether to configure them.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index a481816..d0916e9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -90,6 +90,11 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+#define	GPMC_REVISION_MAJOR(l)		((l >> 4) & 0xf)
+
+#define	GPMC_HAS_WR_ACCESS		0x1
+#define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
+
 /* XXX: Only NAND irq has been considered,currently these are the only ones used
  */
 #define	GPMC_NR_IRQ		2
@@ -136,6 +141,7 @@ static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned int gpmc_cs_map;	/* flag for cs which are initialized */
 static int gpmc_ecc_used = -EINVAL;	/* cs using ecc engine */
 
+static unsigned gpmc_capability;
 static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
@@ -364,10 +370,10 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
 	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
 
-	if (cpu_is_omap34xx()) {
+	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
-	}
 
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
@@ -930,6 +936,8 @@ static int __init gpmc_init(void)
 	clk_enable(gpmc_l3_clk);
 
 	l = gpmc_read_reg(GPMC_REVISION);
+	if (GPMC_REVISION_MAJOR(l) > 0x4)
+		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 	/* Set smart idle mode and automatic L3 clock gating */
 	l = gpmc_read_reg(GPMC_SYSCONFIG);
-- 
1.7.12

