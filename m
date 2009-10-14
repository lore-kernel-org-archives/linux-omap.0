From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: patch: add omap730 / omap850 rtc support
Date: Wed, 14 Oct 2009 12:41:37 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF600@dbde02.ent.ti.com>
References: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbZJNHMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 03:12:18 -0400
In-Reply-To: <3ea34a000910130433i36a3ac7esc6b8e7c6588185f4@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Christopher,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> Christopher Friedt
> Sent: Tuesday, October 13, 2009 5:03 PM
> To: linux-omap@vger.kernel.org
> Subject: patch: add omap730 / omap850 rtc support
> 
> Christopher Friedt <chrisfriedt@gmail.com>
> 20091013: Add support for the OMAP730 and OMAP850 RTC.
> ==============================================================
> ================
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0587d53..5163d67 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
> 
>  #include <asm/io.h>
> +#include <mach/cpu.h>
> 
> 
>  /* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD clock
> @@ -39,29 +40,80 @@
> 
>  #define OMAP_RTC_BASE			0xfffb4800
> 
> -/* RTC registers */
> -#define OMAP_RTC_SECONDS_REG		0x00
> -#define OMAP_RTC_MINUTES_REG		0x04
> -#define OMAP_RTC_HOURS_REG		0x08
> -#define OMAP_RTC_DAYS_REG		0x0C
> -#define OMAP_RTC_MONTHS_REG		0x10
> -#define OMAP_RTC_YEARS_REG		0x14
> -#define OMAP_RTC_WEEKS_REG		0x18
> -
> -#define OMAP_RTC_ALARM_SECONDS_REG	0x20
> -#define OMAP_RTC_ALARM_MINUTES_REG	0x24
> -#define OMAP_RTC_ALARM_HOURS_REG	0x28
> -#define OMAP_RTC_ALARM_DAYS_REG		0x2c
> -#define OMAP_RTC_ALARM_MONTHS_REG	0x30
> -#define OMAP_RTC_ALARM_YEARS_REG	0x34
> -
> -#define OMAP_RTC_CTRL_REG		0x40
> -#define OMAP_RTC_STATUS_REG		0x44
> -#define OMAP_RTC_INTERRUPTS_REG		0x48
> -
> -#define OMAP_RTC_COMP_LSB_REG		0x4c
> -#define OMAP_RTC_COMP_MSB_REG		0x50
> -#define OMAP_RTC_OSC_REG		0x54
> +enum omap_rtc_regs {
> +	SECONDS_REG = 0,
> +	MINUTES_REG,
> +	HOURS_REG,
> +	DAYS_REG,
> +	MONTHS_REG,
> +	YEARS_REG,
> +	WEEKS_REG,
> +	ALARM_SECONDS_REG,
> +	ALARM_MINUTES_REG,
> +	ALARM_HOURS_REG,
> +	ALARM_DAYS_REG,
> +	ALARM_MONTHS_REG,
> +	ALARM_YEARS_REG,
> +	CTRL_REG,
> +	STATUS_REG,
> +	INTERRUPTS_REG,
> +	COMP_LSB_REG,
> +	COMP_MSB_REG,
> +};
> +#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> +static u8 omap_8bit_rtc_offsets[] = {
> +	[SECONDS_REG] 		= 0x00,
> +	[MINUTES_REG] 		= 0x01,
> +	[HOURS_REG] 		= 0x02,
> +	[DAYS_REG] 			= 0x03,
> +	[MONTHS_REG] 		= 0x04,
> +	[YEARS_REG] 		= 0x05,
> +	[WEEKS_REG] 		= 0x06,
> +	/* 0x07 reserved */
> +	[ALARM_SECONDS_REG] = 0x08,
> +	[ALARM_MINUTES_REG] = 0x09,
> +	[ALARM_HOURS_REG] 	= 0x0a,
> +	[ALARM_DAYS_REG] 	= 0x0b,
> +	[ALARM_MONTHS_REG] 	= 0x0c,
> +	[ALARM_YEARS_REG] 	= 0x0d,
> +	/* 0x0e reserved */
> +	/* 0x0f reserved */
> +	[CTRL_REG] 			= 0x10,
> +	[STATUS_REG] 		= 0x11,
> +	[INTERRUPTS_REG] 	= 0x12,
> +	[COMP_LSB_REG] 		= 0x13,
> +	[COMP_MSB_REG] 		= 0x14,
> +};
> +#else
> +#define omap_8bit_rtc_offsets NULL
> +#endif
> +#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
> +static u8 omap_32bit_rtc_offsets[] = {
> +	[SECONDS_REG] 		= 0x00,
> +	[MINUTES_REG] 		= 0x04,
> +	[HOURS_REG] 		= 0x08,
> +	[DAYS_REG] 			= 0x0c,
> +	[MONTHS_REG] 		= 0x10,
> +	[YEARS_REG] 		= 0x14,
> +	[WEEKS_REG] 		= 0x18,
> +	[ALARM_SECONDS_REG] = 0x20,
> +	[ALARM_MINUTES_REG] = 0x24,
> +	[ALARM_HOURS_REG] 	= 0x28,
> +	[ALARM_DAYS_REG] 	= 0x2c,
> +	[ALARM_MONTHS_REG] 	= 0x30,
> +	[ALARM_YEARS_REG] 	= 0x34,
> +	[CTRL_REG] 			= 0x40,
> +	[STATUS_REG] 		= 0x44,
> +	[INTERRUPTS_REG] 	= 0x48,
> +	[COMP_LSB_REG] 		= 0x4c,
> +	[COMP_MSB_REG] 		= 0x50,
> +};

