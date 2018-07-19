From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 2/4] rtc: OMAP: Add support for rtc-only mode
Date: Thu, 19 Jul 2018 12:29:38 +0200
Message-ID: <20180719102938.GR10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531372060-10532-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:38AM +0530, Keerthy wrote:
> Prepare rtc driver for rtc-only with DDR in self-refresh mode.
> omap_rtc_power_off now should cater to two features:
> 
> 1) RTC plus DDR in self-refresh is power a saving mode where in the
> entire system including the different voltage rails from PMIC are
> shutdown except the ones feeding on to RTC and DDR. DDR is kept in
> self-refresh hence the contents are preserved. RTC ALARM2 is connected
> to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
> DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
> ALARM1 triggers waking up the system[1]. The control goes to bootloader.
> The bootloader then checks RTC scratchpad registers to confirm it was an
> rtc_only wakeup and follows a different path, configure bare minimal
> clocks for ddr and then jumps to the resume address in another RTC
> scratchpad registers and transfers the control to Kernel. Kernel then
> restores the saved context. omap_rtc_power_off_program does the ALARM2
> programming part.
> 
>      [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884
> 
> 2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
> above omap_rtc_power_off_program function and in addition to that
> programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
> the pushbutton and shuts off the PMIC.
> 
> Hence the split in omap_rtc_power_off.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 53 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 88da927..cb19ece 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -415,21 +415,12 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  
>  static struct omap_rtc *omap_rtc_power_off_rtc;
>  
> -/*
> - * omap_rtc_poweroff: RTC-controlled power off
> - *
> - * The RTC can be used to control an external PMIC via the pmic_power_en pin,
> - * which can be configured to transition to OFF on ALARM2 events.
> - *
> - * Notes:
> - * The two-second alarm offset is the shortest offset possible as the alarm
> - * registers must be set before the next timer update and the offset
> - * calculation is too heavy for everything to be done within a single access
> - * period (~15 us).
> - *
> - * Called with local interrupts disabled.
> +/**
> + * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
> + * generates pmic_pwr_enable control, which can be used to control an external
> + * PMIC.

Since this is kerneldoc, you need an empty line after "sequence." above.

You should also add a comment that this function depends on local
interrupts being disabled when called (for the wait_not_busy handling); 
and make sure you follow that in subsequent patches.

>   */
> -static void omap_rtc_power_off(void)
> +static int omap_rtc_power_off_program(struct device *dev)

dev is never used in this function.

>  {
>  	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
>  	struct rtc_time tm;
> @@ -456,7 +447,7 @@ static void omap_rtc_power_off(void)
>  	if (tm2bcd(&tm) < 0) {
>  		dev_err(&rtc->rtc->dev, "power off failed\n");
>  		rtc->type->lock(rtc);
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	rtc_wait_not_busy(rtc);
> @@ -481,6 +472,38 @@ static void omap_rtc_power_off(void)
>  		goto again;
>  	rtc->type->lock(rtc);
>  
> +	return 0;
> +}
> +
> +/*
> + * omap_rtc_poweroff: RTC-controlled power off
> + *
> + * The RTC can be used to control an external PMIC via the pmic_power_en pin,
> + * which can be configured to transition to OFF on ALARM2 events.
> + *
> + * Notes:
> + * The one-second alarm offset is the shortest offset possible as the alarm
> + * registers must be set before the next timer update and the offset
> + * calculation is too heavy for everything to be done within a single access
> + * period (~15 us).

This note really doesn't make much sense anymore, and should have been
updated as part of the previous patch.

> + *
> + * Called with local interrupts disabled.
> + */
> +static void omap_rtc_power_off(void)
> +{
> +	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;

Use struct omap_rtc here as before.

> +	u32 val;
> +
> +	omap_rtc_power_off_program(rtc->dev.parent);
> +
> +	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
> +	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
> +			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
> +	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);

What is all this, and why is it here?

Surely fiddling with this register after you've set the alarm to trigger
isn't the right thing to do.

> +
>  	/*
>  	 * Wait for alarm to trigger (within two seconds) and external PMIC to
>  	 * power off the system. Add a 500 ms margin for external latencies

Johan
