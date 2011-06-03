From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Fri, 03 Jun 2011 09:45:48 -0700
Message-ID: <871uzahnib.fsf@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	<1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57010 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820Ab1FCQpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 12:45:51 -0400
In-Reply-To: <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Fri, 3 Jun 2011 13:00:29 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> modules.
>
> Each DSS module will have get and put functions which can be used to
> enable and disable that module. The functions use pm_runtime and hwmod
> opt-clocks to enable the hardware.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

[...]

> +int dispc_runtime_get(void)
> +{
> +	int r;
> +
> +	mutex_lock(&dispc.runtime_lock);

It's not clear to me what the lock is trying to protect.  I guess it's
the counter?  I don't think it should be needed...

> +	if (dispc.runtime_count++ == 0) {

You shouldn't need your own use-counting here.  The runtime PM core is
already doing usage counting.

Instead, you need to use the ->runtime_suspend() and ->runtime_resume()
callbacks (in dev_pm_ops).  These callbacks are called by the runtime PM
core when the usage count goes to/from zero.

IOW, this function should simply be a pm_runtime_get_sync(), and the
rest of the stuff in this function should be done in the
->runtime_resume() callback, which is only executed when the usage_count
transitions from zero.

> +		DSSDBG("dispc_runtime_get\n");
> +
> +		r = dss_runtime_get();
> +		if (r)
> +			goto err_dss_get;
> +
> +		/* XXX dispc fclk can also come from DSI PLL */
> +		clk_enable(dispc.dss_clk);
> +
> +		r = pm_runtime_get_sync(&dispc.pdev->dev);
> +		WARN_ON(r);
> +		if (r < 0)
> +			goto err_runtime_get;
> +
> +		if (dispc_need_ctx_restore())
> +			dispc_restore_context();
> +	}
> +
> +	mutex_unlock(&dispc.runtime_lock);
> +
> +	return 0;
> +
> +err_runtime_get:
> +	clk_disable(dispc.dss_clk);
> +	dss_runtime_put();
> +err_dss_get:
> +	mutex_unlock(&dispc.runtime_lock);
> +
> +	return r;
>  }
>  
> +void dispc_runtime_put(void)
> +{
> +	mutex_lock(&dispc.runtime_lock);
> +
> +	if (--dispc.runtime_count == 0) {
> +		int r;

Same problem here.  

No usage counting is required (and probably no locking either.)  This
function should simply be a pm_runtime_put(), and the rest of the stuff
should be in the driver's ->runtime_suspend() callback.

> +		DSSDBG("dispc_runtime_put\n");
> +
> +		dispc_save_context();
> +
> +		r = pm_runtime_put_sync(&dispc.pdev->dev);

Does this need to be the _sync() version?  It looks like it could be use
the "normal" (async) version.: pm_runtime_put().

> +		WARN_ON(r);
> +
> +		clk_disable(dispc.dss_clk);
> +
> +		dss_runtime_put();
> +	}
> +
> +	mutex_unlock(&dispc.runtime_lock);
> +}
> +
> +
>  bool dispc_go_busy(enum omap_channel channel)
>  {
>  	int bit;
> @@ -530,7 +645,7 @@ void dispc_go(enum omap_channel channel)
>  	int bit;
>  	bool enable_bit, go_bit;
>  
> -	enable_clocks(1);
> +	dispc_runtime_get();

Based on the above suggestions, you probably don't need dedicated
functions for this.  Just call pm_runtime_get_sync() here...

>  	if (channel == OMAP_DSS_CHANNEL_LCD ||
>  			channel == OMAP_DSS_CHANNEL_LCD2)
> @@ -571,7 +686,7 @@ void dispc_go(enum omap_channel channel)
>  	else
>  		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
>  end:
> -	enable_clocks(0);
> +	dispc_runtime_put();

...and the pm_runtime_put() here.


Kevin
