From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [RFC PATCH 07/11] mfd: omap: control: usb-phy: introduce the
 ctrl-module usb driver
Date: Fri, 25 May 2012 19:05:28 +0530
Message-ID: <CAM=Q2cviCqTLoPKeNrtMbJaiOKxovAM4KMw+jrsg0qWNsYm63w@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52995 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab2EYNfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 09:35:30 -0400
Received: by lbbgm6 with SMTP id gm6so639915lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 06:35:29 -0700 (PDT)
In-Reply-To: <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

Hi Edurardo,
A few doubts,

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Created a new platform driver for the platform device created by the
> control module mfd core, wrt usb. This driver has API's to power on/o=
ff
> the phy and the API's to write to musb mailbox.
>
> (p.s. the mailbox for musb in omap4 is present in system control
> module)
>
> [kishon@ti.com: wrote the original API's related to USB functions]
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> =A0drivers/usb/otg/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 13 ++++
> =A0drivers/usb/otg/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/otg/omap4-usb-phy.c =A0 | =A0130 +++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/usb/omap4_usb_phy.h | =A0 53 +++++++++++++++
> =A04 files changed, 197 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/otg/omap4-usb-phy.c
> =A0create mode 100644 include/linux/usb/omap4_usb_phy.h
>
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 5c87db0..e2840f1 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -78,6 +78,19 @@ config TWL6030_USB
> =A0 =A0 =A0 =A0 =A0are hooked to this driver through platform_data st=
ructure.
> =A0 =A0 =A0 =A0 =A0The definition of internal PHY APIs are in the mac=
h-omap2 layer.
>
> +config OMAP4_USB_PHY
> + =A0 =A0 =A0 tristate "Texas Instruments OMAP4+ USB pin control driv=
er"
> + =A0 =A0 =A0 depends on MFD_OMAP_CONTROL
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes here you get support for the Texas I=
nstruments
> + =A0 =A0 =A0 =A0 OMAP4+ USB pin control driver. The register set is =
part of system
> + =A0 =A0 =A0 =A0 control module.
> +
> + =A0 =A0 =A0 =A0 USB phy in OMAP configures control module register =
for powering on
> + =A0 =A0 =A0 =A0 the phy, configuring VBUSVALID, AVALID, IDDIG and S=
ESSEND. For
> + =A0 =A0 =A0 =A0 performing the above mentioned configuration, API's=
 are added in
> + =A0 =A0 =A0 =A0 by this children of the control module driver.
> +
> =A0config NOP_USB_XCEIV
> =A0 =A0 =A0 =A0tristate "NOP USB Transceiver Driver"
> =A0 =A0 =A0 =A0select USB_OTG_UTILS
> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index 41aa509..60c8c83 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_USB_GPIO_VBUS) =A0 +=3D gpio_vbus.o
> =A0obj-$(CONFIG_ISP1301_OMAP) =A0 =A0 +=3D isp1301_omap.o
> =A0obj-$(CONFIG_TWL4030_USB) =A0 =A0 =A0+=3D twl4030-usb.o
> =A0obj-$(CONFIG_TWL6030_USB) =A0 =A0 =A0+=3D twl6030-usb.o
> +obj-$(CONFIG_OMAP4_USB_PHY) =A0 =A0+=3D omap4-usb-phy.o
> =A0obj-$(CONFIG_NOP_USB_XCEIV) =A0 =A0+=3D nop-usb-xceiv.o
> =A0obj-$(CONFIG_USB_ULPI) =A0 =A0 =A0 =A0 +=3D ulpi.o
> =A0obj-$(CONFIG_USB_ULPI_VIEWPORT) =A0 =A0 =A0 =A0+=3D ulpi_viewport.=
o
> diff --git a/drivers/usb/otg/omap4-usb-phy.c b/drivers/usb/otg/omap4-=
usb-phy.c
> new file mode 100644
> index 0000000..a29ea45
> --- /dev/null
> +++ b/drivers/usb/otg/omap4-usb-phy.c
> @@ -0,0 +1,130 @@
> +/*
> + * OMAP4 system control module driver, USB control children
> + *
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * Contact:
> + * =A0 =A0Kishon Vijay Abraham I <kishon@ti.com>
> + * =A0 =A0Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/omap_control.h>
> +#include <linux/usb/omap4_usb_phy.h>
> +
> +/**
> + * omap4_usb_phy_power - power on/off the phy using control module r=
eg
> + * @dev: struct device *
> + * @on: 0 or 1, based on powering on or off the PHY
Could it be bool ?

> + *
> + * omap_usb2 can call this API to power on or off the PHY.
> + */
> +int omap4_usb_phy_power(struct device *dev, int on)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_control_readl(dev, CONTROL=
_DEV_CONF, &val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret && (val & PHY_PD)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_control_wr=
itel(dev, ~PHY_PD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONTROL_DEV_CONF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX: add proper docu=
mentation for this delay */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(200);
Also  does it have to be a busy one?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
