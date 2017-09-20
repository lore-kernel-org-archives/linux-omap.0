From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 4/4] usb: musb: da8xx: Remove duplicated defines
Date: Wed, 20 Sep 2017 09:35:13 +0200
Message-ID: <20170920073513.11650-5-abailon@baylibre.com>
References: <20170920073513.11650-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920073513.11650-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

There is some registers defined in da8xx.c though they are not used.
These registers are also defined and used in musb_cppi41.c
Remove these defines from da8xx.c.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/da8xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index df88123274ca..2ec2039eee86 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -50,10 +50,7 @@
 #define DA8XX_USB_CTRL_REG	0x04
 #define DA8XX_USB_STAT_REG	0x08
 #define DA8XX_USB_EMULATION_REG 0x0c
-#define DA8XX_USB_MODE_REG	0x10	/* Transparent, CDC, [Generic] RNDIS */
-#define DA8XX_USB_AUTOREQ_REG	0x14
 #define DA8XX_USB_SRP_FIX_TIME_REG 0x18
-#define DA8XX_USB_TEARDOWN_REG	0x1c
 #define DA8XX_USB_INTR_SRC_REG	0x20
 #define DA8XX_USB_INTR_SRC_SET_REG 0x24
 #define DA8XX_USB_INTR_SRC_CLEAR_REG 0x28
-- 
2.13.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
