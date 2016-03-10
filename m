From: "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v3 0/2] usb:dwc3: Enable USB DWC3 support for 64-bit system
Date: Thu, 10 Mar 2016 14:18:50 +0700
Message-ID: <1457594332-7490-1-git-send-email-tqnguyen@apm.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Thang Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>

When CONFIG_DMA_CMA is not set, the coherent mask is not set.
These patches enable the USB DWC3 driver to set the coherent mask
correctly by first set coherent DMA mask to 64-bit. If this
failed, attempt again with 32-bit.
In addition, pass the archdata to the xhci-hcd child so that
xhci-hcd can configure DMA operations correctly.

Thang Q. Nguyen (2):
  usb:dwc3: Enable support for 64-bit system
  usb:dwc3: pass arch data to xhci-hcd child

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 drivers/usb/dwc3/host.c |  1 +
 2 files changed, 16 insertions(+)

-- 
2.2.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
