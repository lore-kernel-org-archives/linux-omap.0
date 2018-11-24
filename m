From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 4/5] USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
Date: Sun, 25 Nov 2018 00:17:07 +0200
Message-ID: <20181124221708.31003-5-aaro.koskinen@iki.fi>
References: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124221708.31003-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Palm TE nothing happens when you try to use gadget drivers and plug
the USB cable. Fix by adding the board to the vbus sense quirk list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 33250e569af8..9b23e04c8f02 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2033,6 +2033,7 @@ static inline int machine_without_vbus_sense(void)
 {
 	return machine_is_omap_innovator()
 		|| machine_is_omap_osk()
+		|| machine_is_omap_palmte()
 		|| machine_is_sx1()
 		/* No known omap7xx boards with vbus sense */
 		|| cpu_is_omap7xx();
-- 
2.17.0
