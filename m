From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/4] USB: omap_udc: fix omap_udc_start() on 15xx machines
Date: Sun, 18 Nov 2018 21:59:11 +0200
Message-ID: <20181118195912.14026-3-aaro.koskinen@iki.fi>
References: <20181118195912.14026-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118195912.14026-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On OMAP 15xx machines there are no transceivers, and omap_udc_start()
always fails as it forgot to adjust the default return value.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index d98782ec254d..7c240b1921bd 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2041,7 +2041,7 @@ static inline int machine_without_vbus_sense(void)
 static int omap_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
-	int		status = -ENODEV;
+	int		status;
 	struct omap_ep	*ep;
 	unsigned long	flags;
 
@@ -2079,6 +2079,7 @@ static int omap_udc_start(struct usb_gadget *g,
 			goto done;
 		}
 	} else {
+		status = 0;
 		if (can_pullup(udc))
 			pullup_enable(udc);
 		else
-- 
2.17.0