Any advantage of using both enum and register offsets? 
You can have only register offset macros instead of enum.

> +#else
> +#define omap_32bit_rtc_offsets NULL
> +#endif
> +
> +// set to 32bit or 8bit rtc offsets by omap_rtc_probe()
> +static u8 *rtc_offsets;
> 
>  /* OMAP_RTC_CTRL_REG bit fields: */
>  #define OMAP_RTC_CTRL_SPLIT		(1<<7)
> @@ -87,10 +139,8 @@
>  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
>  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
> 
> -
> -#define rtc_read(addr)		
> omap_readb(OMAP_RTC_BASE + (addr))
> -#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
> -
> +#define rtc_read(reg)		
> omap_readb(OMAP_RTC_BASE + rtc_offsets[reg])
> +#define rtc_write(val, reg)	omap_writeb(val, OMAP_RTC_BASE 
> + rtc_offsets[reg])

You may use omap_writeb(val, OMAP_RTC_BASE + OMAP_RTC_##reg) and 
omap_readb(OMAP_RTC_BASE+OMAP_RTC_##reg). 

> 
>  /* we rely on the rtc framework to handle locking (rtc->ops_lock),
>   * so the only other requirement is that register accesses which
> @@ -103,7 +153,7 @@ static void rtc_wait_not_busy(void)
> 
>  	/* BUSY may stay active for 1/32768 second (~30 usec) */
>  	for (count = 0; count < 50; count++) {
> -		status = rtc_read(OMAP_RTC_STATUS_REG);
> +		status = rtc_read(STATUS_REG);
>  		if ((status & (u8)OMAP_RTC_STATUS_BUSY) == 0)
>  			break;
>  		udelay(1);

Why 50? Count can be decreased from 50 to 30/35 which will increase rtc performance.

> @@ -116,11 +166,11 @@ static irqreturn_t rtc_irq(int irq, void *rtc)
>  	unsigned long		events = 0;
>  	u8			irq_data;
> 
> -	irq_data = rtc_read(OMAP_RTC_STATUS_REG);
> +	irq_data = rtc_read(STATUS_REG);
> 
>  	/* alarm irq? */
>  	if (irq_data & OMAP_RTC_STATUS_ALARM) {
> -		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_ALARM, STATUS_REG);
>  		events |= RTC_IRQF | RTC_AF;
>  	}
> 
> @@ -152,7 +202,7 @@ omap_rtc_ioctl(struct device *dev, unsigned int
> cmd, unsigned long arg)
> 
>  	local_irq_disable();
>  	rtc_wait_not_busy();
> -	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	reg = rtc_read(INTERRUPTS_REG);
>  	switch (cmd) {
>  	/* AIE = Alarm Interrupt Enable */
>  	case RTC_AIE_OFF:
> @@ -170,7 +220,7 @@ omap_rtc_ioctl(struct device *dev, unsigned int
> cmd, unsigned long arg)
>  		break;
>  	}
>  	rtc_wait_not_busy();
> -	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(reg, INTERRUPTS_REG);
>  	local_irq_enable();
> 
>  	return 0;
> @@ -219,12 +269,12 @@ static int omap_rtc_read_time(struct device
> *dev, struct rtc_time *tm)
>  	local_irq_disable();
>  	rtc_wait_not_busy();
> 
> -	tm->tm_sec = rtc_read(OMAP_RTC_SECONDS_REG);
> -	tm->tm_min = rtc_read(OMAP_RTC_MINUTES_REG);
> -	tm->tm_hour = rtc_read(OMAP_RTC_HOURS_REG);
> -	tm->tm_mday = rtc_read(OMAP_RTC_DAYS_REG);
> -	tm->tm_mon = rtc_read(OMAP_RTC_MONTHS_REG);
> -	tm->tm_year = rtc_read(OMAP_RTC_YEARS_REG);
> +	tm->tm_sec = rtc_read(SECONDS_REG);
> +	tm->tm_min = rtc_read(MINUTES_REG);
> +	tm->tm_hour = rtc_read(HOURS_REG);
> +	tm->tm_mday = rtc_read(DAYS_REG);
> +	tm->tm_mon = rtc_read(MONTHS_REG);
> +	tm->tm_year = rtc_read(YEARS_REG);
> 
>  	local_irq_enable();
> 
> @@ -239,12 +289,12 @@ static int omap_rtc_set_time(struct device *dev,
> struct rtc_time *tm)
>  	local_irq_disable();
>  	rtc_wait_not_busy();
> 
> -	rtc_write(tm->tm_year, OMAP_RTC_YEARS_REG);
> -	rtc_write(tm->tm_mon, OMAP_RTC_MONTHS_REG);
> -	rtc_write(tm->tm_mday, OMAP_RTC_DAYS_REG);
> -	rtc_write(tm->tm_hour, OMAP_RTC_HOURS_REG);
> -	rtc_write(tm->tm_min, OMAP_RTC_MINUTES_REG);
> -	rtc_write(tm->tm_sec, OMAP_RTC_SECONDS_REG);
> +	rtc_write(tm->tm_year, YEARS_REG);
> +	rtc_write(tm->tm_mon, MONTHS_REG);
> +	rtc_write(tm->tm_mday, DAYS_REG);
> +	rtc_write(tm->tm_hour, HOURS_REG);
> +	rtc_write(tm->tm_min, MINUTES_REG);
> +	rtc_write(tm->tm_sec, SECONDS_REG);
> 
>  	local_irq_enable();
> 
> @@ -256,17 +306,17 @@ static int omap_rtc_read_alarm(struct device
> *dev, struct rtc_wkalrm *alm)
>  	local_irq_disable();
>  	rtc_wait_not_busy();
> 
> -	alm->time.tm_sec = rtc_read(OMAP_RTC_ALARM_SECONDS_REG);
> -	alm->time.tm_min = rtc_read(OMAP_RTC_ALARM_MINUTES_REG);
> -	alm->time.tm_hour = rtc_read(OMAP_RTC_ALARM_HOURS_REG);
> -	alm->time.tm_mday = rtc_read(OMAP_RTC_ALARM_DAYS_REG);
> -	alm->time.tm_mon = rtc_read(OMAP_RTC_ALARM_MONTHS_REG);
> -	alm->time.tm_year = rtc_read(OMAP_RTC_ALARM_YEARS_REG);
> +	alm->time.tm_sec = rtc_read(ALARM_SECONDS_REG);
> +	alm->time.tm_min = rtc_read(ALARM_MINUTES_REG);
> +	alm->time.tm_hour = rtc_read(ALARM_HOURS_REG);
> +	alm->time.tm_mday = rtc_read(ALARM_DAYS_REG);
> +	alm->time.tm_mon = rtc_read(ALARM_MONTHS_REG);
> +	alm->time.tm_year = rtc_read(ALARM_YEARS_REG);
> 
>  	local_irq_enable();
> 
>  	bcd2tm(&alm->time);
> -	alm->enabled = !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
> +	alm->enabled = !!(rtc_read(INTERRUPTS_REG)
>  			& OMAP_RTC_INTERRUPTS_IT_ALARM);
> 
>  	return 0;
> @@ -282,19 +332,19 @@ static int omap_rtc_set_alarm(struct device
> *dev, struct rtc_wkalrm *alm)
>  	local_irq_disable();
>  	rtc_wait_not_busy();
> 
> -	rtc_write(alm->time.tm_year, OMAP_RTC_ALARM_YEARS_REG);
> -	rtc_write(alm->time.tm_mon, OMAP_RTC_ALARM_MONTHS_REG);
> -	rtc_write(alm->time.tm_mday, OMAP_RTC_ALARM_DAYS_REG);
> -	rtc_write(alm->time.tm_hour, OMAP_RTC_ALARM_HOURS_REG);
> -	rtc_write(alm->time.tm_min, OMAP_RTC_ALARM_MINUTES_REG);
> -	rtc_write(alm->time.tm_sec, OMAP_RTC_ALARM_SECONDS_REG);
> +	rtc_write(alm->time.tm_year, ALARM_YEARS_REG);
> +	rtc_write(alm->time.tm_mon, ALARM_MONTHS_REG);
> +	rtc_write(alm->time.tm_mday, ALARM_DAYS_REG);
> +	rtc_write(alm->time.tm_hour, ALARM_HOURS_REG);
> +	rtc_write(alm->time.tm_min, ALARM_MINUTES_REG);
> +	rtc_write(alm->time.tm_sec, ALARM_SECONDS_REG);
> 
> -	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	reg = rtc_read(INTERRUPTS_REG);
>  	if (alm->enabled)
>  		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
>  	else
>  		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
> -	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(reg, INTERRUPTS_REG);
> 
>  	local_irq_enable();
> 
> @@ -318,6 +368,12 @@ static int __init omap_rtc_probe(struct
> platform_device *pdev)
>  	struct rtc_device	*rtc;
>  	u8			reg, new_ctrl;
> 
> +
> +	if ( cpu_is_omap7xx() )
> +		rtc_offsets = omap_8bit_rtc_offsets;
> +	else
> +		rtc_offsets = omap_32bit_rtc_offsets;
> +
>  	omap_rtc_timer = platform_get_irq(pdev, 0);
>  	if (omap_rtc_timer <= 0) {
>  		pr_debug("%s: no update irq?\n", pdev->name);
> @@ -363,17 +419,17 @@ static int __init omap_rtc_probe(struct
> platform_device *pdev)
>  	/* clear pending irqs, and set 1/second periodic,
>  	 * which we'll use instead of update irqs
>  	 */
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(0, INTERRUPTS_REG);
> 
>  	/* clear old status */
> -	reg = rtc_read(OMAP_RTC_STATUS_REG);
> +	reg = rtc_read(STATUS_REG);
>  	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
>  		pr_info("%s: RTC power up reset detected\n",
>  			pdev->name);
> -		rtc_write(OMAP_RTC_STATUS_POWER_UP, 
> OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_POWER_UP, STATUS_REG);
>  	}
>  	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
> -		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> +		rtc_write(OMAP_RTC_STATUS_ALARM, STATUS_REG);
> 
>  	/* handle periodic and alarm irqs */
>  	if (request_irq(omap_rtc_timer, rtc_irq, IRQF_DISABLED,
> @@ -390,7 +446,7 @@ static int __init omap_rtc_probe(struct
> platform_device *pdev)
>  	}
> 
>  	/* On boards with split power, RTC_ON_NOFF won't reset 
> the RTC */
> -	reg = rtc_read(OMAP_RTC_CTRL_REG);
> +	reg = rtc_read(CTRL_REG);
>  	if (reg & (u8) OMAP_RTC_CTRL_STOP)
>  		pr_info("%s: already running\n", pdev->name);
> 
> @@ -415,7 +471,7 @@ static int __init omap_rtc_probe(struct
> platform_device *pdev)
>  		pr_info("%s: split power mode\n", pdev->name);
> 
>  	if (reg != new_ctrl)
> -		rtc_write(new_ctrl, OMAP_RTC_CTRL_REG);
> +		rtc_write(new_ctrl, CTRL_REG);
> 
>  	return 0;
> 
> @@ -435,7 +491,7 @@ static int __exit omap_rtc_remove(struct
> platform_device *pdev)
>  	device_init_wakeup(&pdev->dev, 0);
> 
>  	/* leave rtc running, but disable irqs */
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(0, INTERRUPTS_REG);
> 
>  	free_irq(omap_rtc_timer, rtc);
>  	free_irq(omap_rtc_alarm, rtc);
> @@ -451,7 +507,7 @@ static u8 irqstat;
> 
>  static int omap_rtc_suspend(struct platform_device *pdev, 
> pm_message_t state)
>  {
> -	irqstat = rtc_read(OMAP_RTC_INTERRUPTS_REG);
> +	irqstat = rtc_read(INTERRUPTS_REG);
> 
>  	/* FIXME the RTC alarm is not currently acting as a wakeup event
>  	 * source, and in fact this enable() call is just saving a flag
> @@ -460,7 +516,7 @@ static int omap_rtc_suspend(struct platform_device
> *pdev, pm_message_t state)
>  	if (device_may_wakeup(&pdev->dev))
>  		enable_irq_wake(omap_rtc_alarm);
>  	else
> -		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +		rtc_write(0, INTERRUPTS_REG);
> 
>  	return 0;
>  }
> @@ -470,7 +526,7 @@ static int omap_rtc_resume(struct 
> platform_device *pdev)
>  	if (device_may_wakeup(&pdev->dev))
>  		disable_irq_wake(omap_rtc_alarm);
>  	else
> -		rtc_write(irqstat, OMAP_RTC_INTERRUPTS_REG);
> +		rtc_write(irqstat, INTERRUPTS_REG);
>  	return 0;
>  }
> 
> @@ -481,7 +537,7 @@ static int omap_rtc_resume(struct 
> platform_device *pdev)
> 
>  static void omap_rtc_shutdown(struct platform_device *pdev)
>  {
> -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> +	rtc_write(0, INTERRUPTS_REG);
>  }
> 
>  MODULE_ALIAS("platform:omap_rtc");
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3c20dae..9023316 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -578,7 +578,7 @@ comment "on-CPU RTC drivers"
> 
>  config RTC_DRV_OMAP
>  	tristate "TI OMAP1"
> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730
> +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || 
> ARCH_OMAP730 || ARCH_OMAP850
>  	help
>  	  Say "yes" here to support the real time clock on TI 
> OMAP1 chips.
>  	  This driver can also be built as a module called rtc-omap.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 