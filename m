From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] wlcore: Fix BUG with clear completion on timeout
Date: Mon,  1 Oct 2018 14:38:05 -0700
Message-ID: <20181001213805.86511-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We do not currently clear wl->elp_compl on ELP timeout and we have bogus
lingering pointer that wlcore_irq then will try to access after recovery
is done:

BUG: spinlock bad magic on CPU#1, irq/255-wl12xx/580
...
(spin_dump) from [<c01b9344>] (do_raw_spin_lock+0xc8/0x124)
(do_raw_spin_lock) from [<c09b3970>] (_raw_spin_lock_irqsave+0x68/0x74)
(_raw_spin_lock_irqsave) from [<c01a02f0>] (complete+0x24/0x58)
(complete) from [<bf572610>] (wlcore_irq+0x48/0x17c [wlcore])
(wlcore_irq [wlcore]) from [<c01c5efc>] (irq_thread_fn+0x2c/0x64)
(irq_thread_fn) from [<c01c623c>] (irq_thread+0x148/0x290)
(irq_thread) from [<c016b4b0>] (kthread+0x160/0x17c)
(kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
...

After that the system will hang. Let's fix this by adding a flag for
recovery and moving the recovery work call to to the error handling
section.

And we want to set WL1271_FLAG_INTENDED_FW_RECOVERY and actually clear
it too in wl1271_recovery_work() and just downgrade the error to a
warning to prevent overly verbose output.

Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -957,6 +957,8 @@ static void wl1271_recovery_work(struct work_struct *work)
 	BUG_ON(wl->conf.recovery.bug_on_recovery &&
 	       !test_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags));
 
+	clear_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+
 	if (wl->conf.recovery.no_recovery) {
 		wl1271_info("No recovery (chosen on module load). Fw will remain stuck.");
 		goto out_unlock;
@@ -6710,6 +6712,7 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	int ret;
 	unsigned long start_time = jiffies;
 	bool pending = false;
+	bool recovery = false;
 
 	/* Nothing to do if no ELP mode requested */
 	if (!test_bit(WL1271_FLAG_IN_ELP, &wl->flags))
@@ -6726,7 +6729,7 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 
 	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
 	if (ret < 0) {
-		wl12xx_queue_recovery_work(wl);
+		recovery = true;
 		goto err;
 	}
 
@@ -6734,11 +6737,12 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 		ret = wait_for_completion_timeout(&compl,
 			msecs_to_jiffies(WL1271_WAKEUP_TIMEOUT));
 		if (ret == 0) {
-			wl1271_error("ELP wakeup timeout!");
-			wl12xx_queue_recovery_work(wl);
+			wl1271_warning("ELP wakeup timeout!");
 
 			/* Return no error for runtime PM for recovery */
-			return 0;
+			ret = 0;
+			recovery = true;
+			goto err;
 		}
 	}
 
@@ -6753,6 +6757,12 @@ static int __maybe_unused wlcore_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&wl->wl_lock, flags);
 	wl->elp_compl = NULL;
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
+
+	if (recovery) {
+		set_bit(WL1271_FLAG_INTENDED_FW_RECOVERY, &wl->flags);
+		wl12xx_queue_recovery_work(wl);
+	}
+
 	return ret;
 }
 
-- 
2.19.0
