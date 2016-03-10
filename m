From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: RE: [PATCH v2 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Thu, 10 Mar 2016 11:10:48 +0700
Message-ID: <f50c53ee6963923ed36daa6795828f5a@mail.gmail.com>
References: <1453731985-13835-1-git-send-email-tqnguyen@apm.com> <1453731985-13835-2-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453731985-13835-2-git-send-email-tqnguyen@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org
Cc: Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-omap@vger.kernel.org

Hi,
I would like to ask if I need to update anything else for this change?

Thanks,
Thang Q. Nguyen -
-----Original Message-----
From: Thang Q. Nguyen [mailto:tqnguyen@apm.com]
Sent: Monday, January 25, 2016 9:26 PM
To: Felipe Balbi; Greg Kroah-Hartman; linux-usb@vger.kernel.org;
linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
linux-arm@lists.infradead.org
Cc: Thang Nguyen; Phong Vo; Loc Ho; patches@apm.com
Subject: [PATCH v2 2/2] usb:dwc3: pass arch data to xhci-hcd child

The xhci-hcd child node needs to inherit archdata attribute to use dma_ops
functions and attributes. This patch enables the USB DWC3 driver to pass
archdata attributes to its xhci-hcd child node.

Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
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
