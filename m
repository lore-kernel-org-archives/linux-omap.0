From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [EXTERNAL] [PATCHv2 0/5] Runtime PM support for wlcore
Date: Tue, 22 May 2018 10:23:43 -0700
Message-ID: <20180522172343.GK98604@atomide.com>
References: <20180517185029.71716-1-tony@atomide.com>
 <bff51dcc6fd441d9ab42db273219aaf4@ti.com>
 <20180521163830.GZ98604@atomide.com>
 <20180521224339.GD98604@atomide.com>
 <38ddca4c73bb4dbf835a84133035dbfb@ti.com>
 <20180522133158.GE98604@atomide.com>
 <eae7c720c09549f0b4ff83f88ad6959b@ti.com>
 <20180522135511.GI98604@atomide.com>
 <92eff64ea59740bfa395b53ff22c07d3@ti.com>
 <20180522150111.GJ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180522150111.GJ98604-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Loewy, Chen" <c-loewy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180522 15:03]:
> * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180522 14:07]:
> > > > >
> > > > > OK try replacing the pm_runtime_put_noidle() above with just
> > > > > pm_runtime_put_sync(). The reason why I put noidle there was the
> > > > > wlcore_fw_sleep() call, with that gone put_sync should do the trick.
> > > > >
> > > >
> > > > I have tried that already. Same problem. The last call to:
> > > > ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_SLEEP)
> > > >
> > > > which allows the firmware to get into ELP state during wowlan suspend is
> > > > only completing after system resume for some unknown reason...
> > > 
> > > Hmm maybe try also adding wl1271_power_off(wl) after put_sync()?
> > > 
> > 
> > No, we don't want to power off the chip in wowlan mode.
> > We power it of only during standard suspend.
> > 
> > The trick is that it stays on during suspend and can be used 
> > As a wakeup source to the host on specific packets received by
> > The firmware over the air.
> 
> Oh right, then in theory pm_runtime_put_sync() should do the
> here.

OK got my beaglebone green wireless to wake from suspend to UART
after doing:

# echo N > /sys/module/printk/parameters/console_suspend

No idea why that is needed.. Not needed on beaglebone black here.

Here's a modified version of your patch, does that put wlcore to
idle with wowlan during suspend for you?

Regards,

Tony

8< ------------------------------
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -998,24 +998,6 @@ static int wlcore_fw_wakeup(struct wl1271 *wl)
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
@@ -1738,6 +1720,7 @@ static int __maybe_unused wl1271_op_suspend(struct ieee80211_hw *hw,
 {
 	struct wl1271 *wl = hw->priv;
 	struct wl12xx_vif *wlvif;
+	unsigned long flags;
 	int ret;
 
 	wl1271_debug(DEBUG_MAC80211, "mac80211 suspend wow=%d", !!wow);
@@ -1785,7 +1768,6 @@ static int __maybe_unused wl1271_op_suspend(struct ieee80211_hw *hw,
 		goto out_sleep;
 
 out_sleep:
-	pm_runtime_put_noidle(wl->dev);
 	mutex_unlock(&wl->mutex);
 
 	if (ret < 0) {
@@ -1795,20 +1777,6 @@ static int __maybe_unused wl1271_op_suspend(struct ieee80211_hw *hw,
 
 	/* flush any remaining work */
 	wl1271_debug(DEBUG_MAC80211, "flushing remaining works");
-
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
@@ -1817,14 +1785,16 @@ static int __maybe_unused wl1271_op_suspend(struct ieee80211_hw *hw,
 	 */
 	cancel_delayed_work(&wl->tx_watchdog_work);
 
+
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
+
+	pm_runtime_put_sync(wl->dev);
 
 	return 0;
 }
-- 
2.17.0
