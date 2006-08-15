From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 15 Aug 2006 12:58:47 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5071E44DE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Like Steve indicated RTC is in the companion chip.

The GP-Timers (especially the one in the wake up domain) are capable of
generated a wake up interrupt.

The timer can be used somewhat like an RTC if desired.  We do something
like this for test. Before going to sleep select max divider and set the
wake up timer source to 32KHz.  You can now be woken up by a match
register (timed wake) or by roll over.

The power chip's RTC is easier in some regards and harder in others.  As
the power chip requires I2C to talk there is a bit of extra activity in
the programming of it as compared to the internally memory mapped
timers.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Johnson, Steve-OMAP
> Sent: Tuesday, August 15, 2006 12:25 PM
> To: David Brownell; linux-omap-open-source@linux.omap.com
> Subject: RE: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework
driver
>=20
> Hi Dave,
>=20
> For OMAP2 and OMAP3, the RTC is in the Power Management companion chip
> (TWL92230 and TWL4030).
>=20
> Where do you see an RTC on the web site for OMAP2420?  The only
picture
> I see shows the RTC in the companion chip.
>=20
>
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=3D=

> 6123&navigationId=3D11990&contentId=3D4671
>=20
> Regards,
>=20
> Steve
>=20
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com
> > [mailto:linux-omap-open-source-bounces@linux.omap.com] On
> > Behalf Of David Brownell
> > Sent: Tuesday, August 15, 2006 12:04 PM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
> >
> > Cleaning out my patch queue ... here's an "rtc class" driver.
> >  Much more suitable for upstream merging than the previous
> > version, even though that code has gotten much cleaner over time.
> >
> > Could someone confirm that this RTC can't actually do system
> > wakeups without external hardware support?  My documentation
> > isn't at all clear on that issue.  There's certainly an
> > external wakeup signal available, but text also says that the
> > alarm irq should work the normal way ... but I don't see that
> > happening.  It could easily be just a bug in
> > enable_irq_wakeup(INT_RTC_ALARM) handling, which ISTR looked
> > like a big NOP last I checked (for almost all IRQs).
> >
> > Also, someone with an OMAP2 setup should confirm that the
> > Kconfig is right, and this particular controller isn't
> > provided on OMAP2.  That certainly matches the lack of RTC in
> > the .../mach-omap2 directory, but the TI website says 2420
> > (but not {2,3}430) has an RTC.  Maybe the OMAP 2420 support
> > is just missing, and it's really the same RTC...
> >
> > - Dave
> >
> >
> > This creates a new RTC-framework driver for the RTC/calendar
> > module found in various OMAP chips, giving a more
> > correct/standard replacement for the older
> > drivers/char/omap-rtc.c driver.  Differences include:
> >
> >  - much smaller/simpler, because it reuses shared infrastructure
> >  - the RTC name will normally be "rtc0" not "rtc"
> >  - the /dev node has a different major and minor numbers
> >  - RTC_ALM_SET handled as on PCs (alarm within 24 hours)
> >  - RTC_WKALM_SET handled as on PCs (alarm within this century)
> >  - epoch not changeable (why bother)
> >  - rtc alarm may optionally be a system wakeup event
(board-specific)
> >
> > If you use udev and statically link this, some init script
> > can just create a symbolic link (rtc -> rtc0) so tools like
> > "hwclock" will work as usual.
> > Or, updates to hwclock (and busybox) are available which
> > teach it to use the /dev/rtc0 path as a backup, and to
> > support "hwclock --file=3D/dev/rtc0".
> >
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> >
> > ----
> > Presumably an upstream merge should remove the devices.c
> > support for the older non-framework driver.
> >
> >  arch/arm/mach-omap1/devices.c |    2
> >  drivers/rtc/Kconfig           |    8
> >  drivers/rtc/Makefile          |    1
> >  drivers/rtc/rtc-omap.c        |  573
> > ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 583 insertions(+), 1 deletion(-)
> >
> > Index: omap-2.6/drivers/rtc/Kconfig
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- omap-2.6.orig/drivers/rtc/Kconfig	2006-08-07
> > 20:53:03.000000000 -0700
> > +++ omap-2.6/drivers/rtc/Kconfig	2006-08-15
> > 08:40:06.000000000 -0700
> > @@ -151,6 +151,14 @@ config RTC_DRV_DS1742
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called rtc-ds1742.
> >
> > +config RTC_DRV_OMAP
> > +	tristate "TI OMAP1"
> > +	depends on RTC_CLASS && ( \
> > +		ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 )
> > +	help
> > +	  Say "yes" here to support the real time clock on TI
> > OMAP1 chips.
> > +	  This driver can also be built as a module called rtc-omap.
> > +
> >  config RTC_DRV_PCF8563
> >  	tristate "Philips PCF8563/Epson RTC8564"
> >  	depends on RTC_CLASS && I2C
> > Index: omap-2.6/arch/arm/mach-omap1/devices.c
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- omap-2.6.orig/arch/arm/mach-omap1/devices.c
> > 2006-08-07 20:50:44.000000000 -0700
> > +++ omap-2.6/arch/arm/mach-omap1/devices.c	2006-08-15
> > 08:40:06.000000000 -0700
> > @@ -26,7 +26,7 @@
> >
> >
> > /*------------------------------------------------------------
> > -------------*/
> >
> > -#if	defined(CONFIG_OMAP_RTC) || defined(CONFIG_OMAP_RTC)
> > +#if defined(CONFIG_OMAP_RTC) || defined(CONFIG_RTC_DRV_OMAP) ||
> > +defined(CONFIG_RTC_DRV_OMAP_MODULE)
> >
> >  #define	OMAP_RTC_BASE		0xfffb4800
> >
> > Index: omap-2.6/drivers/rtc/Makefile
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- omap-2.6.orig/drivers/rtc/Makefile	2006-08-07
> > 20:53:03.000000000 -0700
> > +++ omap-2.6/drivers/rtc/Makefile	2006-08-15
> > 08:40:49.000000000 -0700
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_RTC_DRV_TEST)	+=3D rtc-test.o
> >  obj-$(CONFIG_RTC_DRV_DS1307)	+=3D rtc-ds1307.o
> >  obj-$(CONFIG_RTC_DRV_DS1672)	+=3D rtc-ds1672.o
> >  obj-$(CONFIG_RTC_DRV_DS1742)	+=3D rtc-ds1742.o
> > +obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
> >  obj-$(CONFIG_RTC_DRV_PCF8563)	+=3D rtc-pcf8563.o
> >  obj-$(CONFIG_RTC_DRV_PCF8583)	+=3D rtc-pcf8583.o
> >  obj-$(CONFIG_RTC_DRV_RS5C372)	+=3D rtc-rs5c372.o
> > Index: omap-2.6/drivers/rtc/rtc-omap.c
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ omap-2.6/drivers/rtc/rtc-omap.c	2006-08-15
> > 08:40:06.000000000 -0700
> > @@ -0,0 +1,573 @@
> > +/*
> > + * TI OMAP1 Real Time Clock interface for Linux
> > + *
> > + * Copyright (C) 2003 MontaVista Software, Inc.
> > + * Author: George G. Davis <gdavis@mvista.com> or
<source@mvista.com>
> > + *
> > + * Copyright (C) 2006 David Brownell (new RTC framework)
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/ioport.h>
> > +#include <linux/delay.h>
> > +#include <linux/rtc.h>
> > +#include <linux/bcd.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/io.h>
> > +#include <asm/mach/time.h>
> > +
> > +
> > +/* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD
clock
> > + * with century-range alarm matching, driven by the 32kHz clock.
> > + *
> > + * The main user-visible ways it differs from PC RTCs are by
omitting
> > + * "don't care" alarm fields and sub-second periodic IRQs, and
having
> > + * an autoadjust mechanism to calibrate to the true oscillator
rate.
> > + *
> > + * Board-specific wiring options include using split power mode
with
> > + * RTC_OFF_NOFF used as the reset signal (so the RTC won't be
reset),
> > + * and wiring RTC_WAKE_INT (so the RTC alarm can wake the system
from
> > + * low power modes).  See the BOARD-SPECIFIC CUSTOMIZATION comment.
> > + */
> > +
> > +#define OMAP_RTC_BASE			0xfffb4800
> > +
> > +/* RTC registers */
> > +#define OMAP_RTC_SECONDS_REG		0x00
> > +#define OMAP_RTC_MINUTES_REG		0x04
> > +#define OMAP_RTC_HOURS_REG		0x08
> > +#define OMAP_RTC_DAYS_REG		0x0C
> > +#define OMAP_RTC_MONTHS_REG		0x10
> > +#define OMAP_RTC_YEARS_REG		0x14
> > +#define OMAP_RTC_WEEKS_REG		0x18
> > +
> > +#define OMAP_RTC_ALARM_SECONDS_REG	0x20
> > +#define OMAP_RTC_ALARM_MINUTES_REG	0x24
> > +#define OMAP_RTC_ALARM_HOURS_REG	0x28
> > +#define OMAP_RTC_ALARM_DAYS_REG		0x2c
> > +#define OMAP_RTC_ALARM_MONTHS_REG	0x30
> > +#define OMAP_RTC_ALARM_YEARS_REG	0x34
> > +
> > +#define OMAP_RTC_CTRL_REG		0x40
> > +#define OMAP_RTC_STATUS_REG		0x44
> > +#define OMAP_RTC_INTERRUPTS_REG		0x48
> > +
> > +#define OMAP_RTC_COMP_LSB_REG		0x4c
> > +#define OMAP_RTC_COMP_MSB_REG		0x50
> > +#define OMAP_RTC_OSC_REG		0x54
> > +
> > +/* OMAP_RTC_CTRL_REG bit fields: */
> > +#define OMAP_RTC_CTRL_SPLIT		(1<<7)
> > +#define OMAP_RTC_CTRL_DISABLE		(1<<6)
> > +#define OMAP_RTC_CTRL_SET_32_COUNTER	(1<<5)
> > +#define OMAP_RTC_CTRL_TEST		(1<<4)
> > +#define OMAP_RTC_CTRL_MODE_12_24	(1<<3)
> > +#define OMAP_RTC_CTRL_AUTO_COMP		(1<<2)
> > +#define OMAP_RTC_CTRL_ROUND_30S		(1<<1)
> > +#define OMAP_RTC_CTRL_STOP		(1<<0)
> > +
> > +/* OMAP_RTC_STATUS_REG bit fields: */
> > +#define OMAP_RTC_STATUS_POWER_UP        (1<<7)
> > +#define OMAP_RTC_STATUS_ALARM           (1<<6)
> > +#define OMAP_RTC_STATUS_1D_EVENT        (1<<5)
> > +#define OMAP_RTC_STATUS_1H_EVENT        (1<<4)
> > +#define OMAP_RTC_STATUS_1M_EVENT        (1<<3)
> > +#define OMAP_RTC_STATUS_1S_EVENT        (1<<2)
> > +#define OMAP_RTC_STATUS_RUN             (1<<1)
> > +#define OMAP_RTC_STATUS_BUSY            (1<<0)
> > +
> > +/* OMAP_RTC_INTERRUPTS_REG bit fields: */
> > +#define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
> > +#define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
> > +
> > +
> > +#define rtc_read(addr)
> > omap_readb(OMAP_RTC_BASE + (addr))
> > +#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE +
> (addr))
> > +
> > +
> > +/* platform_bus isn't hotpluggable, so for static linkage
> > it'd be safe
> > + * to get rid of probe() and remove() code ... too bad the driver
> > +struct
> > + * remembers probe(), that's about 25% of the runtime footprint!!
> > + */
> > +#ifndef	MODULE
> > +#undef	__devexit
> > +#undef	__devexit_p
> > +#define	__devexit	__exit
> > +#define	__devexit_p	__exit_p
> > +#endif
> > +
> > +
> > +/* we rely on the rtc framework to handle locking (rtc->ops_lock),
> > + * so the only other requirement is that register accesses which
> > + * require BUSY to be clear are made with IRQs locally disabled  */
> > +static void rtc_wait_not_busy(void) {
> > +	int	count =3D 0;
> > +	u8	status;
> > +
> > +	/* BUSY may stay active for 1/32768 second (~30 usec) */
> > +	for (count =3D 0; count < 50; count++) {
> > +		status =3D rtc_read(OMAP_RTC_STATUS_REG);
> > +		if ((status & (u8)OMAP_RTC_STATUS_BUSY) =3D=3D 0)
> > +			break;
> > +		udelay(1);
> > +	}
> > +	/* now we have ~15 usec to read/write various registers */ }
> > +
> > +static irqreturn_t rtc_irq(int irq, void *class_dev, struct pt_regs
> > +*regs) {
> > +	unsigned long		events =3D 0;
> > +	u8			irq_data;
> > +
> > +	irq_data =3D rtc_read(OMAP_RTC_STATUS_REG);
> > +
> > +	/* alarm irq? */
> > +	if (irq_data & OMAP_RTC_STATUS_ALARM) {
> > +		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> > +		events |=3D RTC_IRQF | RTC_AF;
> > +	}
> > +
> > +	/* 1/sec periodic/update irq? */
> > +	if (irq_data & OMAP_RTC_STATUS_1S_EVENT)
> > +		events |=3D RTC_IRQF | RTC_UF;
> > +
> > +	rtc_update_irq(class_dev, 1, events);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +#ifdef	CONFIG_RTC_INTF_DEV
> > +
> > +static int
> > +omap_rtc_ioctl(struct device *dev, unsigned int cmd,
> > unsigned long arg)
> > +{
> > +	u8 reg;
> > +
> > +	switch (cmd) {
> > +	case RTC_AIE_OFF:
> > +	case RTC_AIE_ON:
> > +	case RTC_UIE_OFF:
> > +	case RTC_UIE_ON:
> > +		break;
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +
> > +	local_irq_disable();
> > +	rtc_wait_not_busy();
> > +	reg =3D rtc_read(OMAP_RTC_INTERRUPTS_REG);
> > +	switch (cmd) {
> > +	/* AIE =3D Alarm Interrupt Enable */
> > +	case RTC_AIE_OFF:
> > +		reg &=3D ~OMAP_RTC_INTERRUPTS_IT_ALARM;
> > +		break;
> > +	case RTC_AIE_ON:
> > +		reg |=3D OMAP_RTC_INTERRUPTS_IT_ALARM;
> > +		break;
> > +	/* UIE =3D Update Interrupt Enable (1/second) */
> > +	case RTC_UIE_OFF:
> > +		reg &=3D ~OMAP_RTC_INTERRUPTS_IT_TIMER;
> > +		break;
> > +	case RTC_UIE_ON:
> > +		reg |=3D OMAP_RTC_INTERRUPTS_IT_TIMER;
> > +		break;
> > +	}
> > +	rtc_wait_not_busy();
> > +	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> > +	local_irq_enable();
> > +
> > +	return 0;
> > +}
> > +
> > +#else
> > +#define	omap_rtc_ioctl	NULL
> > +#endif
> > +
> > +/* this hardware doesn't support "don't care" alarm fields */
static
> > +int tm2bcd(struct rtc_time *tm) {
> > +	if (rtc_valid_tm(tm) !=3D 0)
> > +		return -EINVAL;
> > +
> > +	tm->tm_sec =3D BIN2BCD(tm->tm_sec);
> > +	tm->tm_min =3D BIN2BCD(tm->tm_min);
> > +	tm->tm_hour =3D BIN2BCD(tm->tm_hour);
> > +	tm->tm_mday =3D BIN2BCD(tm->tm_mday);
> > +
> > +	tm->tm_mon =3D BIN2BCD(tm->tm_mon + 1);
> > +
> > +	/* epoch =3D=3D 1900 */
> > +	if (tm->tm_year < 100 || tm->tm_year > 199)
> > +		return -EINVAL;
> > +	tm->tm_year =3D BIN2BCD(tm->tm_year - 100);
> > +
> > +	return 0;
> > +}
> > +
> > +static void bcd2tm(struct rtc_time *tm) {
> > +	tm->tm_sec =3D BCD2BIN(tm->tm_sec);
> > +	tm->tm_min =3D BCD2BIN(tm->tm_min);
> > +	tm->tm_hour =3D BCD2BIN(tm->tm_hour);
> > +	tm->tm_mday =3D BCD2BIN(tm->tm_mday);
> > +	tm->tm_mon =3D BCD2BIN(tm->tm_mon) - 1;
> > +	/* epoch =3D=3D 1900 */
> > +	tm->tm_year =3D BCD2BIN(tm->tm_year) + 100; }
> > +
> > +
> > +static int omap_rtc_read_time(struct device *dev, struct
> > rtc_time *tm)
> > +{
> > +	/* we don't report wday/yday/isdst ... */
> > +	local_irq_disable();
> > +	rtc_wait_not_busy();
> > +
> > +	tm->tm_sec =3D rtc_read(OMAP_RTC_SECONDS_REG);
> > +	tm->tm_min =3D rtc_read(OMAP_RTC_MINUTES_REG);
> > +	tm->tm_hour =3D rtc_read(OMAP_RTC_HOURS_REG);
> > +	tm->tm_mday =3D rtc_read(OMAP_RTC_DAYS_REG);
> > +	tm->tm_mon =3D rtc_read(OMAP_RTC_MONTHS_REG);
> > +	tm->tm_year =3D rtc_read(OMAP_RTC_YEARS_REG);
> > +
> > +	local_irq_enable();
> > +
> > +	bcd2tm(tm);
> > +	return 0;
> > +}
> > +
> > +static int omap_rtc_set_time(struct device *dev, struct rtc_time
*tm)
> > +{
> > +	if (tm2bcd(tm) < 0)
> > +		return -EINVAL;
> > +	local_irq_disable();
> > +	rtc_wait_not_busy();
> > +
> > +	rtc_write(tm->tm_year, OMAP_RTC_YEARS_REG);
> > +	rtc_write(tm->tm_mon, OMAP_RTC_MONTHS_REG);
> > +	rtc_write(tm->tm_mday, OMAP_RTC_DAYS_REG);
> > +	rtc_write(tm->tm_hour, OMAP_RTC_HOURS_REG);
> > +	rtc_write(tm->tm_min, OMAP_RTC_MINUTES_REG);
> > +	rtc_write(tm->tm_sec, OMAP_RTC_SECONDS_REG);
> > +
> > +	local_irq_enable();
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_rtc_read_alarm(struct device *dev, struct
> > rtc_wkalrm *alm)
> > +{
> > +	local_irq_disable();
> > +	rtc_wait_not_busy();
> > +
> > +	alm->time.tm_sec =3D rtc_read(OMAP_RTC_ALARM_SECONDS_REG);
> > +	alm->time.tm_min =3D rtc_read(OMAP_RTC_ALARM_MINUTES_REG);
> > +	alm->time.tm_hour =3D rtc_read(OMAP_RTC_ALARM_HOURS_REG);
> > +	alm->time.tm_mday =3D rtc_read(OMAP_RTC_ALARM_DAYS_REG);
> > +	alm->time.tm_mon =3D rtc_read(OMAP_RTC_ALARM_MONTHS_REG);
> > +	alm->time.tm_year =3D rtc_read(OMAP_RTC_ALARM_YEARS_REG);
> > +
> > +	local_irq_enable();
> > +
> > +	bcd2tm(&alm->time);
> > +	alm->pending =3D !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
> > +			& OMAP_RTC_INTERRUPTS_IT_ALARM);
> > +	alm->enabled =3D alm->pending && device_may_wakeup(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_rtc_set_alarm(struct device *dev, struct
> > rtc_wkalrm *alm)
> > +{
> > +	u8 reg;
> > +
> > +	/* Much userspace code uses RTC_ALM_SET, thus "don't care" for
> > +	 * day/month/year specifies alarms up to 24 hours in the future.
> > +	 * So we need to handle that ... but let's ignore the
> > "don't care"
> > +	 * values for hours/minutes/seconds.
> > +	 */
> > +	if (alm->time.tm_mday <=3D 0
> > +			&& alm->time.tm_mon < 0
> > +			&& alm->time.tm_year < 0) {
> > +		struct rtc_time tm;
> > +		unsigned long now, then;
> > +
> > +		omap_rtc_read_time(dev, &tm);
> > +		rtc_tm_to_time(&tm, &now);
> > +
> > +		alm->time.tm_mday =3D tm.tm_mday;
> > +		alm->time.tm_mon =3D tm.tm_mon;
> > +		alm->time.tm_year =3D tm.tm_year;
> > +		rtc_tm_to_time(&alm->time, &then);
> > +
> > +		/* sometimes the alarm wraps into tomorrow */
> > +		if (then < now) {
> > +			rtc_time_to_tm(now + 24 * 60 * 60, &tm);
> > +			alm->time.tm_mday =3D tm.tm_mday;
> > +			alm->time.tm_mon =3D tm.tm_mon;
> > +			alm->time.tm_year =3D tm.tm_year;
> > +		}
> > +	}
> > +
> > +	if (tm2bcd(&alm->time) < 0)
> > +		return -EINVAL;
> > +
> > +	local_irq_disable();
> > +	rtc_wait_not_busy();
> > +
> > +	rtc_write(alm->time.tm_year, OMAP_RTC_ALARM_YEARS_REG);
> > +	rtc_write(alm->time.tm_mon, OMAP_RTC_ALARM_MONTHS_REG);
> > +	rtc_write(alm->time.tm_mday, OMAP_RTC_ALARM_DAYS_REG);
> > +	rtc_write(alm->time.tm_hour, OMAP_RTC_ALARM_HOURS_REG);
> > +	rtc_write(alm->time.tm_min, OMAP_RTC_ALARM_MINUTES_REG);
> > +	rtc_write(alm->time.tm_sec, OMAP_RTC_ALARM_SECONDS_REG);
> > +
> > +	reg =3D rtc_read(OMAP_RTC_INTERRUPTS_REG);
> > +	if (alm->enabled)
> > +		reg |=3D OMAP_RTC_INTERRUPTS_IT_ALARM;
> > +	else
> > +		reg &=3D ~OMAP_RTC_INTERRUPTS_IT_ALARM;
> > +	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
> > +
> > +	local_irq_enable();
> > +
> > +	return 0;
> > +}
> > +
> > +static struct rtc_class_ops omap_rtc_ops =3D {
> > +	.ioctl		=3D omap_rtc_ioctl,
> > +	.read_time	=3D omap_rtc_read_time,
> > +	.set_time	=3D omap_rtc_set_time,
> > +	.read_alarm	=3D omap_rtc_read_alarm,
> > +	.set_alarm	=3D omap_rtc_set_alarm,
> > +};
> > +
> > +static int omap_rtc_alarm;
> > +static int omap_rtc_timer;
> > +
> > +static int __devinit omap_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct resource		*res, *mem;
> > +	struct rtc_device	*rtc;
> > +	u8			reg, new_ctrl;
> > +
> > +	omap_rtc_timer =3D platform_get_irq(pdev, 0);
> > +	if (omap_rtc_timer <=3D 0) {
> > +		pr_debug("%s: no update irq?\n", pdev->name);
> > +		return -ENOENT;
> > +	}
> > +
> > +	omap_rtc_alarm =3D platform_get_irq(pdev, 1);
> > +	if (omap_rtc_alarm <=3D 0) {
> > +		pr_debug("%s: no alarm irq?\n", pdev->name);
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* NOTE:  using static mapping for RTC registers */
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (res && res->start !=3D OMAP_RTC_BASE) {
> > +		pr_debug("%s: RTC registers at %08x, expected %08x\n",
> > +			pdev->name, (unsigned) res->start,
> > OMAP_RTC_BASE);
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (res)
> > +		mem =3D request_mem_region(res->start,
> > +				res->end - res->start + 1,
> > +				pdev->name);
> > +	else
> > +		mem =3D NULL;
> > +	if (!mem) {
> > +		pr_debug("%s: RTC registers at %08x are not free\n",
> > +			pdev->name, OMAP_RTC_BASE);
> > +		return -EBUSY;
> > +	}
> > +
> > +	rtc =3D rtc_device_register(pdev->name, &pdev->dev,
> > +			&omap_rtc_ops, THIS_MODULE);
> > +	if (IS_ERR(rtc)) {
> > +		pr_debug("%s: can't register RTC device, err %ld\n",
> > +			pdev->name, PTR_ERR(rtc));
> > +		goto fail;
> > +	}
> > +	platform_set_drvdata(pdev, rtc);
> > +	class_set_devdata(&rtc->class_dev, mem);
> > +
> > +	/* clear pending irqs, and set 1/second periodic,
> > +	 * which we'll use instead of update irqs
> > +	 */
> > +	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +
> > +	/* clear old status */
> > +	reg =3D rtc_read(OMAP_RTC_STATUS_REG);
> > +	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
> > +		pr_info("%s: RTC power up reset detected\n",
> > +			pdev->name);
> > +		rtc_write(OMAP_RTC_STATUS_POWER_UP,
> > OMAP_RTC_STATUS_REG);
> > +	}
> > +	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
> > +		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
> > +
> > +	/* handle periodic and alarm irqs */
> > +	if (request_irq(omap_rtc_timer, rtc_irq, SA_INTERRUPT,
> > +			rtc->class_dev.class_id, &rtc->class_dev)) {
> > +		pr_debug("%s: RTC timer interrupt IRQ%d already
> > claimed\n",
> > +			pdev->name, omap_rtc_timer);
> > +		goto fail0;
> > +	}
> > +	if (request_irq(omap_rtc_alarm, rtc_irq, SA_INTERRUPT,
> > +			rtc->class_dev.class_id, &rtc->class_dev)) {
> > +		pr_debug("%s: RTC alarm interrupt IRQ%d already
> > claimed\n",
> > +			pdev->name, omap_rtc_alarm);
> > +		goto fail1;
> > +	}
> > +
> > +	/* On boards with split power, RTC_ON_NOFF won't reset
> > the RTC */
> > +	reg =3D rtc_read(OMAP_RTC_CTRL_REG);
> > +	if (reg & (u8) OMAP_RTC_CTRL_STOP)
> > +		pr_info("%s: already running\n", pdev->name);
> > +
> > +	/* force to 24 hour mode */
> > +	new_ctrl =3D reg & ~(OMAP_RTC_CTRL_SPLIT|OMAP_RTC_CTRL_AUTO_COMP);
> > +	new_ctrl |=3D OMAP_RTC_CTRL_STOP;
> > +
> > +	/* BOARD-SPECIFIC CUSTOMIZATION CAN GO HERE:
> > +	 *
> > +	 *  - Boards wired so that RTC_WAKE_INT does something,
> > and muxed
> > +	 *    right (W13_1610_RTC_WAKE_INT is the default after
> > chip reset),
> > +	 *    should initialize the device wakeup flag appropriately.
> > +	 *
> > +	 *  - Boards wired so RTC_ON_nOFF is used as the reset signal,
> > +	 *    rather than nPWRON_RESET, should forcibly enable split
> > +	 *    power mode.  (Some chip errata report that RTC_CTRL_SPLIT
> > +	 *    is write-only, and always reads as zero...)
> > +	 */
> > +	device_init_wakeup(&pdev->dev, 0);
> > +
> > +	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
> > +		pr_info("%s: split power mode\n", pdev->name);
> > +
> > +	if (reg !=3D new_ctrl)
> > +		rtc_write(new_ctrl, OMAP_RTC_CTRL_REG);
> > +
> > +	return 0;
> > +
> > +fail1:
> > +	free_irq(omap_rtc_timer, NULL);
> > +fail0:
> > +	rtc_device_unregister(rtc);
> > +fail:
> > +	release_resource(mem);
> > +	return -EIO;
> > +}
> > +
> > +static int __devexit omap_rtc_remove(struct platform_device *pdev)
> > +{
> > +	struct rtc_device	*rtc =3D platform_get_drvdata(pdev);;
> > +
> > +	device_init_wakeup(&pdev->dev, 0);
> > +
> > +	/* leave rtc running, but disable irqs */
> > +	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +
> > +	free_irq(omap_rtc_timer, rtc);
> > +	free_irq(omap_rtc_alarm, rtc);
> > +
> > +	release_resource(class_get_devdata(&rtc->class_dev));
> > +	rtc_device_unregister(rtc);
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +
> > +static struct timespec rtc_delta;
> > +static u8 irqstat;
> > +
> > +static int omap_rtc_suspend(struct platform_device *pdev,
> > pm_message_t state)
> > +{
> > +	struct rtc_time rtc_tm;
> > +	struct timespec time;
> > +
> > +	time.tv_nsec =3D 0;
> > +	omap_rtc_read_time(NULL, &rtc_tm);
> > +	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
> > +
> > +	save_time_delta(&rtc_delta, &time);
> > +	irqstat =3D rtc_read(OMAP_RTC_INTERRUPTS_REG);
> > +
> > +	/* FIXME the RTC alarm is not currently acting as a wakeup event
> > +	 * source, and in fact this enable() call is just saving a flag
> > +	 * that's never used...
> > +	 */
> > +	if (device_may_wakeup(&pdev->dev))
> > +		enable_irq_wake(omap_rtc_alarm);
> > +	else
> > +		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +
> > +	return 0;
> > +}
> > +
> > +static int omap_rtc_resume(struct platform_device *pdev)
> > +{
> > +	struct rtc_time rtc_tm;
> > +	struct timespec time;
> > +
> > +	time.tv_nsec =3D 0;
> > +	omap_rtc_read_time(NULL, &rtc_tm);
> > +	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
> > +
> > +	restore_time_delta(&rtc_delta, &time);
> > +	if (device_may_wakeup(&pdev->dev))
> > +		disable_irq_wake(omap_rtc_alarm);
> > +	else
> > +		rtc_write(irqstat, OMAP_RTC_INTERRUPTS_REG);
> > +	return 0;
> > +}
> > +
> > +#else
> > +#define omap_rtc_suspend NULL
> > +#define omap_rtc_resume  NULL
> > +#endif
> > +
> > +static void omap_rtc_shutdown(struct platform_device *pdev)
> > +{
> > +	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +}
> > +
> > +MODULE_ALIAS("omap_rtc");
> > +static struct platform_driver omap_rtc_driver =3D {
> > +	.probe		=3D omap_rtc_probe,
> > +	.remove		=3D __devexit_p(omap_rtc_remove),
> > +	.suspend	=3D omap_rtc_suspend,
> > +	.resume		=3D omap_rtc_resume,
> > +	.shutdown	=3D omap_rtc_shutdown,
> > +	.driver		=3D {
> > +		.name	=3D "omap_rtc",
> > +		.owner	=3D THIS_MODULE,
> > +	},
> > +};
> > +
> > +static int __init rtc_init(void)
> > +{
> > +	return platform_driver_register(&omap_rtc_driver);
> > +}
> > +
> > +static void __exit rtc_exit(void)
> > +{
> > +	platform_driver_unregister(&omap_rtc_driver);
> > +}
> > +
> > +module_init(rtc_init);
> > +module_exit(rtc_exit);
> > +
> > +MODULE_AUTHOR("George G. Davis (and others)");
> > +MODULE_LICENSE("GPL");
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
