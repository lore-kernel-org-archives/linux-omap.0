From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 5/5] USB: omap_udc: fix rejection of out transfers when DMA is used
Date: Sun, 25 Nov 2018 00:17:08 +0200
Message-ID: <20181124221708.31003-6-aaro.koskinen@iki.fi>
References: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Commit 387f869d2579 ("usb: gadget: u_ether: conditionally align
transfer size") started aligning transfer size only if requested,
breaking omap_udc DMA mode. Set quirk_ep_out_aligned_size to restore
the old behaviour.

Fixes: 387f869d2579 ("usb: gadget: u_ether: conditionally align transfer size")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 9b23e04c8f02..fcf13ef33b31 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2642,6 +2642,7 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_FULL;
 	udc->gadget.name = driver_name;
+	udc->gadget.quirk_ep_out_aligned_size = 1;
 	udc->transceiver = xceiv;
 
 	/* ep0 is special; put it right after the SETUP buffer */
-- 
2.17.0
