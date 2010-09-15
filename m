From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 4/7] wl1271: take irq info from private board data
Date: Thu, 16 Sep 2010 01:31:35 +0200
Message-ID: <1284593495-30012-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the hard coded irq information, and instead take
the irq information from the board's platform data.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1271_sdio.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index 1d5dc72..987ecdc 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -29,14 +29,12 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/card.h>
 #include <linux/gpio.h>
+#include <linux/wl12xx.h>
 
 #include "wl1271.h"
 #include "wl12xx_80211.h"
 #include "wl1271_io.h"
 
-
-#define RX71_WL1271_IRQ_GPIO		42
-
 #ifndef SDIO_VENDOR_ID_TI
 #define SDIO_VENDOR_ID_TI		0x0097
 #endif
@@ -208,6 +206,7 @@ static int __devinit wl1271_probe(struct sdio_func *func,
 				  const struct sdio_device_id *id)
 {
 	struct ieee80211_hw *hw;
+	const struct wl12xx_platform_data *wlan_data;
 	struct wl1271 *wl;
 	int ret;
 
@@ -227,13 +226,15 @@ static int __devinit wl1271_probe(struct sdio_func *func,
 	/* Grab access to FN0 for ELP reg. */
 	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
 
-	wl->irq = gpio_to_irq(RX71_WL1271_IRQ_GPIO);
-	if (wl->irq < 0) {
-		ret = wl->irq;
-		wl1271_error("could not get irq!");
+	wlan_data = wl12xx_get_platform_data();
+	if (IS_ERR(wlan_data)) {
+		ret = PTR_ERR(wlan_data);
+		wl1271_error("missing wlan platform data: %d", ret);
 		goto out_free;
 	}
 
+	wl->irq = wlan_data->irq;
+
 	ret = request_irq(wl->irq, wl1271_irq, 0, DRIVER_NAME, wl);
 	if (ret < 0) {
 		wl1271_error("request_irq() failed: %d", ret);
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
