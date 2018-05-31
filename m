From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [RFT 7/6] wlcore: Make sure firmware is initialized in
 wl1271_op_add_interface()
Date: Thu, 31 May 2018 10:17:40 -0700
Message-ID: <20180531171740.GR5705@atomide.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180529180605.73622-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We have wl12xx_boot() call wl12xx_enable_interrupts() and if we have
wl1271_op_add_interface() call pm_runtime_get_sync() before the interrupts
are enabled. And then we get the following error during boot:

wlcore: ERROR ELP wakeup timeout!

Let's fix this by first checking if we need to boot the firmware. And
only after that call pm_runtime_get_sync() when interrupts are enabled.
And only after that do the check for wl12xx_need_fw_change().

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Here's one more patch to test for this series.

---
 drivers/net/wireless/ti/wlcore/main.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2537,11 +2537,6 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 	wl12xx_get_vif_count(hw, vif, &vif_count);
 
 	mutex_lock(&wl->mutex);
-	ret = pm_runtime_get_sync(wl->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(wl->dev);
-		goto out_unlock;
-	}
 
 	/*
 	 * in some very corner case HW recovery scenarios its possible to
@@ -2570,14 +2565,6 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 	if (ret < 0)
 		goto out;
 
-	if (wl12xx_need_fw_change(wl, vif_count, true)) {
-		wl12xx_force_active_psm(wl);
-		set_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
-		mutex_unlock(&wl->mutex);
-		wl1271_recovery_work(&wl->recovery_work);
-		return 0;
-	}
-
 	/*
 	 * TODO: after the nvs issue will be solved, move this block
 	 * to start(), and make sure here the driver is ON.
@@ -2594,6 +2581,24 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 			goto out;
 	}
 
+	/*
+	 * Call runtime PM only after possible wl12xx_init_fw() above
+	 * is done. Otherwise we do not have interrupts enabled.
+	 */
+	ret = pm_runtime_get_sync(wl->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(wl->dev);
+		goto out_unlock;
+	}
+
+	if (wl12xx_need_fw_change(wl, vif_count, true)) {
+		wl12xx_force_active_psm(wl);
+		set_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+		mutex_unlock(&wl->mutex);
+		wl1271_recovery_work(&wl->recovery_work);
+		return 0;
+	}
+
 	if (!wlcore_is_p2p_mgmt(wlvif)) {
 		ret = wl12xx_cmd_role_enable(wl, vif->addr,
 					     role_type, &wlvif->role_id);
-- 
2.17.0
