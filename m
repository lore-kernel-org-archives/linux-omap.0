From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Tue, 8 Jan 2019 17:51:24 -0800
Message-ID: <20190109015124.GO5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109014218.GA8363@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > Anything higher than 2200 ms seems to somehow time out immediately
> > now :)
> 
> This is quite close to the max ns of an int on arm 32bits
> 
> Could you try the patch below ?

Yup great thanks, that's it:

Tested-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7062469..44c5c76 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  
>  	last_busy = READ_ONCE(dev->power.last_busy);
>  
> -	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
> +	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
>  	if (expires <= now)
>  		expires = 0;	/* Already expired. */
>  
> -- 
> 2.7.4
> 
> 
> > 
> > Regards,
> > 
> > Tony
