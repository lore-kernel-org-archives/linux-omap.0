From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt shared
Date: Mon, 11 Apr 2016 14:34:58 +0300
Message-ID: <1460374506-9779-3-git-send-email-rogerq@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460374506-9779-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The wrapper interrupt is shared with OTG core so mark it IRQF_SHARED.

Use request_threaded_irq() to ensure that irqflags match for the
shared interrupt handlers. If we don't use request_treaded_irq() then
forced threaded irq will set IRQF_ONESHOT and this won't match with
the OTG irq handler.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 22e9606..51ca098 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 {
 	struct dwc3_omap	*omap = _omap;
 	u32			reg;
+	int			ret = IRQ_NONE;
 
 	reg = dwc3_omap_read_irqmisc_status(omap);
 
+	if (reg)
+		ret = IRQ_HANDLED;
+
 	if (reg & USBOTGSS_IRQMISC_DMADISABLECLR)
 		omap->dma_status = false;
 
 	dwc3_omap_write_irqmisc_status(omap, reg);
 
 	reg = dwc3_omap_read_irq0_status(omap);
+	if (reg)
+		ret = IRQ_HANDLED;
 
 	dwc3_omap_write_irq0_status(omap, reg);
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static void dwc3_omap_enable_irqs(struct dwc3_omap *omap)
@@ -506,8 +512,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 	omap->dma_status = !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
 
-	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
-			"dwc3-omap", omap);
+	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
+					NULL, IRQF_SHARED, "dwc3-omap", omap);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-- 
2.5.0
