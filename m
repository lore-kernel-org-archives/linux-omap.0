From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv3] wlcore: clean-up clearing of WL1271_FLAG_IRQ_RUNNING
Date: Wed,  9 Oct 2019 09:50:06 -0700
Message-ID: <20191009165006.41567-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), but clear
it before interrupt handling is done in wlcore_irq_locked().

Let's move the clearing to the end of wlcore_irq() where it gets set,
and remove the old comments about hardirq. That's no longer the case as
we're using request_threaded_irq().

Note that the WL1271_FLAG_IRQ_RUNNING should never race between the
interrupt handler and wlcore_runtime_resume() as because of autosuspend
timeout we cannot enter idle between wlcore_irq_locked() and the end of
wlcore_irq().

Cc: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Guy Mishol <guym-l0cyMroinI0@public.gmane.org>
Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Changes since v2:

- Downgraded to clean-up from a fix as the race should never happen

Changes since v1:

- Add locking around clear_bit like we do elsewhere in the driver

---
 drivers/net/wireless/ti/wlcore/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -544,11 +544,6 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 	}
 
 	while (!done && loopcount--) {
-		/*
-		 * In order to avoid a race with the hardirq, clear the flag
-		 * before acknowledging the chip.
-		 */
-		clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
 		smp_mb__after_atomic();
 
 		ret = wlcore_fw_status(wl, wl->fw_status);
@@ -668,7 +663,7 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 		disable_irq_nosync(wl->irq);
 		pm_wakeup_event(wl->dev, 0);
 		spin_unlock_irqrestore(&wl->wl_lock, flags);
-		return IRQ_HANDLED;
+		goto out_handled;
 	}
 	spin_unlock_irqrestore(&wl->wl_lock, flags);
 
@@ -692,6 +687,11 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 
 	mutex_unlock(&wl->mutex);
 
+out_handled:
+	spin_lock_irqsave(&wl->wl_lock, flags);
+	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
+	spin_unlock_irqrestore(&wl->wl_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.23.0
