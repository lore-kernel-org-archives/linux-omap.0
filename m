From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 01/10] usb: phy: generic: Add gpio_reset to platform data
Date: Tue, 24 Sep 2013 11:53:47 +0300
Message-ID: <1380012836-29900-2-git-send-email-rogerq@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380012836-29900-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The GPIO number of the RESET line can be passed to the
driver using the gpio_reset member.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 include/linux/usb/usb_phy_gen_xceiv.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/usb_phy_gen_xceiv.h b/include/linux/usb/usb_phy_gen_xceiv.h
index f9a7e7b..42f3b71 100644
--- a/include/linux/usb/usb_phy_gen_xceiv.h
+++ b/include/linux/usb/usb_phy_gen_xceiv.h
@@ -9,7 +9,8 @@ struct usb_phy_gen_xceiv_platform_data {
 
 	/* if set fails with -EPROBE_DEFER if can't get regulator */
 	unsigned int needs_vcc:1;
-	unsigned int needs_reset:1;
+	unsigned int needs_reset:1;	/* deprecated */
+	int gpio_reset;
 };
 
 #if IS_ENABLED(CONFIG_NOP_USB_XCEIV)
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
