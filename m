From: "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: RE: [PATCH v2 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Tue, 16 Feb 2016 17:56:12 +0700
Message-ID: <be46c278795bd15d06924720f4ae18dd@mail.gmail.com>
References: <1453731985-13835-1-git-send-email-tqnguyen@apm.com> <1453731985-13835-2-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453731985-13835-2-git-send-email-tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
Do you have any feedback on this change?

Regards,
Thang Q. Nguyen -
-----Original Message-----
From: Thang Q. Nguyen [mailto:tqnguyen-qTEPVZfXA3Y@public.gmane.org]
Sent: Monday, January 25, 2016 9:26 PM
To: Felipe Balbi; Greg Kroah-Hartman; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thang Nguyen; Phong Vo; Loc Ho; patches-qTEPVZfXA3Y@public.gmane.org
Subject: [PATCH v2 2/2] usb:dwc3: pass arch data to xhci-hcd child

The xhci-hcd child node needs to inherit archdata attribute to use dma_ops
functions and attributes. This patch enables the USB DWC3 driver to pass
archdata attributes to its xhci-hcd child node.

Signed-off-by: Thang Q. Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
---
Changes from v1:
	- None

 drivers/usb/dwc3/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c index
c679f63..661fbae 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -37,6 +37,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	xhci->dev.parent	= dwc->dev;
 	xhci->dev.dma_mask	= dwc->dev->dma_mask;
 	xhci->dev.dma_parms	= dwc->dev->dma_parms;
+	xhci->dev.archdata      = dwc->dev->archdata;

 	dwc->xhci = xhci;

--
2.2.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
