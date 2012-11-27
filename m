From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [rtc-linux] [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off
 to rtc driver
Date: Tue, 27 Nov 2012 15:42:39 -0800
Message-ID: <20121127154239.0efad6d5.akpm@linux-foundation.org>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
	<1353404927-14412-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50015 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2K0Xml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 18:42:41 -0500
In-Reply-To: <1353404927-14412-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: AnilKumar Ch <anilkumar@ti.com>, a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>

On Tue, 20 Nov 2012 15:18:43 +0530
AnilKumar Ch <anilkumar@ti.com> wrote:

> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> 
> Add system power off control to rtc driver which is the in-charge
> of controlling the BeagleBone system power. The power_off routine
> can be hooked up to "pm_power_off" system call.
> 
> System power off sequence:-
> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
> * Enable PMIC_POWER_EN in rtc module
> * Set rtc ALARM2 time
> * Enable ALARM2 interrupt
> 
> Added while (1); after the above steps to make sure that no other
> process acquire cpu. Otherwise we might see an unexpected behaviour
> because we are shutting down all the power rails of SoC except RTC.
> 
> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> [anilkumar@ti.com: move poweroff additions to rtc driver]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>
> ...
>
> +/*
> + * rtc_power_off: Set the pmic power off sequence. The RTC generates
> + * pmic_pwr_enable control, which can be used to control an external
> + * PMIC.
> + */
> +static void rtc_power_off(void)
> +{
> +	u32 val;
> +	struct rtc_time tm;
> +	spinlock_t lock;

What on earth?

> +	unsigned long flags, time;
> +
> +	spin_lock_init(&lock);
> +
> +	/* Set PMIC power enable */
> +	val = readl(rtc_base + OMAP_RTC_PMIC_REG);
> +	writel(val | OMAP_RTC_PMIC_POWER_EN_EN, rtc_base + OMAP_RTC_PMIC_REG);
> +
> +	/* Read rtc time */
> +	omap_rtc_read_time(NULL, &tm);
> +
> +	/* Convert Gregorian date to seconds since 01-01-1970 00:00:00 */
> +	rtc_tm_to_time(&tm, &time);
> +
> +	/* Add shutdown time to the current value */
> +	time += SHUTDOWN_TIME_SEC;
> +
> +	/* Convert seconds since 01-01-1970 00:00:00 to Gregorian date */
> +	rtc_time_to_tm(time, &tm);
> +
> +	if (tm2bcd(&tm) < 0)
> +		return;
> +
> +	pr_info("System will go to power_off state in approx. %d secs\n",
> +			SHUTDOWN_TIME_SEC);
> +
> +	/*
> +	 * pmic_pwr_enable is controlled by means of ALARM2 event. So here
> +	 * programming alarm2 expiry time and enabling alarm2 interrupt
> +	 */
> +	rtc_write(tm.tm_sec, OMAP_RTC_ALARM2_SECONDS_REG);
> +	rtc_write(tm.tm_min, OMAP_RTC_ALARM2_MINUTES_REG);
> +	rtc_write(tm.tm_hour, OMAP_RTC_ALARM2_HOURS_REG);
> +	rtc_write(tm.tm_mday, OMAP_RTC_ALARM2_DAYS_REG);
> +	rtc_write(tm.tm_mon, OMAP_RTC_ALARM2_MONTHS_REG);
> +	rtc_write(tm.tm_year, OMAP_RTC_ALARM2_YEARS_REG);
> +
> +	/* Enable alarm2 interrupt */
> +	val = readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);
> +	writel(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,
> +				rtc_base + OMAP_RTC_INTERRUPTS_REG);
> +
> +	/* Do not allow to execute any other task */
> +	spin_lock_irqsave(&lock, flags);
> +	while (1);

I suspect this doesn't do what you want it to do.

Firstly, please provide adequate code comments here so that code
readers do not also need to be mind readers.

If you want to stop this CPU dead in its tracks (why?) then

	local_irq_disable();
	while (1)
		;		/* Note correct code layout */

will do it.  But it means that the NMI watchdog (if present) will come
along and whack the machine in the head a few seconds later.  And this
does nothing to stop other CPUs.

But not being a mind reader, I'm really at a loss to suggest what
should be done here.  

> +}
>
> ...
>
