From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 2/7] wl1271: propagate set_power's return value
Date: Thu, 16 Sep 2010 01:22:04 +0200
Message-ID: <1284592929-29616-3-git-send-email-ohad@wizery.com>
References: <1284592929-29616-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1284592929-29616-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Make it possible for the set power method to indicate a
success/failure return value. This is needed to support
more complex power on/off operations such as SDIO
power manipulations.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1271.h      |    2 +-
 drivers/net/wireless/wl12xx/wl1271_io.h   |    9 ++++++---
 drivers/net/wireless/wl12xx/wl1271_main.c |    4 +++-
 drivers/net/wireless/wl12xx/wl1271_sdio.c |   15 +++++++++------
 drivers/net/wireless/wl12xx/wl1271_spi.c  |    4 +++-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wireless/wl12xx/wl1271.h
index dd3cee6..faa5925 100644
--- a/drivers/net/wireless/wl12xx/wl1271.h
+++ b/drivers/net/wireless/wl12xx/wl1271.h
@@ -313,7 +313,7 @@ struct wl1271_if_operations {
 		     bool fixed);
 	void (*reset)(struct wl1271 *wl);
 	void (*init)(struct wl1271 *wl);
-	void (*power)(struct wl1271 *wl, bool enable);
+	int (*power)(struct wl1271 *wl, bool enable);
 	struct device* (*dev)(struct wl1271 *wl);
 	void (*enable_irq)(struct wl1271 *wl);
 	void (*disable_irq)(struct wl1271 *wl);
diff --git a/drivers/net/wireless/wl12xx/wl1271_io.h b/drivers/net/wireless/wl12xx/wl1271_io.h
index bc806c7..c1f92e6 100644
--- a/drivers/net/wireless/wl12xx/wl1271_io.h
+++ b/drivers/net/wireless/wl12xx/wl1271_io.h
@@ -144,10 +144,13 @@ static inline void wl1271_power_off(struct wl1271 *wl)
 	clear_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
 }
 
-static inline void wl1271_power_on(struct wl1271 *wl)
+static inline int wl1271_power_on(struct wl1271 *wl)
 {
-	wl->if_ops->power(wl, true);
-	set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
+	int ret = wl->if_ops->power(wl, true);
+	if (ret == 0)
+		set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
+
+	return ret;
 }
 
 
diff --git a/drivers/net/wireless/wl12xx/wl1271_main.c b/drivers/net/wireless/wl12xx/wl1271_main.c
index 8e55cf8..af26150 100644
--- a/drivers/net/wireless/wl12xx/wl1271_main.c
+++ b/drivers/net/wireless/wl12xx/wl1271_main.c
@@ -621,7 +621,9 @@ static int wl1271_chip_wakeup(struct wl1271 *wl)
 	int ret = 0;
 
 	msleep(WL1271_PRE_POWER_ON_SLEEP);
-	wl1271_power_on(wl);
+	ret = wl1271_power_on(wl);
+	if (ret < 0)
+		goto out;
 	msleep(WL1271_POWER_ON_SLEEP);
 	wl1271_io_reset(wl);
 	wl1271_io_init(wl);
diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index b5d9565..1d5dc72 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -159,35 +159,38 @@ static void wl1271_sdio_raw_write(struct wl1271 *wl, int addr, void *buf,
 		wl1271_error("sdio write failed (%d)", ret);
 }
 
-static void wl1271_sdio_power_on(struct wl1271 *wl)
+static int wl1271_sdio_power_on(struct wl1271 *wl)
 {
 	struct sdio_func *func = wl_to_func(wl);
 
 	sdio_claim_host(func);
 	sdio_enable_func(func);
 	sdio_release_host(func);
+
+	return 0;
 }
 
-static void wl1271_sdio_power_off(struct wl1271 *wl)
+static int wl1271_sdio_power_off(struct wl1271 *wl)
 {
 	struct sdio_func *func = wl_to_func(wl);
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
+
+	return 0;
 }
 
-static void wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
+static int wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
 {
 	/* Let the SDIO stack handle wlan_enable control, so we
 	 * keep host claimed while wlan is in use to keep wl1271
 	 * alive.
 	 */
 	if (enable)
-		wl1271_sdio_power_on(wl);
+		return wl1271_sdio_power_on(wl);
 	else
-		wl1271_sdio_power_off(wl);
-
+		return wl1271_sdio_power_off(wl);
 }
 
 static struct wl1271_if_operations sdio_ops = {
diff --git a/drivers/net/wireless/wl12xx/wl1271_spi.c b/drivers/net/wireless/wl12xx/wl1271_spi.c
index c3fdab7..de56d8d 100644
--- a/drivers/net/wireless/wl12xx/wl1271_spi.c
+++ b/drivers/net/wireless/wl12xx/wl1271_spi.c
@@ -312,10 +312,12 @@ static irqreturn_t wl1271_irq(int irq, void *cookie)
 	return IRQ_HANDLED;
 }
 
-static void wl1271_spi_set_power(struct wl1271 *wl, bool enable)
+static int wl1271_spi_set_power(struct wl1271 *wl, bool enable)
 {
 	if (wl->set_power)
 		wl->set_power(enable);
+
+	return 0;
 }
 
 static struct wl1271_if_operations spi_ops = {
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
