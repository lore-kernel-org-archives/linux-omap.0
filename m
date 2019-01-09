From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM/runtime: Fix 'jiffies' in comments after move to hrtimers
Date: Wed, 9 Jan 2019 23:03:02 +0100
Message-ID: <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
References: <20190109172336.GA1711@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109172336.GA1711@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 9, 2019 at 6:23 PM Ladislav Michl <ladis@linux-mips.org> wrote:
>
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..096f7996d914 100644
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
> @@ -905,7 +905,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         expires = dev->power.timer_expires;
> -       /* If 'expire' is after 'jiffies' we've been called too early. */
> +       /* If 'timer_expires' after 'now' we've been called too early. */

I would say "If 'expires' is after the current time, we've been called
to early" here.

>         if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> --
> 2.20.1
