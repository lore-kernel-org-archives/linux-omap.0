From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] rtc: OMAP: Add support for rtc-only mode
Date: Mon, 9 Jul 2018 09:55:53 +0200
Message-ID: <20180709075553.GA3633@localhost>
References: <1531116709-20135-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531116709-20135-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 09, 2018 at 11:41:49AM +0530, Keerthy wrote:
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
> 
> Changes in v2:
> 
>   * Add details in the commit log.
>   * Use of_device_is_system_power_controller to check if rtc node is
>     indeed the system power control instead of manually reading property.
> 
>  drivers/rtc/interface.c |  12 ++++
>  drivers/rtc/rtc-omap.c  | 167 +++++++++++++++++++++++++++++++++---------------
>  include/linux/rtc.h     |   2 +
>  3 files changed, 131 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 6d4012d..d8b70f0 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>  	trace_rtc_set_offset(offset, ret);
>  	return ret;
>  }
> +
> +/**
> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> + * line and can be used to power off the SoC.
> + *
> + * Kernel interface to program rtc to power off
> + */
> +void rtc_power_off_program(struct rtc_device *rtc)
> +{
> +	rtc->ops->power_off_program(rtc->dev.parent);
> +}
> +EXPORT_SYMBOL_GPL(rtc_power_off_program);

We typically do not add new interfaces without any users, so this will
probably have to go in along with the corresponding omap changes for
rtc-only mode.

Also, would you not like to be able to detect suspend failures by
having the function return a status integer?

> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 3908639..7f45e02 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -29,6 +29,7 @@
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/rtc.h>
>  
>  /*
> @@ -131,6 +132,8 @@
>  #define	KICK0_VALUE			0x83e70b13
>  #define	KICK1_VALUE			0x95a4f1e0
>  
> +#define SHUTDOWN_TIME_SEC		1

IIRC setting the alarm two seconds into the future was essential to
avoid missing an alarm and failing to power off the SoC. You're now
changing this, not only for your future rtc-only use, but for the
current power-off feature without even commenting on it.

> +
>  struct omap_rtc;
>  
>  struct omap_rtc_device_type {
> @@ -415,6 +418,77 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  
>  static struct omap_rtc *omap_rtc_power_off_rtc;
>  
> +/**
> + * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
> + * generates pmic_pwr_enable control, which can be used to control an external
> + * PMIC.
> + */
> +void omap_rtc_power_off_program(struct device *dev)
> +{
> +	u32 val;
> +	struct rtc_time tm;
> +	unsigned long time;
> +	int seconds;
> +
> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
> +
> +	/* Clear any existing ALARM2 event */
> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_STATUS_REG,
> +		   OMAP_RTC_STATUS_ALARM2);
> +
> +	pr_info("System will go to power_off state in approx. %d second\n",
> +		SHUTDOWN_TIME_SEC);

This should be a dev_dbg if anything.

> +
> +again:
> +	/* Read rtc time */
> +	tm.tm_sec = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG);
> +	seconds = tm.tm_sec;
> +	tm.tm_min = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MINUTES_REG);
> +	tm.tm_hour = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_HOURS_REG);
> +	tm.tm_mday = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_DAYS_REG);
> +	tm.tm_mon = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_MONTHS_REG);
> +	tm.tm_year = rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_YEARS_REG);

Why are you open-coding omap_rtc_read_time_raw()? It looks like you did
not even try to factor out the current implementation, but rather
scrapped it and reimplemented it from scratch. I suggest you reuse the
current, tested code, as far as possible.

> +	bcd2tm(&tm);
> +
> +	/* Convert Gregorian date to seconds since 01-01-1970 00:00:00 */
> +	rtc_tm_to_time(&tm, &time);
> +
> +	/* Convert seconds since 01-01-1970 00:00:00 to Gregorian date */
> +	rtc_time_to_tm(time + SHUTDOWN_TIME_SEC, &tm);
> +
> +	if (tm2bcd(&tm) < 0)
> +		return;
> +
> +	/* After wait_not_busy, we have at least 15us until the next second. */
> +	rtc_wait_not_busy(omap_rtc_power_off_rtc);
> +
> +	/* Our calculations started right before the rollover, try again */
> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
> +		goto again;

