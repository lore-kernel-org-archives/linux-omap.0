From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] dmaengine: ti: omap-dma: Pass sdma auxdata to driver
 and use it
Date: Mon, 16 Dec 2019 16:19:21 -0800
Message-ID: <20191217001925.44558-11-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vinod Koul <vinod.koul@intel.com>, Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can now start passing sdma auxdata to the dmaengine driver to start
removing the platform based sdma init.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       |  3 +++
 arch/arm/mach-omap2/dma.c          |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c |  1 +
 drivers/dma/ti/omap-dma.c          | 14 +++++++++-----
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -345,9 +345,12 @@ static inline int dra7xx_pciess_reset(struct omap_hwmod *oh)
 }
 #endif
 
+struct omap_system_dma_plat_info;
+
 void pdata_quirks_init(const struct of_device_id *);
 void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
+extern struct omap_system_dma_plat_info dma_plat_info;
 
 struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -217,7 +217,7 @@ static struct omap_dma_dev_attr dma_attr = {
 	.lch_count = 32,
 };
 
-static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+struct omap_system_dma_plat_info dma_plat_info = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
 	.dma_attr	= &dma_attr,
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -514,6 +514,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 	/* Common auxdata */
 	OF_DEV_AUXDATA("ti,sysc", 0, NULL, &ti_sysc_pdata),
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap-sdma", 0, NULL, &dma_plat_info),
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1585,14 +1585,18 @@ static int omap_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(od->base);
 
 	conf = of_device_get_match_data(&pdev->dev);
-	if (conf)
+	if (conf) {
 		od->cfg = conf;
-	else
+		od->plat = dev_get_platdata(&pdev->dev);
+		if (!od->plat)
+			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
+	} else {
 		od->cfg = &default_cfg;
 
-	od->plat = omap_get_plat_info();
-	if (!od->plat)
-		return -EPROBE_DEFER;
+		od->plat = omap_get_plat_info();
+		if (!od->plat)
+			return -EPROBE_DEFER;
+	}
 
 	od->reg_map = od->plat->reg_map;
 
-- 
2.24.1
