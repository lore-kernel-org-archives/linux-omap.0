From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v6 10/10] clocksource: timer-dm: Check prescaler value
Date: Thu, 4 Jan 2018 23:47:13 +0100
Message-ID: <20180104224713.GA11557@lenoch>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
 <1514887799-24605-11-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514887799-24605-11-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 02, 2018 at 03:39:59PM +0530, Keerthy wrote:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> Invalid prescaler value is silently ignored. Fix that
> by returning -EINVAL in such case. As invalid value
> disabled use of the prescaler, use -1 explicitely for
> that purpose.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/clocksource/timer-dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index 60db173..01a9cb0 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -672,6 +672,9 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
>  	if (prescaler >= 0x00 && prescaler <= 0x07) {
>  		l |= OMAP_TIMER_CTRL_PRE;
>  		l |= prescaler << 2;
> +	} else {
> +		if (prescaler != -1)
> +			return -EINVAL;

Argh... This is actually wrong, as it leaves timer enabled.
I suggest simply dropping this patch and I'll rethink whole
approach a bit later (and better).

>  	}
>  	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>  

Sorry for the noise,
	ladis
