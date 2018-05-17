From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2] wlcore: sdio: Fix flakey SDIO runtime PM handling
Date: Thu, 17 May 2018 11:29:50 -0700
Message-ID: <20180517182950.60807-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We can have pm_runtime_get_sync() return 1, and we can have
pm_runtime_put_sync() return -EBUSY. See rpm_suspend() and
rpm_resume() for more information.

Fix the issue by returning 0 from wl12xx_sdio_power_on() on success.
And use pm_runtime_put() instead of pm_runtime_put_sync() for
wl12xx_sdio_power_off(), then the MMC subsystem will idle the bus
when suitable.

Otherwise wlcore can sometimes get confused and may report bogus
errors and WLAN connection can fail.

Note that while wlcore checks the return value for wl1271_power_on(),
the return value is ignored for wl1271_power_off(). Let's fix them
both though to avoid further confusion in the future.

Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Changes since v1:

- Just ignore -EBUSY error for pm_runtime_put(), we're not checking
  the return value for wl12xx_sdio_power_off() anyways currently

---
 drivers/net/wireless/ti/wlcore/sdio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -159,28 +159,36 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 		pm_runtime_put_noidle(&card->dev);
 		dev_err(glue->dev, "%s: failed to get_sync(%d)\n",
 			__func__, ret);
-		goto out;
+
+		return ret;
 	}
 
 	sdio_claim_host(func);
 	sdio_enable_func(func);
 	sdio_release_host(func);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
+	int error;
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
 	/* Let runtime PM know the card is powered off */
-	return pm_runtime_put_sync(&card->dev);
+	error = pm_runtime_put(&card->dev);
+	if (error < 0 && error != -EBUSY) {
+		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
+
+		return error;
+	}
+
+	return 0;
 }
 
 static int wl12xx_sdio_set_power(struct device *child, bool enable)
-- 
2.17.0
