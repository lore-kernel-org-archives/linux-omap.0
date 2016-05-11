From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Wed, 11 May 2016 17:36:42 +0300
Message-ID: <1462977406-22806-2-git-send-email-rogerq@ti.com>
References: <1462977406-22806-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462977406-22806-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We intend to share this interrupt with the OTG driver an to ensure
that irqflags match for the shared interrupt handlers we use
request_threaded_irq()

If we don't use request_treaded_irq() then forced threaded irq will
set IRQF_ONESHOT and this won't match with the OTG IRQ handler's
IRQ flags.

NOTE: OTG IRQ handler is yet to be added. This is a preparatory step.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 59ea35f..7d49da1 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -165,7 +165,7 @@ static void dwc3_omap_write_utmi_ctrl(struct dwc3_omap *omap, u32 value)
 
 static u32 dwc3_omap_read_irq0_status(struct dwc3_omap *omap)
 {
-	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_0 -
+	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_0 -
 						omap->irq0_offset);
 }
 
@@ -178,7 +178,7 @@ static void dwc3_omap_write_irq0_status(struct dwc3_omap *omap, u32 value)
 
 static u32 dwc3_omap_read_irqmisc_status(struct dwc3_omap *omap)
 {
-	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_MISC +
+	return dwc3_omap_readl(omap->base, USBOTGSS_IRQSTATUS_RAW_MISC +
 						omap->irqmisc_offset);
 }
 
@@ -268,19 +268,38 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 	}
 }
 
+static void dwc3_omap_enable_irqs(struct dwc3_omap *omap);
+static void dwc3_omap_disable_irqs(struct dwc3_omap *omap);
+
 static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 {
 	struct dwc3_omap	*omap = _omap;
+
+	if (dwc3_omap_read_irqmisc_status(omap) ||
+	    dwc3_omap_read_irq0_status(omap)) {
+		/* mask irqs */
+		dwc3_omap_disable_irqs(omap);
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t dwc3_omap_interrupt_thread(int irq, void *_omap)
+{
+	struct dwc3_omap	*omap = _omap;
 	u32			reg;
 
+	/* clear irq status flags */
 	reg = dwc3_omap_read_irqmisc_status(omap);
-
 	dwc3_omap_write_irqmisc_status(omap, reg);
 
 	reg = dwc3_omap_read_irq0_status(omap);
-
 	dwc3_omap_write_irq0_status(omap, reg);
 
+	/* unmask irqs */
+	dwc3_omap_enable_irqs(omap);
+
 	return IRQ_HANDLED;
 }
 
@@ -497,8 +516,9 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	/* check the DMA Status */
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 
-	ret = devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
-			"dwc3-omap", omap);
+	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
+					dwc3_omap_interrupt_thread, 0,
+					"dwc3-omap", omap);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-- 
2.7.4
