From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v3 2/4] USB: OMAP1: add extcon to platform data
Date: Tue, 18 Jun 2013 20:06:59 +0300
Message-ID: <1371575221-360-3-git-send-email-aaro.koskinen@iki.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1371575221-360-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add extcon field to platform data.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 include/linux/platform_data/usb-omap1.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/usb-omap1.h b/include/linux/platform_data/usb-omap1.h
index 8c7764d..43b5ce1 100644
--- a/include/linux/platform_data/usb-omap1.h
+++ b/include/linux/platform_data/usb-omap1.h
@@ -23,6 +23,8 @@ struct omap_usb_config {
 	unsigned	register_dev:1;
 	u8		otg;	/* port number, 1-based:  usb1 == 2 */
 
+	const char	*extcon;	/* extcon device for OTG */
+
 	u8		hmc_mode;
 
 	/* implicitly true if otg:  host supports remote wakeup? */
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
