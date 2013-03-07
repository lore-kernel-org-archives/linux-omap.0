From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/4] usb: dwc3: set dma_mask for dwc3_omap device
Date: Thu, 7 Mar 2013 18:51:43 +0530
Message-ID: <1362662506-14823-2-git-send-email-kishon@ti.com>
References: <1362662506-14823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362662506-14823-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ruchika-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

*dma_mask* is not set for devices created from dt data. So filled dma_mask
for dwc3_omap device here. And dwc3 core will copy the dma_mask from its
parent.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/core.c      |    4 ++++
 drivers/usb/dwc3/dwc3-omap.c |    3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 66c0572..c845e70 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -454,6 +454,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs_size	= resource_size(res);
 	dwc->dev	= dev;
 
+	dev->dma_mask	= dev->parent->dma_mask;
+	dev->dma_parms	= dev->parent->dma_parms;
+	dma_set_coherent_mask(dev, dev->parent->coherent_dma_mask);
+
 	if (!strncmp("super", maximum_speed, 5))
 		dwc->maximum_speed = DWC3_DCFG_SUPERSPEED;
 	else if (!strncmp("high", maximum_speed, 4))
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 35b9673..546f1fd 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -277,6 +277,8 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
 	dwc3_omap_writel(omap->base, USBOTGSS_IRQENABLE_SET_0, 0x00);
 }
 
+static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
+
 static int dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
@@ -330,6 +332,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	omap->dev	= dev;
 	omap->irq	= irq;
 	omap->base	= base;
+	dev->dma_mask	= &dwc3_omap_dma_mask;
 
 	/*
 	 * REVISIT if we ever have two instances of the wrapper, we will be
-- 
1.7.10.4
