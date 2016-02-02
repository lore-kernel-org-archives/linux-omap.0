From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: DMA: Provide dma_slave_map to omap-dma for legacy boot
Date: Tue, 2 Feb 2016 16:27:07 +0200
Message-ID: <1454423227-31830-3-git-send-email-peter.ujfalusi@ti.com>
References: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

We still have some boards booting in legacy mode and they will need to have
the device/slave -> filter_fn mapping so we can convert the OMAP drivers
to use the new dmaengine API for requesting channels.
Only some OMAP24xx and OMAP3xxx boards can boot in legacy mode which means
we only need to provide the map for these SoCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/dma.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 1ed4be184a29..e58c13a9bea5 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/of.h>
 #include <linux/omap-dma.h>
 
@@ -203,6 +204,108 @@ static unsigned configure_dma_errata(void)
 	return errata;
 }
 
+static const struct dma_slave_map omap24xx_sdma_map[] = {
+	{ "omap-gpmc", "rxtx", SDMA_FILTER_PARAM(4) },
+	{ "omap-aes", "tx", SDMA_FILTER_PARAM(9) },
+	{ "omap-aes", "rx", SDMA_FILTER_PARAM(10) },
+	{ "omap-sham", "rx", SDMA_FILTER_PARAM(13) },
+	{ "omap2_mcspi.2", "tx0", SDMA_FILTER_PARAM(15) },
+	{ "omap2_mcspi.2", "rx0", SDMA_FILTER_PARAM(16) },
+	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(17) },
+	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(18) },
+	{ "omap-mcbsp.4", "tx", SDMA_FILTER_PARAM(19) },
+	{ "omap-mcbsp.4", "rx", SDMA_FILTER_PARAM(20) },
+	{ "omap-mcbsp.5", "tx", SDMA_FILTER_PARAM(21) },
+	{ "omap-mcbsp.5", "rx", SDMA_FILTER_PARAM(22) },
+	{ "omap2_mcspi.2", "tx1", SDMA_FILTER_PARAM(23) },
+	{ "omap2_mcspi.2", "rx1", SDMA_FILTER_PARAM(24) },
+	{ "omap_i2c.1", "tx", SDMA_FILTER_PARAM(27) },
+	{ "omap_i2c.1", "rx", SDMA_FILTER_PARAM(28) },
+	{ "omap_i2c.2", "tx", SDMA_FILTER_PARAM(29) },
+	{ "omap_i2c.2", "rx", SDMA_FILTER_PARAM(30) },
+	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(31) },
+	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(32) },
+	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(33) },
+	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(34) },
+	{ "omap2_mcspi.0", "tx0", SDMA_FILTER_PARAM(35) },
+	{ "omap2_mcspi.0", "rx0", SDMA_FILTER_PARAM(36) },
+	{ "omap2_mcspi.0", "tx1", SDMA_FILTER_PARAM(37) },
+	{ "omap2_mcspi.0", "rx1", SDMA_FILTER_PARAM(38) },
+	{ "omap2_mcspi.0", "tx2", SDMA_FILTER_PARAM(39) },
+	{ "omap2_mcspi.0", "rx2", SDMA_FILTER_PARAM(40) },
+	{ "omap2_mcspi.0", "tx3", SDMA_FILTER_PARAM(41) },
+	{ "omap2_mcspi.0", "rx3", SDMA_FILTER_PARAM(42) },
+	{ "omap2_mcspi.1", "tx0", SDMA_FILTER_PARAM(43) },
+	{ "omap2_mcspi.1", "rx0", SDMA_FILTER_PARAM(44) },
+	{ "omap2_mcspi.1", "tx1", SDMA_FILTER_PARAM(45) },
+	{ "omap2_mcspi.1", "rx1", SDMA_FILTER_PARAM(46) },
+	{ "omap_hsmmc.1", "tx", SDMA_FILTER_PARAM(47) },
+	{ "omap_hsmmc.1", "rx", SDMA_FILTER_PARAM(48) },
+	{ "omap_uart.0", "tx", SDMA_FILTER_PARAM(49) },
+	{ "omap_uart.0", "rx", SDMA_FILTER_PARAM(50) },
+	{ "omap_uart.1", "tx", SDMA_FILTER_PARAM(51) },
+	{ "omap_uart.1", "rx", SDMA_FILTER_PARAM(52) },
+	{ "omap_uart.2", "tx", SDMA_FILTER_PARAM(53) },
+	{ "omap_uart.2", "rx", SDMA_FILTER_PARAM(54) },
+	{ "omap_hsmmc.0", "tx", SDMA_FILTER_PARAM(61) },
+	{ "omap_hsmmc.0", "rx", SDMA_FILTER_PARAM(62) },
+};
+
+static const struct dma_slave_map omap3xxx_sdma_map[] = {
+	{ "omap-gpmc", "rxtx", SDMA_FILTER_PARAM(4) },
+	{ "omap2_mcspi.2", "tx0", SDMA_FILTER_PARAM(15) },
+	{ "omap2_mcspi.2", "rx0", SDMA_FILTER_PARAM(16) },
+	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(17) },
+	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(18) },
+	{ "omap-mcbsp.4", "tx", SDMA_FILTER_PARAM(19) },
+	{ "omap-mcbsp.4", "rx", SDMA_FILTER_PARAM(20) },
+	{ "omap-mcbsp.5", "tx", SDMA_FILTER_PARAM(21) },
+	{ "omap-mcbsp.5", "rx", SDMA_FILTER_PARAM(22) },
+	{ "omap2_mcspi.2", "tx1", SDMA_FILTER_PARAM(23) },
+	{ "omap2_mcspi.2", "rx1", SDMA_FILTER_PARAM(24) },
+	{ "omap_i2c.3", "tx", SDMA_FILTER_PARAM(25) },
+	{ "omap_i2c.3", "rx", SDMA_FILTER_PARAM(26) },
+	{ "omap_i2c.1", "tx", SDMA_FILTER_PARAM(27) },
+	{ "omap_i2c.1", "rx", SDMA_FILTER_PARAM(28) },
+	{ "omap_i2c.2", "tx", SDMA_FILTER_PARAM(29) },
+	{ "omap_i2c.2", "rx", SDMA_FILTER_PARAM(30) },
+	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(31) },
+	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(32) },
+	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(33) },
+	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(34) },
+	{ "omap2_mcspi.0", "tx0", SDMA_FILTER_PARAM(35) },
+	{ "omap2_mcspi.0", "rx0", SDMA_FILTER_PARAM(36) },
+	{ "omap2_mcspi.0", "tx1", SDMA_FILTER_PARAM(37) },
+	{ "omap2_mcspi.0", "rx1", SDMA_FILTER_PARAM(38) },
+	{ "omap2_mcspi.0", "tx2", SDMA_FILTER_PARAM(39) },
+	{ "omap2_mcspi.0", "rx2", SDMA_FILTER_PARAM(40) },
+	{ "omap2_mcspi.0", "tx3", SDMA_FILTER_PARAM(41) },
+	{ "omap2_mcspi.0", "rx3", SDMA_FILTER_PARAM(42) },
+	{ "omap2_mcspi.1", "tx0", SDMA_FILTER_PARAM(43) },
+	{ "omap2_mcspi.1", "rx0", SDMA_FILTER_PARAM(44) },
+	{ "omap2_mcspi.1", "tx1", SDMA_FILTER_PARAM(45) },
+	{ "omap2_mcspi.1", "rx1", SDMA_FILTER_PARAM(46) },
+	{ "omap_hsmmc.1", "tx", SDMA_FILTER_PARAM(47) },
+	{ "omap_hsmmc.1", "rx", SDMA_FILTER_PARAM(48) },
+	{ "omap_uart.0", "tx", SDMA_FILTER_PARAM(49) },
+	{ "omap_uart.0", "rx", SDMA_FILTER_PARAM(50) },
+	{ "omap_uart.1", "tx", SDMA_FILTER_PARAM(51) },
+	{ "omap_uart.1", "rx", SDMA_FILTER_PARAM(52) },
+	{ "omap_uart.2", "tx", SDMA_FILTER_PARAM(53) },
+	{ "omap_uart.2", "rx", SDMA_FILTER_PARAM(54) },
+	{ "omap_hsmmc.0", "tx", SDMA_FILTER_PARAM(61) },
+	{ "omap_hsmmc.0", "rx", SDMA_FILTER_PARAM(62) },
+	{ "omap-aes", "tx", SDMA_FILTER_PARAM(65) },
+	{ "omap-aes", "rx", SDMA_FILTER_PARAM(66) },
+	{ "omap-sham", "rx", SDMA_FILTER_PARAM(69) },
+	{ "omap2_mcspi.3", "tx0", SDMA_FILTER_PARAM(70) },
+	{ "omap2_mcspi.3", "rx0", SDMA_FILTER_PARAM(71) },
+	{ "omap_hsmmc.2", "tx", SDMA_FILTER_PARAM(77) },
+	{ "omap_hsmmc.2", "rx", SDMA_FILTER_PARAM(78) },
+	{ "omap_uart.3", "tx", SDMA_FILTER_PARAM(81) },
+	{ "omap_uart.3", "rx", SDMA_FILTER_PARAM(82) },
+};
+
 static struct omap_system_dma_plat_info dma_plat_info __initdata = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
@@ -231,6 +334,20 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	p.dma_attr = (struct omap_dma_dev_attr *)oh->dev_attr;
 	p.errata = configure_dma_errata();
 
+	if (!of_have_populated_dt()) {
+		if (soc_is_omap24xx()) {
+			p.slave_map = omap24xx_sdma_map;
+			p.slavecnt = ARRAY_SIZE(omap24xx_sdma_map);
+		} else if (soc_is_omap34xx() || soc_is_omap3630()) {
+			p.slave_map = omap3xxx_sdma_map;
+			p.slavecnt = ARRAY_SIZE(omap3xxx_sdma_map);
+		} else {
+			pr_err("%s: The legacy DMA map is not provided!\n",
+			       __func__);
+			return -ENODEV;
+		}
+	}
+
 	pdev = omap_device_build(name, 0, oh, &p, sizeof(p));
 	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s:%s.\n",
-- 
2.7.0
