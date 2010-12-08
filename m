From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/7] usb: otg: Adding twl6030-usb transceiver driver for
Date: Wed, 8 Dec 2010 16:09:34 +0530
Message-ID: <AANLkTikGmt9ULEOOH8wDbi+7NryBbb-=nGuv9zFXjE-J@mail.gmail.com>
References: <1291824075-7060-1-git-send-email-hemahk@ti.com>
	<20101208095053.GF2891@legolas.emea.dhcp.ti.com>
	<AANLkTimTNiry5nNb+OvegLEkq2LmBuyfQ3DjfeC-5q1E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimTNiry5nNb+OvegLEkq2LmBuyfQ3DjfeC-5q1E-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 3:53 PM, Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org> wrote:
> On Wed, Dec 8, 2010 at 3:20 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> On Wed, Dec 08, 2010 at 09:31:15PM +0530, Hema HK wrote:
>>>
>>> Adding the twl6030-usb transceiver support for OMAP4 musb driver.
>>>
>>> OMAP4 supports 2 types of transceiver interface.
>>>
>>> 1. UTMI: The PHY is embedded within OMAP4. The transceiver function=
ality
>>> is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID p=
in
>>> sensing and OTG SRP generation part is integrated in TWL6030 and UT=
MI PHY
>>> functionality is embedded within the OMAP4430.
>>>
>>> There is no direct interactions between the MUSB controller and TWL=
6030
>>> chip to communicate the session-valid, session-end and ID-GND event=
s.
>>> It has to be done through a software by setting/resetting bits in
>>> one of the control module register of OMAP4430 which in turn toggle=
s
>>> the appropriate signals to MUSB controller.
>>>
>>> The internal transceiver has functional clocks and
>>> powerdown bits to powerdown the PHY for power saving.
>>>
>>> Since there is no option available for having 2 transceiver drivers
>>> for one USB controller, internal PHY specific APIs are passed throu=
gh
>>> plaform_data function pointers to use in the twl6030-usb transceive=
r
>>> driver.
>>>
>>> 2. ULPI interface is provided for off-chip transceivers.
>>>
>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>>> ---
>>> arch/arm/mach-omap2/omap_phy_internal.c | =A0133 ++++++++
>>> arch/arm/plat-omap/include/plat/usb.h =A0 | =A0 =A04
>>> drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01
>>> drivers/usb/otg/twl6030-usb.c =A0 =A0 =A0 =A0 =A0 | =A0514
>>> ++++++++++++++++++++++++++++++++
>>> 4 files changed, 652 insertions(+)
>>>
>>> Index: linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- /dev/null
>>> +++ linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
>>> @@ -0,0 +1,148 @@
>>> +/*
>>> + =A0* This file configures the internal USB PHY in OMAP4430. Used
>>> + =A0* with TWL6030 transceiver and MUSB on OMAP4430.
>>> + =A0*
>>> + =A0* Copyright (C) 2010 Texas Instruments Incorporated - http://w=
ww.ti.com
>>> + =A0* This program is free software; you can redistribute it and/o=
r modify
>>> + =A0* it under the terms of the GNU General Public License as publ=
ished by
>>> + =A0* the Free Software Foundation; either version 2 of the Licens=
e, or
>>> + =A0* (at your option) any later version.
>>> + =A0*
>>> + =A0*Author: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>
>> =A0 =A0^^ you need a space after *
> OK.
>>
>>> + =A0* This program is distributed in the hope that it will be usef=
ul,
>>> + =A0* but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>>> + =A0* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See =
the
>>> + =A0* GNU General Public License for more details.
>>> + =A0*
>>> + =A0* You should have received a copy of the GNU General Public Li=
cense
>>> + =A0* along with this program; if not, write to the Free Software
>>> + =A0* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>> + =A0*
>>> + =A0*/
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/err.h>
>>> +#include <linux/usb.h>
>>> +
>>> +#include <plat/usb.h>
>>> +
>>> +/* OMAP control module register for UTMI PHY */
>>> +#define CONTROL_DEV_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x300
>>> +#define PHY_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>> +
>>> +#define USBOTGHS_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x33c
>>> +#define =A0 =A0 =A0 =A0AVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0BIT(0)
>>> +#define =A0 =A0 =A0 =A0BVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0BIT(1)
>>> +#define =A0 =A0 =A0 =A0VBUSVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BIT(2)
>>> +#define =A0 =A0 =A0 =A0SESSEND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 BIT(3)
>>> +#define =A0 =A0 =A0 =A0IDDIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 BIT(4)
>>> +
>>> +static struct clk *phyclk, *clk48m, *clk32k;
>>> +static void __iomem *ctrl_base;
>>> +
>>> +int omap4430_phy_init(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 ctrl_base =3D ioremap(OMAP443X_SCM_BASE, SZ_1K);
>>> + =A0 =A0 =A0 if (!ctrl_base) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "control module ioremap =
failed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 /* Power down the phy */
>>> + =A0 =A0 =A0 __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>>> + =A0 =A0 =A0 phyclk =3D clk_get(dev, "ocp2scp_usb_phy_ick");
>>> +
>>> + =A0 =A0 =A0 if (IS_ERR(phyclk)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cannot clk_get ocp2scp_=
usb_phy_ick\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(ctrl_base);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(phyclk);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 clk48m =3D clk_get(dev, "ocp2scp_usb_phy_phy_48m");
>>> + =A0 =A0 =A0 if (IS_ERR(clk48m)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cannot clk_get ocp2scp_=
usb_phy_phy_48m\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(phyclk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(ctrl_base);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(clk48m);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 clk32k =3D clk_get(dev, "usb_phy_cm_clk32k");
>>> + =A0 =A0 =A0 if (IS_ERR(clk32k)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cannot clk_get usb_phy_=
cm_clk32k\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(phyclk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(clk48m);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(ctrl_base);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(clk32k);
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +int omap4430_phy_set_clk(struct device *dev, int on)
>>> +{
>>> + =A0 =A0 =A0 static int state;
>>> +
>>> + =A0 =A0 =A0 if (on && !state) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the phy clocks */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(phyclk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk48m);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk32k);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D 1;
>>> + =A0 =A0 =A0 } else if (state) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable the phy clocks */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(phyclk);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(clk48m);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(clk32k);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D 0;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +int omap4430_phy_power(struct device *dev, int ID, int on)
>>> +{
>>> + =A0 =A0 =A0 if (on) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enabled the clocks */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4430_phy_set_clk(dev, 1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* power on the phy */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__raw_readl(ctrl_base + CONTROL_D=
EV_CONF) & PHY_PD) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(~PHY_PD,=
 ctrl_base +
>>> CONTROL_DEV_CONF);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(200);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ID)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable VBUS valid,=
 IDDIG groung */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(AVALID |=
 VBUSVALID, ctrl_base +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USBOTGHS_CONTROL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable VBUS Vali=
d, AValid and IDDIG
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* high impedence
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(IDDIG | =
AVALID | VBUSVALID,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_base +
>>> USBOTGHS_CONTROL);
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable session END and IDIG to hig=
h impedence. */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(SESSEND | IDDIG, ctrl_ba=
se +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 USBOTGHS_CONTROL);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable the clocks */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4430_phy_set_clk(dev, 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Power down the phy */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(PHY_PD, ctrl_base + CONT=
ROL_DEV_CONF);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +int omap4430_phy_exit(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 if (ctrl_base)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(ctrl_base);
>>> + =A0 =A0 =A0 if (phyclk)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(phyclk);
>>> + =A0 =A0 =A0 if (clk48m)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(clk48m);
>>> + =A0 =A0 =A0 if (clk32k)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(clk32k);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +
>>
>> two blank lines at the end of file. I like to use one, but people sa=
y it
>> should be none :-p
> Fine. I will remove the blank lines.
>>
>> Anyway, can this be converted into a platform driver ? Then you coul=
d
>> power it on/off with pm_runtime ?!? You wouldn't need to export
>> functions either.
>>
>> It could be that's not possible, but doesn't hurt asking.
>
> pm_runime will take care of this as there is no device build done for=
 PHY.
I mean pm_runime will not take care of this as there is no device
build done for PHY.
> This device does not have any IRQs or sysconfig registers.
> This device has only 2 clocks associated with it and that too these a=
re
> considered as optional clocks.
> So using it is decided to use the clock framework for this device.
>
>>
>>> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
>>> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>>> @@ -79,6 +79,12 @@ extern void usb_ehci_init(const struct e
>>>
>>> extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data
>>> *pdata);
>>>
>>> +extern int omap4430_phy_power(struct device *dev, int ID, int on);
>>> +extern int omap4430_phy_set_clk(struct device *dev, int on);
>>> +extern int omap4430_phy_init(struct device *dev);
>>> +extern int omap4430_phy_exit(struct device *dev);
>>> +
>>> +
>>
>> one blank line only.
> OK.
>>
>>> Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- /dev/null
>>> +++ linux-2.6/drivers/usb/otg/twl6030-usb.c
>>> @@ -0,0 +1,520 @@
>>> +/*
>>> + * twl6030_usb - TWL6030 USB transceiver, talking to OMAP OTG driv=
er.
>>> + *
>>> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.=
ti.com
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License as publish=
ed by
>>> + * the Free Software Foundation; either version 2 of the License, =
or
>>> + * (at your option) any later version.
>>> + *
>>> + *Author: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>
>> =A0 ^^ space
> OK.
>>
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public Licen=
se
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>> + *
>>> + *
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/io.h>
>>> +#include <linux/usb/otg.h>
>>> +#include <linux/i2c/twl.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/err.h>
>>> +#include <linux/notifier.h>
>>> +#include <linux/slab.h>
>>> +
>>> +/* usb register definitions */
>>> +#define USB_VENDOR_ID_LSB =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
>>> +#define USB_VENDOR_ID_MSB =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
>>> +#define USB_PRODUCT_ID_LSB =A0 =A0 =A0 =A0 =A0 =A0 0x02
>>> +#define USB_PRODUCT_ID_MSB =A0 =A0 =A0 =A0 =A0 =A0 0x03
>>> +#define USB_VBUS_CTRL_SET =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
>>> +#define USB_VBUS_CTRL_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A00x05
>>> +#define USB_ID_CTRL_SET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x06
>>> +#define USB_ID_CTRL_CLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x07
>>> +#define USB_VBUS_INT_SRC =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x08
>>> +#define USB_VBUS_INT_LATCH_SET =A0 =A0 =A0 =A0 0x09
>>> +#define USB_VBUS_INT_LATCH_CLR =A0 =A0 =A0 =A0 0x0A
>>> +#define USB_VBUS_INT_EN_LO_SET =A0 =A0 =A0 =A0 0x0B
>>> +#define USB_VBUS_INT_EN_LO_CLR =A0 =A0 =A0 =A0 0x0C
>>> +#define USB_VBUS_INT_EN_HI_SET =A0 =A0 =A0 =A0 0x0D
>>> +#define USB_VBUS_INT_EN_HI_CLR =A0 =A0 =A0 =A0 0x0E
>>> +#define USB_ID_INT_SRC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0F
>>> +#define USB_ID_INT_LATCH_SET =A0 =A0 =A0 =A0 =A0 0x10
>>> +#define USB_ID_INT_LATCH_CLR =A0 =A0 =A0 =A0 =A0 0x11
>>> +
>>> +
>>> +#define USB_ID_INT_EN_LO_SET =A0 =A0 =A0 =A0 =A0 0x12
>>> +#define USB_ID_INT_EN_LO_CLR =A0 =A0 =A0 =A0 =A0 0x13
>>> +#define USB_ID_INT_EN_HI_SET =A0 =A0 =A0 =A0 =A0 0x14
>>> +#define USB_ID_INT_EN_HI_CLR =A0 =A0 =A0 =A0 =A0 0x15
>>
>> I wonder why HW people didn't follow ULPI spec here. What a mess...
>>
>>> +#define USB_OTG_ADP_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x16
>>> +#define USB_OTG_ADP_HIGH =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x17
>>> +#define USB_OTG_ADP_LOW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x18
>>> +#define USB_OTG_ADP_RISE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x19
>>> +#define USB_OTG_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1A
>>
>> ... then these would only be a set of extended registers.
Yes. Some of these registers are not used now. But required when
OTG2.0 support is provided.

>>
>>> +/* to be moved to LDO */
>>> +#define MISC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
xE5
>>> +#define CFG_LDO_PD2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xF5
>>
>> prepend with USB_
> OK.
These are not the USB_OTG registers under in TWL6030
Ideally would bedefined in twl.h. I think i will move these to twl.h fi=
le.
>>
>>> +#define USB_BACKUP_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xFA
>>> +
>>> +#define STS_HW_CONDITIONS =A0 =A0 =A0 =A0 =A0 =A0 =A00x21
>>> +
>>> +/* In module TWL6030_MODULE_PM_MASTER */
>>> +#define PROTECT_KEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0E
>>
>> defined in <linux/i2c/twl.h>

OK. I will remove from here.

>>
>>> +#define STS_HW_CONDITIONS =A0 =A0 =A0 =A0 =A0 =A0 =A00x21
>>> +#define STS_USB_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
>>> +
>>> +/* In module TWL6030_MODULE_PM_RECEIVER */
>>> +#define VUSB_DEDICATED1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x7D
>>> +#define VUSB_DEDICATED2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x7E
>>> +#define VUSB1V5_DEV_GRP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x71
>>> +#define VUSB1V5_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x72
>>> +#define VUSB1V5_REMAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x73
>>> +#define VUSB1V8_DEV_GRP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x74
>>> +#define VUSB1V8_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x75
>>> +#define VUSB1V8_REMAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x76
>>> +#define VUSB3V1_DEV_GRP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x77
>>> +#define VUSB3V1_TYPE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x78
>>> +#define VUSB3V1_REMAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x79
>>> +
>>> +/* In module TWL6030_MODULE_PM_RECEIVER */
>>> +#define VUSB_CFG_TRANS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x71
>>> +#define VUSB_CFG_STATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x72
>>> +#define VUSB_CFG_VOLTAGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x73
>>> +
>>> +/* in module TWL6030_MODULE_MAIN_CHARGE */
>>> +
>>> +#define CHARGERUSB_CTRL1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x8
>>> +
>>> +#define CONTROLLER_STAT1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03
>>> +#define =A0 =A0 =A0 =A0VBUS_DET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0BIT(2)
>>> +
>>> +
>>> +/* OMAP control module register for UTMI PHY */
>>> +#define ONTROL_DEV_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x300
>>
>> did you mean CONTROL ??
>
> I need to remove this from this file as these are not used here.
>>
>>> +#define PHY_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>> +
>>> +#define USBOTGHS_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x33c
>>> +#define =A0 =A0 =A0 =A0AVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0BIT(0)
>>> +#define =A0 =A0 =A0 =A0BVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0BIT(1)
>>> +#define =A0 =A0 =A0 =A0VBUSVALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BIT(2)
>>> +#define =A0 =A0 =A0 =A0SESSEND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 BIT(3)
>>> +#define =A0 =A0 =A0 =A0IDDIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 BIT(4)
>>
>> these are likely to give namespace colision at some point, append wi=
th
>> USB_ or better change USB_ to TWL6030_USB_
>
> These are not required so i will remove them.
>>
>>> +static int __devinit twl6030_usb_probe(struct platform_device *pde=
v)
>>> +{
>>> + =A0 =A0 =A0 struct twl6030_usb =A0 =A0 =A0*twl;
>>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status, e=
rr;
>>> + =A0 =A0 =A0 struct twl4030_usb_data *pdata;
>>> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>>> + =A0 =A0 =A0 pdata =3D dev->platform_data;
>>> +
>>> + =A0 =A0 =A0 twl =3D kzalloc(sizeof *twl, GFP_KERNEL);
>>> + =A0 =A0 =A0 if (!twl)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>> +
>>> + =A0 =A0 =A0 twl->dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &pdev->de=
v;
>>> + =A0 =A0 =A0 twl->irq1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D platform_ge=
t_irq(pdev, 0);
>>> + =A0 =A0 =A0 twl->irq2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D platform_ge=
t_irq(pdev, 1);
>>> + =A0 =A0 =A0 twl->otg.dev =A0 =A0 =A0 =A0 =A0 =A0=3D twl->dev;
>>> + =A0 =A0 =A0 twl->otg.label =A0 =A0 =A0 =A0 =A0=3D "twl6030";
>>> + =A0 =A0 =A0 twl->otg.set_host =A0 =A0 =A0 =3D twl6030_set_host;
>>> + =A0 =A0 =A0 twl->otg.set_peripheral =3D twl6030_set_peripheral;
>>> + =A0 =A0 =A0 twl->asleep =A0 =A0 =A0 =A0 =A0 =A0 =3D 1;
>>
>> better to read this from HW and avoid problems if bootloaders wakes =
this
>> one up.
> I don'e need this anymore.
>>
>> --
>> balbi
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