Ok, so you're retrying instead of using a two-second alarm offset. I
suggest you split this change out from the rest of the patch and amend
the current implementation first.

> +
> +	/*
> +	 * pmic_pwr_enable is controlled by means of ALARM2 event. So here
> +	 * programming alarm2 expiry time and enabling alarm2 interrupt
> +	 */
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_SECONDS_REG,
> +		  tm.tm_sec);
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MINUTES_REG,
> +		  tm.tm_min);
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_HOURS_REG,
> +		  tm.tm_hour);
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_DAYS_REG,
> +		  tm.tm_mday);
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_MONTHS_REG,
> +		  tm.tm_mon);
> +	rtc_write(omap_rtc_power_off_rtc, OMAP_RTC_ALARM2_YEARS_REG,
> +		  tm.tm_year);
> +
> +	/* Enable alarm2 interrupt */
> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_INTERRUPTS_REG, val |
> +		   OMAP_RTC_INTERRUPTS_IT_ALARM2);
> +}
> +
>  /*
>   * omap_rtc_poweroff: RTC-controlled power off
>   *
> @@ -431,45 +505,19 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>   */
>  static void omap_rtc_power_off(void)
>  {
> -	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
> -	struct rtc_time tm;
> -	unsigned long now;
> +	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
>  	u32 val;
>  
> -	rtc->type->unlock(rtc);
> -	/* enable pmic_power_en control */
> -	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
> -	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
> -
> -	/* set alarm two seconds from now */
> -	omap_rtc_read_time_raw(rtc, &tm);
> -	bcd2tm(&tm);
> -	rtc_tm_to_time(&tm, &now);
> -	rtc_time_to_tm(now + 2, &tm);
> -
> -	if (tm2bcd(&tm) < 0) {
> -		dev_err(&rtc->rtc->dev, "power off failed\n");
> -		return;
> -	}
> -
> -	rtc_wait_not_busy(rtc);
> +	regulator_suspend_prepare(PM_SUSPEND_MAX);

This function has been deprecated, converted to an empty dummy function
for the time being, and should not be used.

> +	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);

Why the double unlock?

> +	omap_rtc_power_off_program(rtc->dev.parent);
>  
> -	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
> -	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
> -	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
> -	rtc_write(rtc, OMAP_RTC_ALARM2_DAYS_REG, tm.tm_mday);
> -	rtc_write(rtc, OMAP_RTC_ALARM2_MONTHS_REG, tm.tm_mon);
> -	rtc_write(rtc, OMAP_RTC_ALARM2_YEARS_REG, tm.tm_year);
> -
> -	/*
> -	 * enable ALARM2 interrupt
> -	 *
> -	 * NOTE: this fails on AM3352 if rtc_write (writeb) is used
> -	 */
> -	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> -	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> -			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> -	rtc->type->lock(rtc);
> +	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
> +	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
> +	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
> +	       OMAP_RTC_PMIC_EXT_WKUP_EN(0);
> +	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
> +	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
>  
>  	/*
>  	 * Wait for alarm to trigger (within two seconds) and external PMIC to
> @@ -477,6 +525,17 @@ static void omap_rtc_power_off(void)
>  	 * (e.g. debounce circuits).
>  	 */
>  	mdelay(2500);
> +
> +	pr_err("rtc_power_off failed, bailing out.\n");

Don't think this is needed either. An unrelated change in any case. And
you should be using dev_err and friends when you have a struct device.

