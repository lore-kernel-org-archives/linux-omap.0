From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Tue, 14 Aug 2018 11:23:17 +0200
Message-ID: <20180814092317.GA30344@localhost>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
 <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 25, 2018 at 11:21:22AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v5:
> 
>   * Added an additional check to see if ALARM2 status is not set
>     before retrying.
>   * Cleaned up comments
>   * Also reduced mdelay to 1S lesser as per this commit
> 
>  drivers/rtc/rtc-omap.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 44ff4cc..caa6da6 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -421,12 +421,6 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>   * The RTC can be used to control an external PMIC via the pmic_power_en pin,
>   * which can be configured to transition to OFF on ALARM2 events.
>   *
> - * Notes:
> - * The two-second alarm offset is the shortest offset possible as the alarm
> - * registers must be set before the next timer update and the offset
> - * calculation is too heavy for everything to be done within a single access
> - * period (~15 us).
> - *
>   * Called with local interrupts disabled.
>   */
>  static void omap_rtc_power_off(void)
> @@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
>  	struct rtc_time tm;
>  	unsigned long now;
>  	u32 val;
> +	int seconds;

Nit: I'd place this above val to maintain the reverse xmas-tree style.

>  
>  	rtc->type->unlock(rtc);
>  	/* enable pmic_power_en control */
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>  
> -	/* set alarm two seconds from now */
> +again:
> +	/* set alarm one second from now */
>  	omap_rtc_read_time_raw(rtc, &tm);
> +	seconds = tm.tm_sec;
>  	bcd2tm(&tm);
>  	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> +	rtc_time_to_tm(now + 1, &tm);
>  
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
> @@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> +
> +	/*
> +	 * first check if ALARM2 has fired, if not then check if
> +	 * our calculations started right before the rollover, try again
> +	 * in case of rollover
> +	 */

This is unnecessarily verbose; I'd rephrase it as something like:

	/* Retry in case roll over happened before alarm was armed. */

> +	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
> +						 OMAP_RTC_STATUS_REG)) &&
> +	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

And this is clearly broken. First, you use boolean && instead of the &
bit operation.

Second, you need to check the status register *after* checking for
roll-over, as I already mentioned.

Also, use the rtc pointer rather than omap_rtc_power_off_rtc, which will
allow for more readable code.

I also strongly suggest you split the conditional, and use val to store
the status register value, that is:

	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
		val = rtc_read(rtc, OMAP_RTC_STATUS_REG);
		if (!(val & OMAP_RTC_STATUS_ALARM2))
			goto again;
	}

> +
>  	rtc->type->lock(rtc);
>  
>  	/*
> -	 * Wait for alarm to trigger (within two seconds) and external PMIC to
> +	 * Wait for alarm to trigger (within one second) and external PMIC to
>  	 * power off the system. Add a 500 ms margin for external latencies
>  	 * (e.g. debounce circuits).
>  	 */
> -	mdelay(2500);
> +	mdelay(1500);
>  }
>  
>  static const struct rtc_class_ops omap_rtc_ops = {

Johan
