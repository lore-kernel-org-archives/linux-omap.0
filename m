From: Francisco Alecrim <alecrim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC/PATCH 2/2] fix compile for tahvo-usb.c
Date: Thu,  7 Jan 2010 21:03:12 -0400
Message-ID: <1262912592-7817-2-git-send-email-alecrim@gmail.com>
References: <1262912592-7817-1-git-send-email-alecrim@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262912592-7817-1-git-send-email-alecrim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>

drivers/cbus/tahvo-usb.c:138: undefined reference to 'usb_bus_start_enum'

usb_bus_start_enum only exported if USB_OTG enabled

Signed-off-by: Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
---
 drivers/cbus/tahvo-usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 9f8bbcc..762671a 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -132,12 +132,14 @@ static irqreturn_t omap_otg_irq(int irq, void *arg)
 	} else if (otg_irq & A_VBUS_ERR) {
 		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
 	} else if (otg_irq & DRIVER_SWITCH) {
+#ifdef CONFIG_USB_OTG
 		if ((!(omap_readl(OTG_CTRL) & OTG_DRIVER_SEL)) &&
 		   tu->otg.host && tu->otg.state == OTG_STATE_A_HOST) {
 			/* role is host */
 			usb_bus_start_enum(tu->otg.host,
 					   tu->otg.host->otg_port);
 		}
+#endif
 		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
 	} else
 		return IRQ_NONE;
-- 
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
