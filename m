From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 8/9] ARM: OMAP2+: DMA: Add slave map entries for 24xx external request lines
Date: Fri, 12 May 2017 16:57:51 +0300
Message-ID: <20170512135752.1800-9-peter.ujfalusi@ti.com>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The external request lines are used by tusb6010 on OMAP24xx platforms.
Update the map so the driver can use dmaengine API to request the DMA
channel. At the same time add temporary map containing only the external
DMA request numbers for DT booted case on omap24xx since the tusb6010 stack
is not yet supports DT boot.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e58c13a9bea5..0b77a0176018 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -249,6 +249,24 @@ static const struct dma_slave_map omap24xx_sdma_map[] = {
 	{ "omap_uart.2", "rx", SDMA_FILTER_PARAM(54) },
 	{ "omap_hsmmc.0", "tx", SDMA_FILTER_PARAM(61) },
 	{ "omap_hsmmc.0", "rx", SDMA_FILTER_PARAM(62) },
+
+	/* external DMA requests when tusb6010 is used */
+	{ "musb-tusb", "dmareq0", SDMA_FILTER_PARAM(2) },
+	{ "musb-tusb", "dmareq1", SDMA_FILTER_PARAM(3) },
+	{ "musb-tusb", "dmareq2", SDMA_FILTER_PARAM(14) }, /* OMAP2420 only */
+	{ "musb-tusb", "dmareq3", SDMA_FILTER_PARAM(15) }, /* OMAP2420 only */
+	{ "musb-tusb", "dmareq4", SDMA_FILTER_PARAM(16) }, /* OMAP2420 only */
+	{ "musb-tusb", "dmareq5", SDMA_FILTER_PARAM(64) }, /* OMAP2420 only */
+};
+
+static const struct dma_slave_map omap24xx_sdma_dt_map[] = {
+	/* external DMA requests when tusb6010 is used */
+	{ "musb-hdrc.1.auto", "dmareq0", SDMA_FILTER_PARAM(2) },
+	{ "musb-hdrc.1.auto", "dmareq1", SDMA_FILTER_PARAM(3) },
+	{ "musb-hdrc.1.auto", "dmareq2", SDMA_FILTER_PARAM(14) }, /* OMAP2420 only */
+	{ "musb-hdrc.1.auto", "dmareq3", SDMA_FILTER_PARAM(15) }, /* OMAP2420 only */
+	{ "musb-hdrc.1.auto", "dmareq4", SDMA_FILTER_PARAM(16) }, /* OMAP2420 only */
+	{ "musb-hdrc.1.auto", "dmareq5", SDMA_FILTER_PARAM(64) }, /* OMAP2420 only */
 };
 
 static const struct dma_slave_map omap3xxx_sdma_map[] = {
@@ -346,6 +364,12 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 			       __func__);
 			return -ENODEV;
 		}
+	} else {
+		if (soc_is_omap24xx()) {
+			/* DMA slave map for drivers not yet converted to DT */
+			p.slave_map = omap24xx_sdma_dt_map;
+			p.slavecnt = ARRAY_SIZE(omap24xx_sdma_dt_map);
+		}
 	}
 
 	pdev = omap_device_build(name, 0, oh, &p, sizeof(p));
-- 
2.13.0
