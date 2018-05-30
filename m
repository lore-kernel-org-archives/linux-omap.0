From: Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFT v2, 6/6] wlcore: Use generic runtime pm calls for wowlan elp configuration
Date: Wed, 30 May 2018 11:57:46 +0300
Message-ID: <1527670666-22779-1-git-send-email-eyalr@ti.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, MaximAltshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With runtime PM enabled, we can now use calls to pm_runtime_force_suspend
and pm_runtime_force_resume for enabling elp during suspend when wowlan
is enabled and waking the chip from elp on resume.

Remove the custom API that was used to ensure that the command
that is used to allow ELP during suspend is completed before the system
suspend.

Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
Changes since v1:
use pm_runtime_force_() instaed of pm_generic_runtime_() calls

 drivers/net/wireless/ti/wlcore/main.c | 51 +++++++++--------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 890397a..36d7055 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -1000,24 +1000,6 @@ static int wlcore_fw_wakeup(struct wl1271 *wl)
 	return wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
 }
 
-static int wlcore_fw_sleep(struct wl1271 *wl)
-{
-	int ret;
-
-	mutex_lock(&wl->mutex);
-	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_SLEEP);
-	if (ret < 0) {
-		wl12xx_queue_recovery_work(wl);
-		goto out;
-	}
-	set_bit(WL1271_FLAG_IN_ELP, &wl->flags);
-out:
-	mutex_unlock(&wl->mutex);
-	mdelay(WL1271_SUSPEND_SLEEP);
-
-	return 0;
-}
-
 static int wl1271_setup(struct wl1271 *wl)
 {
 	wl->raw_fw_status = kzalloc(wl->fw_status_len, GFP_KERNEL);
@@ -1741,6 +1723,7 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
+	unsigned long flags;
 	int ret;
 
 	wl1271_debug(DEBUG_MAC80211, "mac80211 suspend wow=%d", !!wow);
@@ -1799,19 +1782,6 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
 	/* flush any remaining work */
 	wl1271_debug(DEBUG_MAC80211, "flushing remaining works");
 
-	/*
-	 * disable and re-enable interrupts in order to flush
-	 * the threaded_irq
-	 */
-	wlcore_disable_interrupts(wl);
-
-	/*
-	 * set suspended flag to avoid triggering a new threaded_irq
-	 * work. no need for spinlock as interrupts are disabled.
-	 */
-	set_bit(WL1271_FLAG_SUSPENDED, &wl->flags);
-
-	wlcore_enable_interrupts(wl);
 	flush_work(&wl->tx_work);
 
 	/*
@@ -1821,15 +1791,14 @@ static int wl1271_op_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work(&wl->tx_watchdog_work);
 
 	/*
-	 * Use an immediate call for allowing the firmware to go into power
-	 * save during suspend.
-	 * Using a workque for this last write was only hapenning on resume
-	 * leaving the firmware with power save disabled during suspend,
-	 * while consuming full power during wowlan suspend.
+	 * set suspended flag to avoid triggering a new threaded_irq
+	 * work.
 	 */
-	wlcore_fw_sleep(wl);
+	spin_lock_irqsave(&wl->wl_lock, flags);
+	set_bit(WL1271_FLAG_SUSPENDED, &wl->flags);
+	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
-	return 0;
+	return pm_runtime_force_suspend(wl->dev);
 }
 
 static int wl1271_op_resume(struct ieee80211_hw *hw)
@@ -1844,6 +1813,12 @@ static int wl1271_op_resume(struct ieee80211_hw *hw)
 		     wl->wow_enabled);
 	WARN_ON(!wl->wow_enabled);
 
+	ret = pm_runtime_force_resume(wl->dev);
+	if (ret < 0) {
+		wl1271_error("ELP wakeup failure!");
+		goto out_sleep;
+	}
+
 	/*
 	 * re-enable irq_work enqueuing, and call irq_work directly if
 	 * there is a pending work.
-- 
2.7.4
