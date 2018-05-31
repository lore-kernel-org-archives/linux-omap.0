From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFT 3/6] wlcore: Add support for runtime PM
Date: Thu, 31 May 2018 10:14:20 -0700
Message-ID: <20180531171420.GQ5705@atomide.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180529180605.73622-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [180529 18:09]:
> --- a/drivers/net/wireless/ti/wlcore/main.c
> +++ b/drivers/net/wireless/ti/wlcore/main.c
...
> +static int __maybe_unused wlcore_runtime_resume(struct device *dev)
> +{
> +	struct wl1271 *wl = dev_get_drvdata(dev);
> +	DECLARE_COMPLETION_ONSTACK(compl);
> +	unsigned long flags;
> +	int ret;
> +	unsigned long start_time = jiffies;
> +	bool pending = false;
> +
> +	/* Nothing to do if no ELP mode requested */
> +	if (!test_bit(WL1271_FLAG_IN_ELP, &wl->flags))
> +		return 0;
> +
> +	wl1271_debug(DEBUG_PSM, "waking up chip from elp");
> +
> +	spin_lock_irqsave(&wl->wl_lock, flags);
> +	if (test_bit(WL1271_FLAG_IRQ_RUNNING, &wl->flags))
> +		pending = true;
> +	else
> +		wl->elp_compl = &compl;
> +	spin_unlock_irqrestore(&wl->wl_lock, flags);
> +
> +	ret = wlcore_raw_write32(wl, HW_ACCESS_ELP_CTRL_REG, ELPCTRL_WAKE_UP);
> +	if (ret < 0) {
> +		wl12xx_queue_recovery_work(wl);
> +		goto err;
> +	}
> +
> +	if (!pending) {
> +		ret = wait_for_completion_timeout(&compl,
> +			msecs_to_jiffies(WL1271_WAKEUP_TIMEOUT));
> +		if (ret == 0) {
> +			wl1271_error("ELP wakeup timeout!");
> +			wl12xx_queue_recovery_work(wl);
> +
> +			/* Return no error for runtime PM for recovery */
> +			return 0;

I noticed returning here and not clearing WL1271_FLAG_IN_ELP can
produce errors. But I think it's unsafe to clear WL1271_FLAG_IN_ELP
if wlcore did not wake. So I suggest we return early here to see the
errors so we can fix the issues. I'll post one more patch that fixes
the init time "ELP wakeup timeout!" issues for me.

Regards,

Tony
