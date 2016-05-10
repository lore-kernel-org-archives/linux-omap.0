From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 2/5] usb: dwc3: omap: Mark the interrupt handler as shared
Date: Tue, 10 May 2016 12:51:56 +0300
Message-ID: <1462873919-20532-3-git-send-email-rogerq@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462873919-20532-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On OMAPs, OTG events come on the same IRQ so we need to share
this IRQ with the OTG device driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 6504e94..a30944d 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -504,7 +504,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
 
 	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
-					NULL, 0, "dwc3-omap", omap);
+					NULL, IRQF_SHARED, "dwc3-omap", omap);
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 				omap->irq, ret);
-- 
2.7.4
