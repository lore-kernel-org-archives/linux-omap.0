From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 07/19] usb: host: xhci: Adapt xhci to use usb drd library
Date: Tue, 25 Nov 2014 18:41:43 +0530
Message-ID: <1416921115-10467-8-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: mark.rutland@arm.com, George Cherian <george.cherian@ti.com>, kgene.kim@samsung.com, linux@arm.linux.org.uk, ben-linux@fluff.org, mathias.nyman@intel.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, gregkh@linuxfoundation.org, sojka@merica.cz, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, peter.chen@freescale.com, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Adapt the xhci-plat driver  to use drd library functions.
In prepration to support DRD on dwc3.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/host/xhci-plat.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d8d024d..fbbbd59 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -17,6 +17,8 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/drd.h>
 #include <linux/usb/xhci_pdriver.h>
 
 #include "xhci.h"
@@ -78,6 +80,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct resource         *res;
 	struct usb_hcd		*hcd;
 	struct clk              *clk;
+	struct usb_drd_host	*drd_host;
 	int			ret;
 	int			irq;
 
@@ -169,6 +172,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_usb3_hcd;
 
+	drd_host = kzalloc(sizeof(*drd_host), GFP_KERNEL);
+	if (!drd_host)
+		return -ENOMEM;
+
+	drd_host->main_hcd = xhci->main_hcd;
+	drd_host->shared_hcd = xhci->shared_hcd;
+	drd_host->hcd_irq = irq;
+	drd_host->host_setup = NULL;
+
+	usb_drd_register_hcd(pdev->dev.parent, drd_host);
+
 	return 0;
 
 put_usb3_hcd:
@@ -200,6 +214,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
+	usb_drd_unregister_hcd(dev->dev.parent);
 	kfree(xhci);
 
 	return 0;
-- 
1.8.3.1
