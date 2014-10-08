From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/4] rtc: omap: Introduce rtc_omap_dev structure to
 include per device data
Date: Wed, 8 Oct 2014 19:36:52 +0200
Message-ID: <20141008173652.GF1990@localhost>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
 <1411637529-18289-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56973 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaJHRjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2014 13:39:43 -0400
Content-Disposition: inline
In-Reply-To: <1411637529-18289-2-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thu, Sep 25, 2014 at 03:02:06PM +0530, Lokesh Vutla wrote:
> Currently all the device data is declared globally which will be a
> problem if more than one instance of device is present. So consolidate
> all the data into rtc_omap_dev struct and adopt the driver to use this.
> 
> Suggested-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v1:
> 	- New patch as suggested by Felipe.
>  drivers/rtc/rtc-omap.c | 257 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 147 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 21142e6..4e90b50 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -41,8 +41,6 @@
>  
>  #define	DRIVER_NAME			"omap_rtc"
>  
> -#define OMAP_RTC_BASE			0xfffb4800
> -
>  /* RTC registers */
>  #define OMAP_RTC_SECONDS_REG		0x00
>  #define OMAP_RTC_MINUTES_REG		0x04
> @@ -120,26 +118,53 @@
>   */
>  #define OMAP_RTC_HAS_32KCLK_EN		BIT(2)
>  
> -static void __iomem	*rtc_base;
> +/**
> + * struct rtc_omap_dev - Per device static data for driver's use
> + * @rtc_device :	Pointer to generic RTC interface.

Member name in comment doesn't match actual name ("rtc").

> + * @device:		Device Pointer.
> + * pdata :		Copy of saved platform data.

Use a more descriptive name here to describe what it's really for
(feature flags), perhaps just call it "flags". 

Please prepend all members with a '@' (and remove the space before ':').

> + * rtc_base :		Base address of memory-mapped IO registers.
> + * rtc_alarm :		RTC alarm interrupt number.
> + * rtc_timer :		RTC timer interrupt number.

All these rtc_ prefixes are now quite redundant (and non-descriptive).

Call the interrupt fields irq_alarm and irq_timer instead.

>+ * irq_stat :		Copy of Interrupt status register.

And then rename this after the register, e.g. "interrupts_reg", or call
it irq_mask.

Update the comment as well to describe what the field is used for (i.e.
to store the interrupt mask while suspended). 

> + */
> +struct rtc_omap_dev {
> +	struct rtc_device	*rtc;
> +	struct device		*dev;
> +	unsigned long		pdata;
> +	void __iomem		*rtc_base;
> +	u32			rtc_alarm;
> +	u32			rtc_timer;
> +	u8			irqstat;
> +};
>  
> -#define rtc_read(addr)		readb(rtc_base + (addr))
> -#define rtc_write(val, addr)	writeb(val, rtc_base + (addr))
> +static inline u8 rtc_read(struct rtc_omap_dev *rtc_omap, u32 off)
> +{
> +	return readb(rtc_omap->rtc_base + off);
> +}
>  
> -#define rtc_writel(val, addr)	writel(val, rtc_base + (addr))
> +static inline void rtc_write(u8 val, struct rtc_omap_dev *rtc_omap, u32 off)

Please make the rtc_omap_dev the first argument of both read and write.

It doesn't hurt making the value argument the last one.

> +{
> +	writeb(val, rtc_omap->rtc_base + off);
> +}
>  
> +static inline void rtc_writel(u32 val, struct rtc_omap_dev *rtc_omap, u32 off)

Same here.

