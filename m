From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] wlcore: sdio: Fixup power on/off sequence
Date: Tue, 15 Jan 2019 16:04:33 +0100
Message-ID: <20190115150433.12558-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Eyal Reizer <eyalr@ti.com>, linux-wireless@vger.kernel.org
Cc: Ricardo Salveti <rsalveti@rsalveti.net>, Kishon Vijay Abraham I <kishon@ti.com>, Anders Roxell <anders.roxell@linaro.org>, John Stultz <john.stultz@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

During "wlan-up", we are programming the FW into the WiFi-chip. However,
re-programming the FW doesn't work, unless a power cycle of the WiFi-chip
is made in-between the programmings.

To conform to this requirement and to fix the regression in a simple way,
let's start by allowing that the SDIO card (WiFi-chip) may stay powered on
(runtime resumed) when wl12xx_sdio_power_off() returns. The intent with the
current code is to treat this scenario as an error, but unfortunate this
doesn't work as expected, so let's fix this.

The other part is to guarantee that a power cycle of the SDIO card has been
completed when wl12xx_sdio_power_on() returns, as to allow the FW
programming to succeed. However, relying solely on runtime PM to deal with
this isn't sufficient. For example, userspace may prevent runtime suspend
via sysfs for the device that represents the SDIO card, leading to that the
mmc core also keeps it powered on. For this reason, let's instead do a
brute force power cycle in wl12xx_sdio_power_on().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index bd10165d7eec..bc73085fe806 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -163,6 +163,12 @@ static int wl12xx_sdio_power_on(struct wl12xx_sdio_glue *glue)
 		return ret;
 	}
 
+	/*
+	 * To guarantee that the SDIO card is power cycled, as required to make
+	 * the FW programming to succeed, let's do a brute force HW reset.
+	 */
+	mmc_hw_reset(card->host);
+
 	sdio_claim_host(func);
 	sdio_enable_func(func);
 	sdio_release_host(func);
@@ -174,20 +180,13 @@ static int wl12xx_sdio_power_off(struct wl12xx_sdio_glue *glue)
 {
 	struct sdio_func *func = dev_to_sdio_func(glue->dev);
 	struct mmc_card *card = func->card;
-	int error;
 
 	sdio_claim_host(func);
 	sdio_disable_func(func);
 	sdio_release_host(func);
 
 	/* Let runtime PM know the card is powered off */
-	error = pm_runtime_put(&card->dev);
-	if (error < 0 && error != -EBUSY) {
-		dev_err(&card->dev, "%s failed: %i\n", __func__, error);
-
-		return error;
-	}
-
+	pm_runtime_put(&card->dev);
 	return 0;
 }
 
-- 
2.17.1
