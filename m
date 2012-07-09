From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v3 4/7] mfd: omap: control: usb-phy: introduce the
 ctrl-module usb driver
Date: Mon, 9 Jul 2012 14:53:34 +0530
Message-ID: <CAAe_U6+YBO-9RE6tML3nW6zVdGRoXHkkbGvGaFYAC2Ag=P7s3w@mail.gmail.com>
References: <4FEB4B4C.9040501@dev.rtsoft.ru>
	<20120628045821.GD2471@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52863 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab2GIJXh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 05:23:37 -0400
Received: by vcbfl15 with SMTP id fl15so7858583vcb.20
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 02:23:34 -0700 (PDT)
In-Reply-To: <20120628045821.GD2471@besouro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@ti.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>, b-cousson@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

+Ajay

On Thu, Jun 28, 2012 at 10:28 AM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Hello,
>
> On Wed, Jun 27, 2012 at 10:05:00PM +0400, Konstantin Baydarov wrote:
>> Created a new platform driver for the platform device created by the
>> control module mfd core, wrt usb. This driver has API's to power on/=
off
>> the phy and the API's to write to musb mailbox.
>>
>> Changes since previous version:
>> - Bandgap and usb phy: drivers are now independent from control modu=
le driver, they use
>> their own functions to acess scm registers.
>> - Parent SCM platform device IOMEM resources is used to get the base=
 address of SCM window.
