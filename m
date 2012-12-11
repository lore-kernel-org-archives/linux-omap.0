From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Tue, 11 Dec 2012 09:00:24 +0000
Message-ID: <20121211090024.9F5293E076D@localhost>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com> <1353404927-14412-2-git-send-email-anilkumar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49542 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2LKJAj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Dec 2012 04:00:39 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so2087904wib.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Dec 2012 01:00:37 -0800 (PST)
In-Reply-To: <1353404927-14412-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>, AnilKumar Ch <anilkumar@ti.com>

On Tue, 20 Nov 2012 15:18:43 +0530, AnilKumar Ch <anilkumar@ti.com> wrote:
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
> ---
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>  drivers/rtc/rtc-omap.c                             |   81 +++++++++++++++++++-
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index b47aa41..8d9f4f9 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -6,6 +6,10 @@ Required properties:
>  - interrupts: rtc timer, alarm interrupts in order
>  - interrupt-parent: phandle for the interrupt controller
>  
> +Optional properties:
> +- ti,system-power-controller: Telling whether or not rtc is controlling
> +  the system power.
> +

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>  Example:
>  
>  rtc@1c23000 {
> @@ -14,4 +18,5 @@ rtc@1c23000 {
>  	interrupts = <19
>  		      19>;
>  	interrupt-parent = <&intc>;
> +	ti,system-power-controller;
>  };
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 6009714..c31f93a 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -72,6 +72,14 @@
>  #define OMAP_RTC_KICK0_REG		0x6c
>  #define OMAP_RTC_KICK1_REG		0x70
>  
> +#define OMAP_RTC_ALARM2_SECONDS_REG	0x80
> +#define OMAP_RTC_ALARM2_MINUTES_REG	0x84
> +#define OMAP_RTC_ALARM2_HOURS_REG	0x88
> +#define OMAP_RTC_ALARM2_DAYS_REG	0x8c
> +#define OMAP_RTC_ALARM2_MONTHS_REG	0x90
> +#define OMAP_RTC_ALARM2_YEARS_REG	0x94
> +#define OMAP_RTC_PMIC_REG		0x98
> +
>  /* OMAP_RTC_CTRL_REG bit fields: */
>  #define OMAP_RTC_CTRL_SPLIT		(1<<7)
>  #define OMAP_RTC_CTRL_DISABLE		(1<<6)
> @@ -93,15 +101,21 @@
>  #define OMAP_RTC_STATUS_BUSY            (1<<0)
>  
>  /* OMAP_RTC_INTERRUPTS_REG bit fields: */
> +#define OMAP_RTC_INTERRUPTS_IT_ALARM2   (1<<4)
>  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
>  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
>  
> +/* OMAP_RTC_PMIC_REG bit fields: */
> +#define OMAP_RTC_PMIC_POWER_EN_EN       (1<<16)
> +
>  /* OMAP_RTC_KICKER values */
>  #define	KICK0_VALUE			0x83e70b13
>  #define	KICK1_VALUE			0x95a4f1e0
>  
>  #define	OMAP_RTC_HAS_KICKER		0x1
>  
> +#define SHUTDOWN_TIME_SEC		2
> +
>  static void __iomem	*rtc_base;
>  
>  #define rtc_read(addr)		readb(rtc_base + (addr))
> @@ -290,6 +304,63 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	return 0;
>  }
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
> +}
> +
>  static struct rtc_class_ops omap_rtc_ops = {
>  	.read_time	= omap_rtc_read_time,
>  	.set_time	= omap_rtc_set_time,
> @@ -327,12 +398,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  	struct resource		*res, *mem;
>  	struct rtc_device	*rtc;
>  	u8			reg, new_ctrl;
> +	bool			pm_off = false;
>  	const struct platform_device_id *id_entry;
>  	const struct of_device_id *of_id;
>  
>  	of_id = of_match_device(omap_rtc_of_match, &pdev->dev);
> -	if (of_id)
> +	if (of_id) {
>  		pdev->id_entry = of_id->data;
> +		pm_off = of_property_read_bool(pdev->dev.of_node,
> +					"ti,system-power-controller");
> +	}
>  
>  	omap_rtc_timer = platform_get_irq(pdev, 0);
>  	if (omap_rtc_timer <= 0) {
> @@ -385,6 +460,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, rtc);
>  	dev_set_drvdata(&rtc->dev, mem);
>  
> +	/* RTC power off */
> +	if (pm_off && !pm_power_off)
> +		pm_power_off = rtc_power_off;
> +
>  	/* clear pending irqs, and set 1/second periodic,
>  	 * which we'll use instead of update irqs
>  	 */
> -- 
> 1.7.9.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
