From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Wed, 2 Dec 2009 19:33:21 +0200
Message-ID: <20091202173321.GA23738@nokia.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755362AbZLBRdu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1259333060-24277-1-git-send-email-notasas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 27, 2009 at 03:44:20PM +0100, ext Grazvydas Ignotas wrote:
>diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>index b96f29d..9cea9b5 100644
>--- a/drivers/power/Makefile
>+++ b/drivers/power/Makefile
>@@ -29,3 +29,4 @@ obj-$(CONFIG_BATTERY_BQ27x00) +=3D bq27x00_battery.o
> obj-$(CONFIG_BATTERY_DA9030)   +=3D da9030_battery.o
> obj-$(CONFIG_BATTERY_MAX17040) +=3D max17040_battery.o
> obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
>+obj-$(CONFIG_CHARGER_TWL4030)  +=3D twl4030_charger.o
>diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_c=
harger.c
>new file mode 100644
>index 0000000..604dd56
>--- /dev/null
>+++ b/drivers/power/twl4030_charger.c
>@@ -0,0 +1,499 @@
>+/*
>+ * TWL4030/TPS65950 BCI (Battery Charger Interface) driver
>+ *
>+ * Copyright (C) 2009 Gra=C5=BEvydas Ignotas <notasas@gmail.com>
>+ *
>+ * based on twl4030_bci_battery.c by TI
>+ * Copyright (C) 2008 Texas Instruments, Inc.
>+ *
>+ * This program is free software; you can redistribute it and/or modi=
fy
>+ * it under the terms of the GNU General Public License as published =
by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ */
>+
>+#include <linux/init.h>
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/interrupt.h>
>+#include <linux/i2c/twl4030.h>
>+#include <linux/power_supply.h>
>+
>+#define REG_BCIMSTATEC         0x02

please prepend these defines with e.g. TWL4030_BCI_

this would look like:

#define TWL4030_BCI_MSTATEC	0x02

>+#define REG_BCIICHG            0x08
>+#define REG_BCIVAC             0x0a
>+#define REG_BCIVBUS            0x0c
>+#define REG_BCIMFSTS4          0x10
>+#define REG_BCICTL1            0x23
>+
>+#define REG_BOOT_BCI           0x07
>+#define REG_STS_HW_CONDITIONS  0x0f
>+
>+#define BCIAUTOWEN             0x20
>+#define CONFIG_DONE            0x10
>+#define CVENAC                 0x04
>+#define BCIAUTOUSB             0x02
>+#define BCIAUTOAC              0x01
>+#define BCIMSTAT_MASK          0x3F
>+#define STS_VBUS               0x80
>+#define STS_CHG                        0x02
>+#define STS_USB_ID             0x04
>+#define CGAIN                  0x20
>+#define USBFASTMCHG            0x04
>+
>+#define STATEC_USB             0x10
>+#define STATEC_AC              0x20
>+#define STATEC_STATUS_MASK     0x0f
>+#define STATEC_QUICK1          0x02
>+#define STATEC_QUICK7          0x07
>+#define STATEC_COMPLETE1       0x0b
>+#define STATEC_COMPLETE4       0x0e
>+
>+#define BCI_DELAY              100

100ms ??? that's too quick for battery monitoring. Imagine that you'll=20
have 10 i2c transfers per-second forever with this one. Don't you think=
=20
you're waking up omap for nothing ??

something like 1 second when doing heavy operation should be enough and=
=20
5 to 10 seconds in idle is good enough as well.

>+static struct twl4030_bci_device_info twl4030_bci =3D {

this should be allocated on probe() time.

>+/*
>+ * called by TWL4030 USB transceiver driver on USB_PRES interrupt.
>+ */
>+int twl4030charger_usb_en(int enable)
>+{
>+       if (twl4030_bci.started)
>+               schedule_delayed_work(&twl4030_bci.bat_work,
>+                       msecs_to_jiffies(BCI_DELAY));

I don't like the way you did this. I would expect twl4030-usb to kick=20
the charger detection based on the VBUS irq. You have to consider the=20
possibility of boards which won't use BCI module and will have some=20
bq24xxx chip dealing with that like RX51. So instead of implementing=20
this here and forcing people to have this driver enabled on e.g. RX51,=20
you should implement the charger_enable_usb() logic in twl4030-usb=20
itself. /me thinks

>+static int __devinit twl4030_bci_probe(struct platform_device *pdev)
>+{
>+       int irq;
>+       int ret;
>+
>+       twl4030_charger_enable_ac(true);
>+       twl4030_charger_enable_usb(true);
>+
>+       irq =3D platform_get_irq(pdev, 0);
>+
>+       /* CHG_PRES irq */
>+       ret =3D request_irq(irq, twl4030_charger_interrupt,
>+               0, pdev->name, &twl4030_bci);

how about using request_threaded_irq() ?? then you avoid having that=20
workqueue.

--=20
balbi
