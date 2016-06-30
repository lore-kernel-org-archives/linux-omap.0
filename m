From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: dwc3: host: Fix broken XHCI host
Date: Thu, 30 Jun 2016 14:54:17 +0300
Message-ID: <1467287657-7280-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: b-liu-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Looks like we lost all changes related to
commit 9522def40065 ("usb: dwc3: core: cleanup IRQ resources") in host.c
when Felipe's next branch was merged into Greg's next branch.

Fixes 215db948181 ("Merge tag 'usb-for-v4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next")
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/host.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 67f90d7..f6533c6 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -23,7 +23,48 @@ int dwc3_host_init(struct dwc3 *dwc)
 {
 	struct property_entry	props[2];
 	struct platform_device	*xhci;
-	int			ret;
+	int			ret, irq;
+	struct resource		*res;
+	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
+
+	irq = platform_get_irq_byname(dwc3_pdev, "host");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq <= 0) {
+		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq <= 0) {
+			irq = platform_get_irq(dwc3_pdev, 0);
+			if (irq <= 0) {
+				if (irq != -EPROBE_DEFER) {
+					dev_err(dwc->dev,
+						"missing host IRQ\n");
+				}
+				if (!irq)
+					irq = -EINVAL;
+				return irq;
+			} else {
+				res = platform_get_resource(dwc3_pdev,
+							    IORESOURCE_IRQ, 0);
+			}
+		} else {
+			res = platform_get_resource_byname(dwc3_pdev,
+							   IORESOURCE_IRQ,
+							   "dwc_usb3");
+		}
+
+	} else {
+		res = platform_get_resource_byname(dwc3_pdev, IORESOURCE_IRQ,
+						   "host");
+	}
+
+	dwc->xhci_resources[1].start = irq;
+	dwc->xhci_resources[1].end = irq;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
