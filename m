From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] rtc: omap: Enable RTC_IRQWAKEEN bits when Alarm is set
Date: Fri, 30 May 2014 14:20:36 +0530
Message-ID: <5388465C.4090204@ti.com>
References: <1401439702-21626-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39294 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878AbaE3Ivz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 May 2014 04:51:55 -0400
In-Reply-To: <1401439702-21626-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: a.zummo@towertech.it, akpm@linux-foundation.org, rtc-linux@googlegroups.com, Rajendra Nayak <rnayak@ti.com>, nsekhar@ti.com, linux-omap <linux-omap@vger.kernel.org>

+ linux-omap
On Friday 30 May 2014 02:18 PM, Lokesh Vutla wrote:
> When RTC CLKTRCTRL bit is configured in HW_AUTO, module goes to sleep
> in IDLE state.
> The Alarm SWakeup event can be used to wakeup the RTC when it is in IDLE state.
> In order to do so, the alarm needs to be set and enabled before RTC enters the
> IDLE state. Also the wakeup generation for alarm/timer event needs
> to be set (bits [1:0] in RTC_IRQWAKEEN register).
> Currently RTC_IRQWAKEEN bits are set only in suspend/resume paths. With
> this ALARM interrupts are not generated when it enters IDLE state.
> So programming the RTC_IRQWAKEEN bits when ever ALARM is set.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/rtc/rtc-omap.c |   67 ++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 03bce13..21142e6 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -171,17 +171,28 @@ static irqreturn_t rtc_irq(int irq, void *rtc)
>  
>  static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  {
> -	u8 reg;
> +	u8 reg, irqwake_reg = 0;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct platform_device_id *id_entry =
> +					platform_get_device_id(pdev);
>  
>  	local_irq_disable();
>  	rtc_wait_not_busy();
>  	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> -	if (enabled)
> +	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> +		irqwake_reg = rtc_read(OMAP_RTC_IRQWAKEEN);
> +
> +	if (enabled) {
>  		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
> -	else
> +		irqwake_reg |= OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> +	} else {
>  		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
> +		irqwake_reg &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> +	}
>  	rtc_wait_not_busy();
>  	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> +	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> +		rtc_write(irqwake_reg, OMAP_RTC_IRQWAKEEN);
>  	local_irq_enable();
>  
>  	return 0;
> @@ -281,7 +292,10 @@ static int omap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  
>  static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  {
> -	u8 reg;
> +	u8 reg, irqwake_reg = 0;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct platform_device_id *id_entry =
> +					platform_get_device_id(pdev);
>  
>  	if (tm2bcd(&alm->time) < 0)
>  		return -EINVAL;
> @@ -297,11 +311,19 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	rtc_write(alm->time.tm_sec, OMAP_RTC_ALARM_SECONDS_REG);
>  
>  	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> -	if (alm->enabled)
> +	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> +		irqwake_reg = rtc_read(OMAP_RTC_IRQWAKEEN);
> +
> +	if (alm->enabled) {
>  		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
> -	else
> +		irqwake_reg |= OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> +	} else {
>  		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
> +		irqwake_reg &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> +	}
>  	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> +	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> +		rtc_write(irqwake_reg, OMAP_RTC_IRQWAKEEN);
>  
>  	local_irq_enable();
>  
> @@ -503,28 +525,16 @@ static u8 irqstat;
>  
>  static int omap_rtc_suspend(struct device *dev)
>  {
> -	u8 irqwake_stat;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	const struct platform_device_id *id_entry =
> -					platform_get_device_id(pdev);
> -
>  	irqstat = rtc_read(OMAP_RTC_INTERRUPTS_REG);
>  
>  	/* FIXME the RTC alarm is not currently acting as a wakeup event
>  	 * source on some platforms, and in fact this enable() call is just
>  	 * saving a flag that's never used...
>  	 */
> -	if (device_may_wakeup(dev)) {
> +	if (device_may_wakeup(dev))
>  		enable_irq_wake(omap_rtc_alarm);
> -
> -		if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN) {
> -			irqwake_stat = rtc_read(OMAP_RTC_IRQWAKEEN);
> -			irqwake_stat |= OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> -			rtc_write(irqwake_stat, OMAP_RTC_IRQWAKEEN);
> -		}
> -	} else {
> +	else
>  		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> -	}
>  
>  	/* Disable the clock/module */
>  	pm_runtime_put_sync(dev);
> @@ -534,25 +544,14 @@ static int omap_rtc_suspend(struct device *dev)
>  
>  static int omap_rtc_resume(struct device *dev)
>  {
> -	u8 irqwake_stat;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	const struct platform_device_id *id_entry =
> -				platform_get_device_id(pdev);
> -
>  	/* Enable the clock/module so that we can access the registers */
>  	pm_runtime_get_sync(dev);
>  
> -	if (device_may_wakeup(dev)) {
> +	if (device_may_wakeup(dev))
>  		disable_irq_wake(omap_rtc_alarm);
> -
> -		if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN) {
> -			irqwake_stat = rtc_read(OMAP_RTC_IRQWAKEEN);
> -			irqwake_stat &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
> -			rtc_write(irqwake_stat, OMAP_RTC_IRQWAKEEN);
> -		}
> -	} else {
> +	else
>  		rtc_write(irqstat, OMAP_RTC_INTERRUPTS_REG);
> -	}
> +
>  	return 0;
>  }
>  #endif
> 

