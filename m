From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] wlcore: fix race for WL1271_FLAG_IRQ_RUNNING
Date: Mon,  7 Oct 2019 08:37:31 -0700
Message-ID: <20191007153731.58045-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We set WL1271_FLAG_IRQ_RUNNING in the beginning of wlcore_irq(), and test
for it in wlcore_runtime_resume(). But WL1271_FLAG_IRQ_RUNNING currently
gets cleared too early by wlcore_irq_locked() before wlcore_irq() is done
calling it. And this will race against wlcore_runtime_resume() testing it.

Let's set and clear IRQ_RUNNING in wlcore_irq() so wlcore_runtime_resume()
can rely on it. And let's remove old comments about hardirq, that's no
longer the case as we're using request_threaded_irq().

This fixes occasional annoying wlcore firmware reboots stat start with
"wlcore: WARNING ELP wakeup timeout!" followed by a multisecond latency
when the wlcore firmware gets wrongly rebooted waiting for an ELP wake
interrupt that won't be coming.

Note that I also suspect some form of this issue was the root cause why
the wlcore GPIO interrupt has been often configured as a level interrupt
instead of edge as an attempt to work around the ELP wake timeout errors.

Fixes: fa2648a34e73 ("wlcore: Add support for runtime PM")
Cc: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Guy Mishol <guym-l0cyMroinI0@public.gmane.org>
Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

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
 
@@ -692,6 +687,9 @@ static irqreturn_t wlcore_irq(int irq, void *cookie)
 
 	mutex_unlock(&wl->mutex);
 
+out_handled:
+	clear_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.23.0
