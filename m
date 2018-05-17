From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/5] wlcore: Make sure PM calls are paired
Date: Thu, 17 May 2018 11:50:26 -0700
Message-ID: <20180517185029.71716-3-tony@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180517185029.71716-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The call to wl1271_ps_elp_wakeup() in wl12xx_queue_recovery_work() is
unpaired. Let's remove it and add paired calls to wl1271_recovery_work()
instead in preparation for changing things to use runtime PM.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -796,8 +796,6 @@ void wl12xx_queue_recovery_work(struct wl1271 *wl)
 
 		wl->state = WLCORE_STATE_RESTARTING;
 		set_bit(WL1271_FLAG_RECOVERY_IN_PROGRESS, &wl->flags);
-		wl1271_ps_elp_wakeup(wl);
-		wlcore_disable_interrupts_nosync(wl);
 		ieee80211_queue_work(wl->hw, &wl->recovery_work);
 	}
 }
@@ -919,12 +917,18 @@ static void wl1271_recovery_work(struct work_struct *work)
 		container_of(work, struct wl1271, recovery_work);
 	struct wl12xx_vif *wlvif;
 	struct ieee80211_vif *vif;
+	int error;
 
 	mutex_lock(&wl->mutex);
 
 	if (wl->state == WLCORE_STATE_OFF || wl->plt)
 		goto out_unlock;
 
+	error = wl1271_ps_elp_wakeup(wl);
+	if (error < 0)
+		wl1271_warning("Enable for recovery failed");
+	wlcore_disable_interrupts_nosync(wl);
+
 	if (!test_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags)) {
 		if (wl->conf.fwlog.output == WL12XX_FWLOG_OUTPUT_HOST)
 			wl12xx_read_fwlog_panic(wl);
@@ -967,6 +971,8 @@ static void wl1271_recovery_work(struct work_struct *work)
 	 */
 	wlcore_wake_queues(wl, WLCORE_QUEUE_STOP_REASON_FW_RESTART);
 
+	wl1271_ps_elp_sleep(wl);
+
 out_unlock:
 	wl->watchdog_recovery = false;
 	clear_bit(WL1271_FLAG_RECOVERY_IN_PROGRESS, &wl->flags);
-- 
2.17.0
