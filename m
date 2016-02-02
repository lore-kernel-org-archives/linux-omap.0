From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
Date: Tue, 2 Feb 2016 16:27:06 +0200
Message-ID: <1454423227-31830-2-git-send-email-peter.ujfalusi@ti.com>
References: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

OMAP1 can not boot in DT mode and to be able to clean up the driver
regarding to the dmaengine API use (switching to the new API) the
device/slave -> filter mapping needs to be provided to the omap-dma driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap1/dma.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 7b02ed218a42..f6ba589cd312 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
 
@@ -265,6 +266,42 @@ static const struct platform_device_info omap_dma_dev_info = {
 	.num_res = 1,
 };
 
+/* OMAP730, OMAP850 */
+static const struct dma_slave_map omap7xx_sdma_map[] = {
+	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
+	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
+	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(10) },
+	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(11) },
+	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
+	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
+	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
+	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
+	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
+	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
+	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
+	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
+};
+
+/* OMAP1510, OMAP1610*/
+static const struct dma_slave_map omap1xxx_sdma_map[] = {
+	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
+	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
+	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(10) },
+	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(11) },
+	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(16) },
+	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(17) },
+	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
+	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
+	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
+	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
+	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
+	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
+	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
+	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
+	{ "mmci-omap.1", "tx", SDMA_FILTER_PARAM(54) },
+	{ "mmci-omap.1", "rx", SDMA_FILTER_PARAM(55) },
+};
+
 static struct omap_system_dma_plat_info dma_plat_info __initdata = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x40,
@@ -342,6 +379,14 @@ static int __init omap1_system_dma_init(void)
 	p.dma_attr = d;
 	p.errata = configure_dma_errata();
 
+	if (cpu_is_omap7xx()) {
+		p.slave_map = omap7xx_sdma_map;
+		p.slavecnt = ARRAY_SIZE(omap7xx_sdma_map);
+	} else {
+		p.slave_map = omap1xxx_sdma_map;
+		p.slavecnt = ARRAY_SIZE(omap1xxx_sdma_map);
+	}
+
 	ret = platform_device_add_data(pdev, &p, sizeof(p));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
-- 
2.7.0
