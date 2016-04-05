From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] usb: dwc3: omap: drop dma_mask configuration
Date: Tue, 5 Apr 2016 15:09:44 +0300
Message-ID: <1459858184-1962-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The DWC3 OMAP driver supports DT-boot only, as result dma_mask will be
always configured properly from DT -
of_platform_device_create_pdata()->of_dma_configure(). More over,
dwc3-omap.c can be built as module and in this case it's unsafe to
assign local variable as dma_mask.

Hence, remove dma_mask configuration code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 22e9606..e92a992 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
 	dwc3_omap_write_irqmisc_clr(omap, reg);
 }
 
-static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
-
 static int dwc3_omap_id_notifier(struct notifier_block *nb,
 	unsigned long event, void *ptr)
 {
@@ -490,7 +488,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	omap->irq	= irq;
 	omap->base	= base;
 	omap->vbus_reg	= vbus_reg;
-	dev->dma_mask	= &dwc3_omap_dma_mask;
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-- 
2.8.0
