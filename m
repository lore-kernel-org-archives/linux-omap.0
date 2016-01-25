From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: [PATCH v2 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Mon, 25 Jan 2016 21:26:25 +0700
Message-ID: <1453731985-13835-2-git-send-email-tqnguyen@apm.com>
References: <1453731985-13835-1-git-send-email-tqnguyen@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453731985-13835-1-git-send-email-tqnguyen@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org
Cc: Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-omap@vger.kernel.org

The xhci-hcd child node needs to inherit archdata attribute to use
dma_ops functions and attributes. This patch enables the USB DWC3
driver to pass archdata attributes to its xhci-hcd child node.

Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
Changes from v1:
	- None

 drivers/usb/dwc3/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c679f63..661fbae 100644
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
