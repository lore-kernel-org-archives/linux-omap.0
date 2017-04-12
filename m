From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] mfd: menelaus: remove obsolete local_irq_disable() and
 local_irq_enable()
Date: Wed, 12 Apr 2017 23:15:23 +0300
Message-ID: <20170412201523.goonigemlsez5m46@raspberrypi-3.musicnaut.iki.fi>
References: <1491817038-4956-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491817038-4956-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Tony Lindgren <tony@atomide.com>
Cc: lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Henri Roosen <henri.roosen@ginzinger.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 10, 2017 at 11:37:18AM +0200, Martin Kepplinger wrote:
> Since
> 
> commit e6229bec25be ("rtc: make rtc_update_irq callable with irqs enabled")
> 
> rtc_update_irq() is callable with irqs enabled, see the rtc drivers.
> So update this accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Cc: Henri Roosen <henri.roosen@ginzinger.com>

I think the patch looks OK, so:

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

But when trying to test it on N810/N800, I noticed I was missing RTC
altogether. My custom config was missing CONFIG_RTC_DRV_TWL92330, but
when enabling it I still get:

[    5.759918] menelaus 0-0072: no 32k oscillator

Anyway, this issue is unrelated to this patch...

A.

> ---
>  drivers/mfd/menelaus.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index a4a8f1e..29b7164 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1022,9 +1022,7 @@ static int menelaus_set_alarm(struct device *dev, struct rtc_wkalrm *w)
>  static void menelaus_rtc_update_work(struct menelaus_chip *m)
>  {
>  	/* report 1/sec update */
> -	local_irq_disable();
>  	rtc_update_irq(m->rtc, 1, RTC_IRQF | RTC_UF);
> -	local_irq_enable();
>  }
>  
>  static int menelaus_ioctl(struct device *dev, unsigned cmd, unsigned long arg)
> @@ -1086,9 +1084,7 @@ static const struct rtc_class_ops menelaus_rtc_ops = {
>  static void menelaus_rtc_alarm_work(struct menelaus_chip *m)
>  {
>  	/* report alarm */
> -	local_irq_disable();
>  	rtc_update_irq(m->rtc, 1, RTC_IRQF | RTC_AF);
> -	local_irq_enable();
>  
>  	/* then disable it; alarms are oneshot */
>  	the_menelaus->rtc_control &= ~RTC_CTRL_AL_EN;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
