From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Thu, 19 Jul 2018 12:02:29 +0200
Message-ID: <20180719100229.GQ10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
> over try again.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v4:
> 
>   * Fixed a compilation issue.
>   * Extended the roll over check post interrupt programming.
> 
>  drivers/rtc/rtc-omap.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 323ff55..88da927 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c

First, the comment above this function would need to be updated as part
of this patch as it refers to the two-second alarm offset.

> @@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)
>  	struct rtc_time tm;
>  	unsigned long now;
>  	u32 val;
> +	int seconds;
>  
>  	rtc->type->unlock(rtc);
>  	/* enable pmic_power_en control */
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>  
> -	/* set alarm two seconds from now */
> +again:
> +	/* Clear any existing ALARM2 event */
> +	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);

Why is this needed? Any pending interrupt is cleared at probe, and a
previous attempt to set the alarm really led to the alarm going off, why
would we retry?

> +
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
> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);

Add a newline here.

> +	/* Our calculations started right before the rollover, try again */

Nit: use all lower case unless writing full sentences, which also
matches most of the other comments in this file.

> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

Here the alarm may have gone off as part of the roll over, in which case
you shouldn't retry.

Add a newline here too.

>  	rtc->type->lock(rtc);
>  
>  	/*

Thanks,
Johan
