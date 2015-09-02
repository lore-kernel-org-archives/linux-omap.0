From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 3/9] usb: dwc3: dwc3-omap: Make the wrapper interrupt shared
Date: Wed, 2 Sep 2015 17:24:18 +0300
Message-ID: <1441203864-15786-4-git-send-email-rogerq@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The wrapper interrupt is shared with OTG core so mark it IRQF_SHARED.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index a5a1b7c..b18f2a3 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -506,8 +506,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
 
-	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
-			"dwc3-omap", omap);
+	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, IRQF_SHARED,
+			       "dwc3-omap", omap);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-- 
2.1.4
