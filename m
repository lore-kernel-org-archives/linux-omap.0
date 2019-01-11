From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM/runtime: Fix 'jiffies' in comments after move to hrtimers
Date: Fri, 11 Jan 2019 11:40:44 +0100
Message-ID: <1861668.sGDoxnQT1I@aspire.rjw.lan>
References: <20190109172336.GA1711@lenoch> <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com> <20190109231944.GA21177@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109231944.GA21177@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thursday, January 10, 2019 12:19:44 AM CET Ladislav Michl wrote:
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
> 
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v2: Reword comment accoring to Rafael's suggestion
> 
>  drivers/base/power/runtime.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..a282e74d1a16 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
>   * Compute the autosuspend-delay expiration time based on the device's
>   * power.last_busy time.  If the delay has already expired or is disabled
>   * (negative) or the power.use_autosuspend flag isn't set, return 0.
> - * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
> + * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
>   *
>   * This function may be called either with or without dev->power.lock held.
>   * Either way it can be racy, since power.last_busy may be updated at any time.
> @@ -905,7 +905,10 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>  	spin_lock_irqsave(&dev->power.lock, flags);
>  
>  	expires = dev->power.timer_expires;
> -	/* If 'expire' is after 'jiffies' we've been called too early. */
> +	/*
> +	 * If 'expires' is after the current time, we've been called
> +	 * too early.
> +	 */
>  	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>  		dev->power.timer_expires = 0;
>  		rpm_suspend(dev, dev->power.timer_autosuspends ?
> 

Applied, thanks!
