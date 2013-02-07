From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 05/14] USB: ehci-omap: Get platform resources by index
 rather than by name
Date: Thu, 7 Feb 2013 18:02:45 +0200
Message-ID: <1360252974-7912-6-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1360252974-7912-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Since there is only one resource per type we don't really need
to use resource name to obtain it. This also also makes it easier
for device tree adaptation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-omap.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 0aa12f6..02a7893 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -148,16 +148,15 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_irq_byname(pdev, "ehci-irq");
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "EHCI irq failed\n");
 		return -ENODEV;
 	}
 
-	res =  platform_get_resource_byname(pdev,
-				IORESOURCE_MEM, "ehci");
+	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_request_and_ioremap(dev, res);
-	if (!regs) {
+	if (IS_ERR(regs)) {
 		dev_err(dev, "Resource request/ioremap failed\n");
 		return -EADDRNOTAVAIL;
 	}
-- 
1.7.4.1
