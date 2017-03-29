From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 2/3] usb: musb: Add support of CPPI 4.1 DMA controller to DA8xx
Date: Wed, 29 Mar 2017 18:24:31 +0200
Message-ID: <20170329162432.27299-3-abailon@baylibre.com>
References: <20170329162432.27299-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170329162432.27299-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently, only the PIO mode is supported.
This add support of CPPI 4.1 to DA8xx.
As the In DA8xx the CPPI 4.1 DMA is a part of the USB.
Create the CPPI 4.1 device as a child of USB.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/Kconfig |  4 ++--
 drivers/usb/musb/da8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 72a2a50..5506a9c 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -160,8 +160,8 @@ config USB_TI_CPPI_DMA
 	  Enable DMA transfers when TI CPPI DMA is available.
 
 config USB_TI_CPPI41_DMA
-	bool 'TI CPPI 4.1 (AM335x)'
-	depends on ARCH_OMAP && DMADEVICES
+	bool 'TI CPPI 4.1'
+	depends on (ARCH_OMAP || ARCH_DAVINCI_DA8XX) && DMADEVICES
 	select TI_CPPI41
 
 config USB_TUSB_OMAP_DMA
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index d79c288..7b9a44d 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -33,6 +33,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -456,12 +457,41 @@ static inline u8 get_vbus_power(struct device *dev)
 	return current_uA / 1000 / 2;
 }
 
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+static void da8xx_dma_controller_callback(struct dma_controller *c)
+{
+	struct musb *musb = c->musb;
+	void __iomem *reg_base = musb->ctrl_base;
+
+	musb_writel(reg_base, DA8XX_USB_END_OF_INTR_REG, 0);
+}
+
+static struct dma_controller *
+da8xx_dma_controller_create(struct musb *musb, void __iomem *base)
+{
+	struct dma_controller *controller;
+
+	controller = cppi41_dma_controller_create(musb, base);
+	if (IS_ERR_OR_NULL(controller))
+		return controller;
+
+	controller->dma_callback = da8xx_dma_controller_callback;
+
+	return controller;
+}
+#endif
+
 static const struct musb_platform_ops da8xx_ops = {
-	.quirks		= MUSB_INDEXED_EP | MUSB_PRESERVE_SESSION,
+	.quirks		= MUSB_INDEXED_EP | MUSB_PRESERVE_SESSION |
+			  MUSB_DMA_CPPI41,
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
 	.fifo_mode	= 2,
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+	.dma_init	= da8xx_dma_controller_create,
+	.dma_exit	= cppi41_dma_controller_destroy,
+#endif
 	.enable		= da8xx_musb_enable,
 	.disable	= da8xx_musb_disable,
 
@@ -483,6 +513,12 @@ static const struct musb_hdrc_config da8xx_config = {
 	.multipoint = 1,
 };
 
+static struct of_dev_auxdata da8xx_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("ti,da830-cppi41", 0x01e01000, "cppi41-dmaengine",
+		       NULL),
+	{}
+};
+
 static int da8xx_probe(struct platform_device *pdev)
 {
 	struct resource musb_resources[2];
@@ -533,6 +569,11 @@ static int da8xx_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, glue);
 
+	ret = of_platform_populate(pdev->dev.of_node, NULL,
+				   da8xx_auxdata_lookup, &pdev->dev);
+	if (ret)
+		return ret;
+
 	memset(musb_resources, 0x00, sizeof(*musb_resources) *
 			ARRAY_SIZE(musb_resources));
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