>> - SCM Dependency was removed from Kconfig.
>> - Bandgap and usb phy: Added private spinlocks for bandgap and usb d=
rivers.
>>
>> (p.s. the mailbox for musb in omap4 is present in system control
>> module)
>>
>> [kishon@ti.com: wrote the original API's related to USB functions]
>> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 12 +++
>> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/usb/otg/omap4-usb-phy.c =A0 | =A0170 ++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/usb/omap4_usb_phy.h | =A0 53 ++++++++++++
>> =A04 files changed, 236 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/usb/otg/omap4-usb-phy.c
>> =A0create mode 100644 include/linux/usb/omap4_usb_phy.h
>>
>> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
>> index 5c87db0..0ed691b 100644
>> --- a/drivers/usb/otg/Kconfig
>> +++ b/drivers/usb/otg/Kconfig
>> @@ -78,6 +78,18 @@ config TWL6030_USB
>> =A0 =A0 =A0 =A0 are hooked to this driver through platform_data stru=
cture.
>> =A0 =A0 =A0 =A0 The definition of internal PHY APIs are in the mach-=
omap2 layer.
>>
>> +config OMAP4_USB_PHY
>> + =A0 =A0 tristate "Texas Instruments OMAP4+ USB pin control driver"
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you say yes here you get support for the Texas Inst=
ruments
>> + =A0 =A0 =A0 OMAP4+ USB pin control driver. The register set is par=
t of system
>> + =A0 =A0 =A0 control module.
>> +
>> + =A0 =A0 =A0 USB phy in OMAP configures control module register for=
 powering on
>> + =A0 =A0 =A0 the phy, configuring VBUSVALID, AVALID, IDDIG and SESS=
END. For
>> + =A0 =A0 =A0 performing the above mentioned configuration, API's ar=
e added in
>> + =A0 =A0 =A0 by this children of the control module driver.
>> +
>> =A0config NOP_USB_XCEIV
>> =A0 =A0 =A0 tristate "NOP USB Transceiver Driver"
>> =A0 =A0 =A0 select USB_OTG_UTILS
>> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
>> index 41aa509..60c8c83 100644
>> --- a/drivers/usb/otg/Makefile
>> +++ b/drivers/usb/otg/Makefile
>> @@ -13,6 +13,7 @@ obj-$(CONFIG_USB_GPIO_VBUS) +=3D gpio_vbus.o
>> =A0obj-$(CONFIG_ISP1301_OMAP) =A0 +=3D isp1301_omap.o
>> =A0obj-$(CONFIG_TWL4030_USB) =A0 =A0+=3D twl4030-usb.o
>> =A0obj-$(CONFIG_TWL6030_USB) =A0 =A0+=3D twl6030-usb.o
>> +obj-$(CONFIG_OMAP4_USB_PHY) =A0+=3D omap4-usb-phy.o
>> =A0obj-$(CONFIG_NOP_USB_XCEIV) =A0+=3D nop-usb-xceiv.o
>> =A0obj-$(CONFIG_USB_ULPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D ulpi.o
>> =A0obj-$(CONFIG_USB_ULPI_VIEWPORT) =A0 =A0 =A0+=3D ulpi_viewport.o
>> diff --git a/drivers/usb/otg/omap4-usb-phy.c b/drivers/usb/otg/omap4=
-usb-phy.c
>> new file mode 100644
>> index 0000000..cbea2ea
>> --- /dev/null
>> +++ b/drivers/usb/otg/omap4-usb-phy.c
>> @@ -0,0 +1,170 @@
>> +/*
>> + * OMAP4 system control module driver, USB control children
>> + *
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.t=
i.com/
>> + *
>> + * Contact:
>> + * =A0 =A0Kishon Vijay Abraham I <kishon@ti.com>
>> + * =A0 =A0Eduardo Valentin <eduardo.valentin@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/usb/omap4_usb_phy.h>
>> +
>> +void __iomem *omap_usb_phy_base;
>> +spinlock_t omap_usb_phy_lock;
>> +
>> +static int omap_usb_phy_readl(u32 reg, u32 *val)
>> +{
>> + =A0 =A0 if (!omap_usb_phy_base)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 *val =3D __raw_readl(omap_usb_phy_base + reg);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * TODO: Get rid from omap_usb_phy_writel() return value -
>> + * It's useless.
>
> if you do that remember to keep a WARN_ON in case the base address is=
 not set.
>
>> + */
>> +static int omap_usb_phy_writel(u32 val, u32 reg)
>> +{
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 if (!omap_usb_phy_base)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 spin_lock_irqsave(&omap_usb_phy_lock, flags);
>> + =A0 =A0 __raw_writel(val, omap_usb_phy_base + reg);
>> + =A0 =A0 spin_unlock_irqrestore(&omap_usb_phy_lock, flags);
>
> I think it is better to lock per operation than per write.
>
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * omap4_usb_phy_power - power on/off the phy using control module =
reg
>> + * @dev: struct device *
>> + * @on: 0 or 1, based on powering on or off the PHY
>> + *
>> + * omap_usb2 can call this API to power on or off the PHY.
>> + */
>> +int omap4_usb_phy_power(struct device *dev, int on)
>> +{
>> + =A0 =A0 u32 val;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_usb_phy_readl(CONTROL_DEV_CON=
=46, &val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!ret && (val & PHY_PD)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_usb_phy_write=
l(~PHY_PD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 CONTROL_DEV_CONF);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX: add proper documen=
tation for this delay */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(200);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_usb_phy_writel(PHY_PD, CONTRO=
L_DEV_CONF);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(omap4_usb_phy_power);
>> +
>> +/**
>> + * omap4_usb_phy_mailbox - write to usb otg mailbox
>> + * @dev: struct device *
>> + * @val: the value to be written to the mailbox
>> + *
>> + * On detection of a device (ID pin is grounded), the phy should ca=
ll this API
>> + * to set AVALID, VBUSVALID and ID pin is grounded.
>> + *
>> + * When OMAP is connected to a host (OMAP in device mode), the phy =
should call
>> + * this API to set AVALID, VBUSVALID and ID pin in high impedance.
>> + *
>> + * The phy should call this API, if OMAP is disconnected from host =
or device.
>> + */
>> +int omap4_usb_phy_mailbox(struct device *dev, u32 val)
>> +{
>> + =A0 =A0 return omap_usb_phy_writel(val, CONTROL_USBOTGHS_CONTROL);
>> +}
>> +EXPORT_SYMBOL_GPL(omap4_usb_phy_mailbox);
>> +
>> +static int __devinit omap_usb_phy_probe(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct resource *io_res;
>> + =A0 =A0 struct platform_device *pparent;
>> +
>> + =A0 =A0 if (!pdev->dev.parent) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No parent device!\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pparent =3D to_platform_device(pdev->dev.parent);
>> +
>> + =A0 =A0 io_res =3D platform_get_resource(pparent, IORESOURCE_MEM, =
0);
>
> Can someone please explain me what do we gain by doing this at childr=
en code?
>
>> + =A0 =A0 if (!io_res)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
>> +
>> + =A0 =A0 omap_usb_phy_base =3D ioremap(io_res->start, resource_size=
(io_res));
>> + =A0 =A0 if (!omap_usb_phy_base)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 /* Initialize register lock */
>> + =A0 =A0 spin_lock_init(&omap_usb_phy_lock);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devexit omap_usb_phy_remove(struct platform_device *pd=
ev)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct of_device_id of_omap_usb_phy_match[] =3D {
>> + =A0 =A0 { .compatible =3D "ti,omap4-usb-phy", },
>> + =A0 =A0 { },
>> +};
>> +
>> +static struct platform_driver omap_usb_phy_driver =3D {
>> + =A0 =A0 .probe =3D omap_usb_phy_probe,
>> + =A0 =A0 .remove =3D __devexit_p(omap_usb_phy_remove),
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap4-usb-p=
hy",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_oma=
p_usb_phy_match,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init omap_usb_phy_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap_usb_phy_driver);
>> +}
>> +postcore_initcall(omap_usb_phy_init);
>> +
>> +static void __exit omap_usb_phy_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&omap_usb_phy_driver);
>> +}
>> +module_exit(omap_usb_phy_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP4+ USB-phy driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform: omap4-usb-phy");
>> +MODULE_AUTHOR("Texas Instrument Inc.");
>> diff --git a/include/linux/usb/omap4_usb_phy.h b/include/linux/usb/o=
map4_usb_phy.h
>> new file mode 100644
>> index 0000000..b6a4701
>> --- /dev/null
>> +++ b/include/linux/usb/omap4_usb_phy.h
>> @@ -0,0 +1,53 @@
>> +/*
>> + * OMAP4 USB-phy
>> + *
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.t=
i.com/
>> + *
>> + * Contact:
>> + * =A0 =A0Kishon Vijay Abraham I <kishon@ti.com>
>> + * =A0 =A0Eduardo Valentin <eduardo.valentin@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#ifndef __OMAP4_USB_PHY_H
>> +#define __OMAP4_USB_PHY_H
>> +
>> +#define =A0 =A0 =A0PHY_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x1
>> +#define =A0 =A0 =A0AVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0BIT(0)
>> +#define =A0 =A0 =A0BVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0BIT(1)
>> +#define =A0 =A0 =A0VBUSVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 BIT(2)
>> +#define =A0 =A0 =A0SESSEND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 BIT(3)
>> +#define =A0 =A0 =A0IDDIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BIT(4)
>> +#define =A0 =A0 =A0CONTROL_DEV_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x00000300
>> +#define =A0 =A0 =A0CONTROL_USBOTGHS_CONTROL =A0 =A0 =A0 =A00x000003=
3C
>> +
>> +/* USB-PHY helpers */
>> +#if (defined(CONFIG_OMAP4_USB_PHY)) || (defined(CONFIG_OMAP4_USB_PH=
Y_MODULE))
>> +extern int omap4_usb_phy_mailbox(struct device *dev, u32 val);
>> +extern int omap4_usb_phy_power(struct device *dev, int on);
>> +#else
>> +static inline int omap4_usb_phy_mailbox(struct device *dev, u32 val=
)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +static inline int omap4_usb_phy_power(struct device *dev, int on)
>> +{
>> + =A0 =A0 return 0;
>> +}
>> +#endif
>> +
>> +#endif
>> --
>> 1.7.7.6
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
