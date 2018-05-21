From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/5] wlcore: sdio: Warn about runtime PM suspend errors
Date: Mon, 21 May 2018 15:32:32 -0700
Message-ID: <20180521223232.GC98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <20180517185029.71716-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180517185029.71716-6-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180517 18:53]:
> We may get -EBUSY from runtime PM and that most likely means some
> earlier wlcore command did not complete yet and further calls may
> fail. Let's add a warning to make it easier to track down and fix
> such issues in wlcore code.

Related to the warnings produced with this patch, the following additional
patch seems to fix the timeout errors that happen at some point after
forcing recovery a few times.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 16 May 2018 14:14:47 -0700
Subject: [PATCH] wclore: Fix timout errors after recovery

After enabling runtime PM, if we force hardware reset multiple times with:

# echo 1 > /sys/kernel/debug/ieee80211/phy0/wlcore/start_recovery

We will after few tries get the following error:

wlcore: ERROR timeout waiting for the hardware to complete initialization

And then wlcore is unable to reconnect until after the wlcore related modules
are reloaded.

Let's fix this by moving pm_runtime_put() earlier before we restart the hardware.
And let's use the sync version to make sure we're done before we restart.

Note that we still will get -EBUSY warning from wl12xx_sdio_set_power() but let's
fix that separately once we know exactly why we get the warning.

Reported-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -977,6 +977,7 @@ static void wl1271_recovery_work(struct work_struct *work)
 	}
 
 	wlcore_op_stop_locked(wl);
+	pm_runtime_put_sync(wl->dev);
 
 	ieee80211_restart_hw(wl->hw);
 
@@ -986,8 +987,6 @@ static void wl1271_recovery_work(struct work_struct *work)
 	 */
 	wlcore_wake_queues(wl, WLCORE_QUEUE_STOP_REASON_FW_RESTART);
 
-	pm_runtime_put(wl->dev);