> +}
> +
> +static void omap_rtc_cleanup_pm_power_off(struct omap_rtc *rtc)
> +{
> +	if (pm_power_off == omap_rtc_power_off &&
> +	    omap_rtc_power_off_rtc == rtc) {
> +		pm_power_off = NULL;
> +		omap_rtc_power_off_rtc = NULL;
> +	}

Another unrelated change.

>  }
>  
>  static const struct rtc_class_ops omap_rtc_ops = {
> @@ -485,6 +544,7 @@ static void omap_rtc_power_off(void)
>  	.read_alarm	= omap_rtc_read_alarm,
>  	.set_alarm	= omap_rtc_set_alarm,
>  	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
> +	.power_off_program = omap_rtc_power_off_program,
>  };
>  
>  static const struct omap_rtc_device_type omap_rtc_default_type = {
> @@ -724,8 +784,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (of_id) {
>  		rtc->type = of_id->data;
>  		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
> -				of_property_read_bool(pdev->dev.of_node,
> -						"system-power-controller");
> +			of_device_is_system_power_controller(pdev->dev.of_node);

Ditto.

>  	} else {
>  		id_entry = platform_get_device_id(pdev);
>  		rtc->type = (void *)id_entry->driver_data;
> @@ -838,6 +897,11 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	rtc->type->lock(rtc);
>  
>  	device_init_wakeup(&pdev->dev, true);
> +	omap_rtc_power_off_rtc = rtc;
> +
> +	if (rtc->is_pmic_controller)
> +		if (!pm_power_off)
> +			pm_power_off = omap_rtc_power_off;

Why are you initialising the power-off callback even earlier? And
without removing the later initialisation? 

This really should be done last, as originally intended.

As I was the one who implemented the current power-off support, I
browsed the driver when I saw your patch and discovered a couple of bugs
that have since crept it. Those are fixed up here:

	https://lkml.kernel.org/r/20180704090558.16647-1-johan@kernel.org

I think you should rebase your work on top of those.
 
>  	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(rtc->rtc)) {
> @@ -887,6 +951,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err:
> +	omap_rtc_cleanup_pm_power_off(rtc);

Ok, so this actually fixes a bug in the current implementation, and
should have been handled separately. But as mentioned above, this is not
the right fix as we should not set the power-off callback before the
device has been fully initialised.

>  	clk_disable_unprepare(rtc->clk);
>  	device_init_wakeup(&pdev->dev, false);
>  	rtc->type->lock(rtc);
> @@ -901,11 +966,7 @@ static int omap_rtc_remove(struct platform_device *pdev)
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>  	u8 reg;
>  
> -	if (pm_power_off == omap_rtc_power_off &&
> -			omap_rtc_power_off_rtc == rtc) {
> -		pm_power_off = NULL;
> -		omap_rtc_power_off_rtc = NULL;
> -	}
> +	omap_rtc_cleanup_pm_power_off(rtc);
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  
> @@ -993,14 +1054,20 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>  	u8 mask;
>  
> -	/*
> -	 * Keep the ALARM interrupt enabled to allow the system to power up on
> -	 * alarm events.
> -	 */
>  	rtc->type->unlock(rtc);
> -	mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> -	mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
> -	rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
> +	/* If rtc does not control PMIC then no need to enable ALARM */
> +	if (!rtc->is_pmic_controller) {
> +		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, 0);
> +	} else {
> +		/*
> +		 * Keep the ALARM interrupt enabled to allow the system to
> +		 * power up on alarm events.
> +		 */
> +		mask = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> +		mask &= OMAP_RTC_INTERRUPTS_IT_ALARM;
> +		rtc_write(rtc, OMAP_RTC_INTERRUPTS_REG, mask);
> +	}

This also looks like an unrelated change, which needs to go in its own
patch.

> +
>  	rtc->type->lock(rtc);
>  }
>  
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 6268208..f17bc6a 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -85,6 +85,7 @@ struct rtc_class_ops {
>  	int (*alarm_irq_enable)(struct device *, unsigned int enabled);
>  	int (*read_offset)(struct device *, long *offset);
>  	int (*set_offset)(struct device *, long offset);
> +	void (*power_off_program)(struct device *dev);
>  };
>  
>  typedef struct rtc_task {
> @@ -229,6 +230,7 @@ int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
>  int rtc_read_offset(struct rtc_device *rtc, long *offset);
>  int rtc_set_offset(struct rtc_device *rtc, long offset);
>  void rtc_timer_do_work(struct work_struct *work);
> +void rtc_power_off_program(struct rtc_device *rtc);
>  
>  static inline bool is_leap_year(unsigned int year)
>  {

Johan
