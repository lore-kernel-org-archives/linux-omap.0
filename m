From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/9] usb: phy: nop: Add gpio_reset to platform data
Date: Wed, 14 Aug 2013 16:58:05 +0300
Message-ID: <1376488693-31659-2-git-send-email-rogerq@ti.com>
References: <1376488693-31659-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376488693-31659-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The GPIO number of the RESET line can be passed to the
driver using the gpio_reset member.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 include/linux/usb/nop-usb-xceiv.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 148d351..1e57acb 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -9,7 +9,9 @@ struct nop_usb_xceiv_platform_data {
 
 	/* if set fails with -EPROBE_DEFER if can't get regulator */
 	unsigned int needs_vcc:1;
-	unsigned int needs_reset:1;
+	unsigned int needs_reset:1; /* Deprecated */
+
+	int gpio_reset;
 };
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