> +{
> +	writel(val, rtc_omap->rtc_base + off);
> +}
>  
>  /* we rely on the rtc framework to handle locking (rtc->ops_lock),
>   * so the only other requirement is that register accesses which
>   * require BUSY to be clear are made with IRQs locally disabled
>   */
> -static void rtc_wait_not_busy(void)
> +static void rtc_wait_not_busy(struct rtc_omap_dev *rtc_omap)
>  {
>  	int	count = 0;
>  	u8	status;
>  
>  	/* BUSY may stay active for 1/32768 second (~30 usec) */
>  	for (count = 0; count < 50; count++) {
> -		status = rtc_read(OMAP_RTC_STATUS_REG);
> +		status = rtc_read(rtc_omap, OMAP_RTC_STATUS_REG);
>  		if ((status & (u8)OMAP_RTC_STATUS_BUSY) == 0)
>  			break;
>  		udelay(1);
> @@ -147,16 +172,17 @@ static void rtc_wait_not_busy(void)
>  	/* now we have ~15 usec to read/write various registers */
>  }
>  
> -static irqreturn_t rtc_irq(int irq, void *rtc)
> +static irqreturn_t rtc_irq(int irq, void *id)
>  {
> +	struct rtc_omap_dev *rtc_omap = (struct rtc_omap_dev *)id;
>  	unsigned long		events = 0;
>  	u8			irq_data;
>  
> -	irq_data = rtc_read(OMAP_RTC_STATUS_REG);
> +	irq_data = rtc_read(rtc_omap, OMAP_RTC_STATUS_REG);
>  
>  	/* alarm irq? */
>  	if (irq_data & OMAP_RTC_STATUS_ALARM) {
> -		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_ALARM, rtc_omap, OMAP_RTC_STATUS_REG);
>  		events |= RTC_IRQF | RTC_AF;
>  	}
>  
> @@ -164,7 +190,7 @@ static irqreturn_t rtc_irq(int irq, void *rtc)
>  	if (irq_data & OMAP_RTC_STATUS_1S_EVENT)
>  		events |= RTC_IRQF | RTC_UF;
>  
> -	rtc_update_irq(rtc, 1, events);
> +	rtc_update_irq(rtc_omap->rtc, 1, events);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -172,15 +198,13 @@ static irqreturn_t rtc_irq(int irq, void *rtc)
>  static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  {
>  	u8 reg, irqwake_reg = 0;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	const struct platform_device_id *id_entry =
> -					platform_get_device_id(pdev);
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
>  
>  	local_irq_disable();
> -	rtc_wait_not_busy();
> -	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> -	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> -		irqwake_reg = rtc_read(OMAP_RTC_IRQWAKEEN);
> +	rtc_wait_not_busy(rtc_omap);
> +	reg = rtc_read(rtc_omap, OMAP_RTC_INTERRUPTS_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_IRQWAKEEN)
> +		irqwake_reg = rtc_read(rtc_omap, OMAP_RTC_IRQWAKEEN);
>  
>  	if (enabled) {
>  		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
> @@ -189,10 +213,10 @@ static int omap_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
>  		irqwake_reg &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
>  	}
> -	rtc_wait_not_busy();
> -	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> -	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> -		rtc_write(irqwake_reg, OMAP_RTC_IRQWAKEEN);
> +	rtc_wait_not_busy(rtc_omap);
> +	rtc_write(reg, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_IRQWAKEEN)
> +		rtc_write(irqwake_reg, rtc_omap, OMAP_RTC_IRQWAKEEN);
>  	local_irq_enable();
>  
>  	return 0;
> @@ -233,16 +257,18 @@ static void bcd2tm(struct rtc_time *tm)
>  
>  static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
> +
>  	/* we don't report wday/yday/isdst ... */
>  	local_irq_disable();
> -	rtc_wait_not_busy();
> +	rtc_wait_not_busy(rtc_omap);
>  
> -	tm->tm_sec = rtc_read(OMAP_RTC_SECONDS_REG);
> -	tm->tm_min = rtc_read(OMAP_RTC_MINUTES_REG);
> -	tm->tm_hour = rtc_read(OMAP_RTC_HOURS_REG);
> -	tm->tm_mday = rtc_read(OMAP_RTC_DAYS_REG);
> -	tm->tm_mon = rtc_read(OMAP_RTC_MONTHS_REG);
> -	tm->tm_year = rtc_read(OMAP_RTC_YEARS_REG);
> +	tm->tm_sec = rtc_read(rtc_omap, OMAP_RTC_SECONDS_REG);
> +	tm->tm_min = rtc_read(rtc_omap, OMAP_RTC_MINUTES_REG);
> +	tm->tm_hour = rtc_read(rtc_omap, OMAP_RTC_HOURS_REG);
> +	tm->tm_mday = rtc_read(rtc_omap, OMAP_RTC_DAYS_REG);
> +	tm->tm_mon = rtc_read(rtc_omap, OMAP_RTC_MONTHS_REG);
> +	tm->tm_year = rtc_read(rtc_omap, OMAP_RTC_YEARS_REG);
>  
>  	local_irq_enable();
>  
> @@ -252,17 +278,19 @@ static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
> +
>  	if (tm2bcd(tm) < 0)
>  		return -EINVAL;
>  	local_irq_disable();
> -	rtc_wait_not_busy();
> +	rtc_wait_not_busy(rtc_omap);
>  
> -	rtc_write(tm->tm_year, OMAP_RTC_YEARS_REG);
> -	rtc_write(tm->tm_mon, OMAP_RTC_MONTHS_REG);
> -	rtc_write(tm->tm_mday, OMAP_RTC_DAYS_REG);
> -	rtc_write(tm->tm_hour, OMAP_RTC_HOURS_REG);
> -	rtc_write(tm->tm_min, OMAP_RTC_MINUTES_REG);
> -	rtc_write(tm->tm_sec, OMAP_RTC_SECONDS_REG);
> +	rtc_write(tm->tm_year, rtc_omap, OMAP_RTC_YEARS_REG);
> +	rtc_write(tm->tm_mon, rtc_omap, OMAP_RTC_MONTHS_REG);
> +	rtc_write(tm->tm_mday, rtc_omap, OMAP_RTC_DAYS_REG);
> +	rtc_write(tm->tm_hour, rtc_omap, OMAP_RTC_HOURS_REG);
> +	rtc_write(tm->tm_min, rtc_omap, OMAP_RTC_MINUTES_REG);
> +	rtc_write(tm->tm_sec, rtc_omap, OMAP_RTC_SECONDS_REG);
>  
>  	local_irq_enable();
>  
> @@ -271,20 +299,22 @@ static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  static int omap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  {
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
> +
>  	local_irq_disable();
> -	rtc_wait_not_busy();
> +	rtc_wait_not_busy(rtc_omap);
>  
> -	alm->time.tm_sec = rtc_read(OMAP_RTC_ALARM_SECONDS_REG);
> -	alm->time.tm_min = rtc_read(OMAP_RTC_ALARM_MINUTES_REG);
> -	alm->time.tm_hour = rtc_read(OMAP_RTC_ALARM_HOURS_REG);
> -	alm->time.tm_mday = rtc_read(OMAP_RTC_ALARM_DAYS_REG);
> -	alm->time.tm_mon = rtc_read(OMAP_RTC_ALARM_MONTHS_REG);
> -	alm->time.tm_year = rtc_read(OMAP_RTC_ALARM_YEARS_REG);
> +	alm->time.tm_sec = rtc_read(rtc_omap, OMAP_RTC_ALARM_SECONDS_REG);
> +	alm->time.tm_min = rtc_read(rtc_omap, OMAP_RTC_ALARM_MINUTES_REG);
> +	alm->time.tm_hour = rtc_read(rtc_omap, OMAP_RTC_ALARM_HOURS_REG);
> +	alm->time.tm_mday = rtc_read(rtc_omap, OMAP_RTC_ALARM_DAYS_REG);
> +	alm->time.tm_mon = rtc_read(rtc_omap, OMAP_RTC_ALARM_MONTHS_REG);
> +	alm->time.tm_year = rtc_read(rtc_omap, OMAP_RTC_ALARM_YEARS_REG);
>  
>  	local_irq_enable();
>  
>  	bcd2tm(&alm->time);
> -	alm->enabled = !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
> +	alm->enabled = !!(rtc_read(rtc_omap, OMAP_RTC_INTERRUPTS_REG)
>  			& OMAP_RTC_INTERRUPTS_IT_ALARM);
>  
>  	return 0;
> @@ -293,26 +323,24 @@ static int omap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  {
>  	u8 reg, irqwake_reg = 0;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	const struct platform_device_id *id_entry =
> -					platform_get_device_id(pdev);
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
>  
>  	if (tm2bcd(&alm->time) < 0)
>  		return -EINVAL;
>  
>  	local_irq_disable();
> -	rtc_wait_not_busy();
> +	rtc_wait_not_busy(rtc_omap);
>  
> -	rtc_write(alm->time.tm_year, OMAP_RTC_ALARM_YEARS_REG);
> -	rtc_write(alm->time.tm_mon, OMAP_RTC_ALARM_MONTHS_REG);
> -	rtc_write(alm->time.tm_mday, OMAP_RTC_ALARM_DAYS_REG);
> -	rtc_write(alm->time.tm_hour, OMAP_RTC_ALARM_HOURS_REG);
> -	rtc_write(alm->time.tm_min, OMAP_RTC_ALARM_MINUTES_REG);
> -	rtc_write(alm->time.tm_sec, OMAP_RTC_ALARM_SECONDS_REG);
> +	rtc_write(alm->time.tm_year, rtc_omap, OMAP_RTC_ALARM_YEARS_REG);
> +	rtc_write(alm->time.tm_mon, rtc_omap, OMAP_RTC_ALARM_MONTHS_REG);
> +	rtc_write(alm->time.tm_mday, rtc_omap, OMAP_RTC_ALARM_DAYS_REG);
> +	rtc_write(alm->time.tm_hour, rtc_omap, OMAP_RTC_ALARM_HOURS_REG);
> +	rtc_write(alm->time.tm_min, rtc_omap, OMAP_RTC_ALARM_MINUTES_REG);
> +	rtc_write(alm->time.tm_sec, rtc_omap, OMAP_RTC_ALARM_SECONDS_REG);
>  
> -	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> -	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> -		irqwake_reg = rtc_read(OMAP_RTC_IRQWAKEEN);
> +	reg = rtc_read(rtc_omap, OMAP_RTC_INTERRUPTS_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_IRQWAKEEN)
> +		irqwake_reg = rtc_read(rtc_omap, OMAP_RTC_IRQWAKEEN);
>  
>  	if (alm->enabled) {
>  		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
> @@ -321,9 +349,9 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
>  		irqwake_reg &= ~OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN;
>  	}
> -	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> -	if (id_entry->driver_data & OMAP_RTC_HAS_IRQWAKEEN)
> -		rtc_write(irqwake_reg, OMAP_RTC_IRQWAKEEN);
> +	rtc_write(reg, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_IRQWAKEEN)
> +		rtc_write(irqwake_reg, rtc_omap, OMAP_RTC_IRQWAKEEN);
>  
>  	local_irq_enable();
>  
> @@ -338,13 +366,10 @@ static struct rtc_class_ops omap_rtc_ops = {
>  	.alarm_irq_enable = omap_rtc_alarm_irq_enable,
>  };
>  
> -static int omap_rtc_alarm;
> -static int omap_rtc_timer;
> -
>  #define	OMAP_RTC_DATA_AM3352_IDX	1
>  #define	OMAP_RTC_DATA_DA830_IDX		2
>  
> -static struct platform_device_id omap_rtc_devtype[] = {
> +static const struct platform_device_id omap_rtc_devtype[] = {

This is an unrelated clean up and should go in a different patch.

>  	{
>  		.name	= DRIVER_NAME,
>  	},
> @@ -375,11 +400,18 @@ MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  static int __init omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct resource		*res;
> -	struct rtc_device	*rtc;
> +	struct rtc_omap_dev	*rtc_omap;
>  	u8			reg, new_ctrl;
>  	const struct platform_device_id *id_entry;
>  	const struct of_device_id *of_id;
>  
> +	rtc_omap = devm_kzalloc(&pdev->dev, sizeof(*rtc_omap), GFP_KERNEL);
> +	if (!rtc_omap)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rtc_omap);
> +	rtc_omap->dev = &pdev->dev;

You never use this one directly, so why store it?

> +
>  	of_id = of_match_device(omap_rtc_of_match, &pdev->dev);
>  	if (of_id)
>  		pdev->id_entry = of_id->data;
> @@ -389,78 +421,79 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "no matching device entry\n");
>  		return -ENODEV;
>  	}
> +	rtc_omap->pdata = id_entry->driver_data;
>  
> -	omap_rtc_timer = platform_get_irq(pdev, 0);
> -	if (omap_rtc_timer <= 0) {
> +	rtc_omap->rtc_timer = platform_get_irq(pdev, 0);
> +	if (rtc_omap->rtc_timer <= 0) {
>  		pr_debug("%s: no update irq?\n", pdev->name);
>  		return -ENOENT;
>  	}
>  
> -	omap_rtc_alarm = platform_get_irq(pdev, 1);
> -	if (omap_rtc_alarm <= 0) {
> +	rtc_omap->rtc_alarm = platform_get_irq(pdev, 1);
> +	if (rtc_omap->rtc_alarm <= 0) {
>  		pr_debug("%s: no alarm irq?\n", pdev->name);
>  		return -ENOENT;
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	rtc_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(rtc_base))
> -		return PTR_ERR(rtc_base);
> +	rtc_omap->rtc_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc_omap->rtc_base))
> +		return PTR_ERR(rtc_omap->rtc_base);
>  
>  	/* Enable the clock/module so that we can access the registers */
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
>  
> -	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER) {
> -		rtc_writel(KICK0_VALUE, OMAP_RTC_KICK0_REG);
> -		rtc_writel(KICK1_VALUE, OMAP_RTC_KICK1_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_KICKER) {
> +		rtc_writel(KICK0_VALUE, rtc_omap, OMAP_RTC_KICK0_REG);
> +		rtc_writel(KICK1_VALUE, rtc_omap, OMAP_RTC_KICK1_REG);
>  	}
>  
> -	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +	rtc_omap->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
>  			&omap_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc)) {
> +	if (IS_ERR(rtc_omap->rtc)) {
>  		pr_debug("%s: can't register RTC device, err %ld\n",
> -			pdev->name, PTR_ERR(rtc));
> +			pdev->name, PTR_ERR(rtc_omap->rtc));
>  		goto fail0;
>  	}
> -	platform_set_drvdata(pdev, rtc);
>  
>  	/* clear pending irqs, and set 1/second periodic,
>  	 * which we'll use instead of update irqs
>  	 */
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(0, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  
>  	/* enable RTC functional clock */
> -	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN)
> -		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_32KCLK_EN)
> +		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, rtc_omap, OMAP_RTC_OSC_REG);
>  
>  	/* clear old status */
> -	reg = rtc_read(OMAP_RTC_STATUS_REG);
> +	reg = rtc_read(rtc_omap, OMAP_RTC_STATUS_REG);
>  	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
>  		pr_info("%s: RTC power up reset detected\n",
>  			pdev->name);
> -		rtc_write(OMAP_RTC_STATUS_POWER_UP, OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_POWER_UP, rtc_omap,
> +			  OMAP_RTC_STATUS_REG);
>  	}
>  	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
> -		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_ALARM, rtc_omap, OMAP_RTC_STATUS_REG);
>  
>  	/* handle periodic and alarm irqs */
> -	if (devm_request_irq(&pdev->dev, omap_rtc_timer, rtc_irq, 0,
> -			dev_name(&rtc->dev), rtc)) {
> +	if (devm_request_irq(&pdev->dev, rtc_omap->rtc_timer, rtc_irq, 0,
> +			     dev_name(&pdev->dev), rtc_omap)) {
>  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
> -			pdev->name, omap_rtc_timer);
> +			pdev->name, rtc_omap->rtc_timer);
>  		goto fail0;
>  	}
> -	if ((omap_rtc_timer != omap_rtc_alarm) &&
> -		(devm_request_irq(&pdev->dev, omap_rtc_alarm, rtc_irq, 0,
> -			dev_name(&rtc->dev), rtc))) {
> +	if ((rtc_omap->rtc_timer != rtc_omap->rtc_alarm) &&
> +	    (devm_request_irq(&pdev->dev, rtc_omap->rtc_alarm, rtc_irq, 0,
> +			      dev_name(&pdev->dev), rtc_omap))) {
>  		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
> -			pdev->name, omap_rtc_alarm);
> +			pdev->name, rtc_omap->rtc_alarm);
>  		goto fail0;
>  	}
>  
>  	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
> -	reg = rtc_read(OMAP_RTC_CTRL_REG);
> +	reg = rtc_read(rtc_omap, OMAP_RTC_CTRL_REG);
>  	if (reg & (u8) OMAP_RTC_CTRL_STOP)
>  		pr_info("%s: already running\n", pdev->name);
>  
> @@ -488,13 +521,13 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  		pr_info("%s: split power mode\n", pdev->name);
>  
>  	if (reg != new_ctrl)
> -		rtc_write(new_ctrl, OMAP_RTC_CTRL_REG);
> +		rtc_write(new_ctrl, rtc_omap, OMAP_RTC_CTRL_REG);
>  
>  	return 0;
>  
>  fail0:
> -	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
> -		rtc_writel(0, OMAP_RTC_KICK0_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_KICKER)
> +		rtc_writel(0, rtc_omap, OMAP_RTC_KICK0_REG);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	return -EIO;
> @@ -502,16 +535,15 @@ fail0:
>  
>  static int __exit omap_rtc_remove(struct platform_device *pdev)
>  {
> -	const struct platform_device_id *id_entry =
> -				platform_get_device_id(pdev);
> +	struct rtc_omap_dev *rtc_omap = platform_get_drvdata(pdev);
>  
>  	device_init_wakeup(&pdev->dev, 0);
>  
>  	/* leave rtc running, but disable irqs */
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(0, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  
> -	if (id_entry->driver_data & OMAP_RTC_HAS_KICKER)
> -		rtc_writel(0, OMAP_RTC_KICK0_REG);
> +	if (rtc_omap->pdata & OMAP_RTC_HAS_KICKER)
> +		rtc_writel(0, rtc_omap, OMAP_RTC_KICK0_REG);
>  
>  	/* Disable the clock/module */
>  	pm_runtime_put_sync(&pdev->dev);
> @@ -521,20 +553,21 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -static u8 irqstat;
>  
>  static int omap_rtc_suspend(struct device *dev)
>  {
> -	irqstat = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
> +
> +	rtc_omap->irqstat = rtc_read(rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  
>  	/* FIXME the RTC alarm is not currently acting as a wakeup event
>  	 * source on some platforms, and in fact this enable() call is just
>  	 * saving a flag that's never used...
>  	 */
>  	if (device_may_wakeup(dev))
> -		enable_irq_wake(omap_rtc_alarm);
> +		enable_irq_wake(rtc_omap->rtc_alarm);
>  	else
> -		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +		rtc_write(0, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  
>  	/* Disable the clock/module */
>  	pm_runtime_put_sync(dev);
> @@ -544,13 +577,15 @@ static int omap_rtc_suspend(struct device *dev)
>  
>  static int omap_rtc_resume(struct device *dev)
>  {
> +	struct rtc_omap_dev *rtc_omap = dev_get_drvdata(dev);
> +
>  	/* Enable the clock/module so that we can access the registers */
>  	pm_runtime_get_sync(dev);
>  
>  	if (device_may_wakeup(dev))
> -		disable_irq_wake(omap_rtc_alarm);
> +		disable_irq_wake(rtc_omap->rtc_alarm);
>  	else
> -		rtc_write(irqstat, OMAP_RTC_INTERRUPTS_REG);
> +		rtc_write(rtc_omap->irqstat, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  
>  	return 0;
>  }
> @@ -560,10 +595,11 @@ static SIMPLE_DEV_PM_OPS(omap_rtc_pm_ops, omap_rtc_suspend, omap_rtc_resume);
>  
>  static void omap_rtc_shutdown(struct platform_device *pdev)
>  {
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	struct rtc_omap_dev *rtc_omap = platform_get_drvdata(pdev);
> +
> +	rtc_write(0, rtc_omap, OMAP_RTC_INTERRUPTS_REG);
>  }
>  
> -MODULE_ALIAS("platform:omap_rtc");
>  static struct platform_driver omap_rtc_driver = {
>  	.remove		= __exit_p(omap_rtc_remove),
>  	.shutdown	= omap_rtc_shutdown,
> @@ -578,5 +614,6 @@ static struct platform_driver omap_rtc_driver = {
>  
>  module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
>  
> +MODULE_ALIAS("platform:omap_rtc");

This is another unrelated clean up that should go in a different patch.

>  MODULE_AUTHOR("George G. Davis (and others)");
>  MODULE_LICENSE("GPL");

Johan
