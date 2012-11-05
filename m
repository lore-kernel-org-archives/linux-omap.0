From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Mon, 5 Nov 2012 17:43:25 +0100
Message-ID: <5097ECAD.9010101@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352108549-9341-3-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Anil / Colin,

On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
> From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
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
> Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
> [anilkumar-l0cyMroinI0@public.gmane.org: move poweroff additions to rtc driver]
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>  drivers/rtc/rtc-omap.c                             |   79 +++++++++++++++++++-
>  2 files changed, 83 insertions(+), 1 deletion(-)
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

I don't know how it is connected at board level, but I'm not sure the
binding is the proper one.
It does not look super generic, and I'm wondering if we should not use
instead some regulator binding to reflect the connection of the RTC to a
regulator.

But without the board / soc spec it is hard to tell :-(

Regards,
Benoit


> +
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
> index 6009714..2d90170 100644
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
> @@ -93,15 +101,24 @@
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
> +#define SECS_IN_MIN			60
> +#define WAIT_AFTER			(SECS_IN_MIN - SHUTDOWN_TIME_SEC)
> +#define WAIT_TIME_MS			(SHUTDOWN_TIME_SEC * 1000)
> +
>  static void __iomem	*rtc_base;
>  
>  #define rtc_read(addr)		readb(rtc_base + (addr))
> @@ -290,6 +307,58 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
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
> +	unsigned long flags;
> +
> +	spin_lock_init(&lock);
> +
> +	/* Set PMIC power enable */
> +	val = readl(rtc_base + OMAP_RTC_PMIC_REG);
> +	writel(val | OMAP_RTC_PMIC_POWER_EN_EN, rtc_base + OMAP_RTC_PMIC_REG);
> +
> +	/* Wait few seconds instead of rollover */
> +	do {
> +		omap_rtc_read_time(NULL, &tm);
> +		if (WAIT_AFTER <= tm.tm_sec)
> +			mdelay(WAIT_TIME_MS);
> +	} while (WAIT_AFTER <= tm.tm_sec);
> +
> +	/* Add shutdown time to the current value */
> +	tm.tm_sec += SHUTDOWN_TIME_SEC;
> +
> +	if (tm2bcd(&tm) < 0)
> +		return;
> +
> +	pr_info("System will go to power_off state in approx. %d secs\n",
> +			SHUTDOWN_TIME_SEC);
> +
> +	/* Set the ALARM2 time */
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
> @@ -327,12 +396,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
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
> @@ -385,6 +458,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
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
> 
