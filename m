From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: menelaus: remove obsolete local_irq_disable() and
 local_irq_enable()
Date: Mon, 24 Apr 2017 12:51:40 +0100
Message-ID: <20170424115140.oewg25llpa4cxapg@dell>
References: <1491817038-4956-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491817038-4956-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Henri Roosen <henri.roosen@ginzinger.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 10 Apr 2017, Martin Kepplinger wrote:

> Since
> 
> commit e6229bec25be ("rtc: make rtc_update_irq callable with irqs enabled")
> 
> rtc_update_irq() is callable with irqs enabled, see the rtc drivers.
> So update this accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Cc: Henri Roosen <henri.roosen@ginzinger.com>
> ---
>  drivers/mfd/menelaus.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

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

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
