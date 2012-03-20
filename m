From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 12:01:29 +0200
Message-ID: <20120320100128.GF9157@arwen.pp.htv.fi>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
 <CAP05o4Kw+si-CVK57WS_zFNf7PZdmM8qQe4QUktu689qEcGEOw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43433 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758851Ab2CTKBs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 06:01:48 -0400
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so7641045lag.34
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 03:01:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP05o4Kw+si-CVK57WS_zFNf7PZdmM8qQe4QUktu689qEcGEOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-omap@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 01:02:58PM +0530, Munegowda, Keshava wrote:
> On Mon, Mar 19, 2012 at 12:18 PM, Keshava Munegowda
> <keshava_mgowda@ti.com> wrote:
> > From: Keshava Munegowda <Keshava_mgowda@ti.com>
> >
> > The platform driver for the TLL component of the OMAP USB host controll=
er
> > is implemented. Depending on the TLL hardware revision , the TLL channe=
ls
> > are configured. The USB HS core driver uses this driver through exported
> > APIs from the TLL platform driver.
> > usb_tll_enable and usb_tll_disble are the exported APIs of the USB TLL
> > platform driver.
> >
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > Reviewed-by: Partha Basak <parthab@india.ti.com>
> > ---
> > =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A08 +
> > =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 +++++++++=
++++++++++++++++++++++++
> > =A04 files changed, 473 insertions(+), 2 deletions(-)
> > =A0create mode 100644 drivers/mfd/omap-usb-tll.c
> >
> > diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap=
/include/plat/usb.h
> > index dc864b5..eb1e47d 100644
> > --- a/arch/arm/plat-omap/include/plat/usb.h
> > +++ b/arch/arm/plat-omap/include/plat/usb.h
> > @@ -61,6 +61,10 @@ struct usbhs_omap_platform_data {
> > =A0 =A0 =A0 =A0struct ehci_hcd_omap_platform_data =A0 =A0 =A0*ehci_data;
> > =A0 =A0 =A0 =A0struct ohci_hcd_omap_platform_data =A0 =A0 =A0*ohci_data;
> > =A0};
> > +
> > +struct usbtll_omap_platform_data {
> > + =A0 =A0 =A0 enum usbhs_omap_port_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 por=
t_mode[OMAP3_HS_USB_PORTS];
> > +};
> > =A0/*------------------------------------------------------------------=
-------*/
> >
> > =A0#define OMAP1_OTG_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfffb0400
> > @@ -105,6 +109,10 @@ extern int omap4430_phy_set_clk(struct device *dev=
, int on);
> > =A0extern int omap4430_phy_init(struct device *dev);
> > =A0extern int omap4430_phy_exit(struct device *dev);
> > =A0extern int omap4430_phy_suspend(struct device *dev, int suspend);
> > +
> > +extern int omap_tll_enable(void);
> > +extern int omap_tll_disable(void);
> > +
> > =A0#endif
> >
> > =A0extern void am35x_musb_reset(void);
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index f147395..5f75ad4 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -772,7 +772,7 @@ config MFD_WL1273_CORE
> > =A0 =A0 =A0 =A0 =A0audio codec.
> >
> > =A0config MFD_OMAP_USB_HOST
> > - =A0 =A0 =A0 bool "Support OMAP USBHS core driver"
> > + =A0 =A0 =A0 bool "Support OMAP USBHS core and TLL driver"
> > =A0 =A0 =A0 =A0depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> > =A0 =A0 =A0 =A0default y
> > =A0 =A0 =A0 =A0help
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index b953bab..4b3a8e0 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -105,7 +105,7 @@ obj-$(CONFIG_MFD_TPS6586X) =A0+=3D tps6586x.o
> > =A0obj-$(CONFIG_MFD_VX855) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D vx855.o
> > =A0obj-$(CONFIG_MFD_WL1273_CORE) =A0+=3D wl1273-core.o
> > =A0obj-$(CONFIG_MFD_CS5535) =A0 =A0 =A0 +=3D cs5535-mfd.o
> > -obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0 =A0+=3D omap-usb-host.o
> > +obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0 =A0+=3D omap-usb-host.o om=
ap-usb-tll.o
> > =A0obj-$(CONFIG_MFD_PM8921_CORE) =A0+=3D pm8921-core.o
> > =A0obj-$(CONFIG_MFD_PM8XXX_IRQ) =A0 +=3D pm8xxx-irq.o
> > =A0obj-$(CONFIG_TPS65911_COMPARATOR) =A0 =A0 =A0+=3D tps65911-comparato=
r.o
> > diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> > new file mode 100644
> > index 0000000..3da468a
> > --- /dev/null
> > +++ b/drivers/mfd/omap-usb-tll.c
> > @@ -0,0 +1,463 @@
> > +/**
> > + * omap-usb-tll.c - The USB TLL driver for OMAP EHCI & OHCI
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.c=
om
> > + * Author: Keshava Munegowda <keshava_mgowda@ti.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 =A0of
> > + * the License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program. =A0If not, see <http://www.gnu.org/license=
s/>.
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <plat/usb.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#define USBTLL_DRIVER_NAME =A0 =A0 "usbhs_tll"
> > +
> > +/* TLL Register Set */
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_CACTIVITY =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 8)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SIDLEMODE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 3)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_ENAWAKEUP =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 2)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SOFTRESET =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 1)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_AUTOIDLE =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 0)
> > +
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x14)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS_RESETDONE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 0)
> > +
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x18)
> > +#define =A0 =A0 =A0 =A0OMAP_USBTLL_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1C)
> > +
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 6)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 5)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_DIVRATION =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 2)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_REQ =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 1)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_IS_ON =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 0)
> > +
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF(num) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0x040 + 0x004 * num)
> > +#define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT =A0 =A0 =A0 =A0 =A0 24
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 11)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE =A0 =A0=
 =A0 =A0 (1 << 10)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 9)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 8)
> > +#define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS =A0 =A0 =A0 =A0 =A0 =A0(1 =
<< 1)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_CHANEN =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> > +
> > +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0x0
> > +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x1
> > +#define OMAP_TLL_FSLSMODE_3PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x2
> > +#define OMAP_TLL_FSLSMODE_4PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x3
> > +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0x4
> > +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x5
> > +#define OMAP_TLL_FSLSMODE_3PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x6
> > +#define OMAP_TLL_FSLSMODE_4PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x7
> > +#define OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0xA
> > +#define OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=
xB
> > +
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_FUNCTION_CTRL(num) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x804 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INTERFACE_CTRL(num) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x807 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_OTG_CTRL(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (0x80A + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_RISE(num) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x80D + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_FALL(num) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x810 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_STATUS(num) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x813 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_LATCH(num) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0x814 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_DEBUG(num) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(0x815 + 0x100 * num)
> > +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_SCRATCH_REGISTER(num) =A0 =A0 =A0=
 =A0 =A0 =A0 (0x816 + 0x100 * num)
> > +
> > +#define OMAP_REV2_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A02
> > +#define OMAP_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 3
> > +#define OMAP_TLL_CHANNEL_1_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 0)
> > +#define OMAP_TLL_CHANNEL_2_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 1)
> > +#define OMAP_TLL_CHANNEL_3_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 2)
> > +
> > +/* Values of USBTLL_REVISION - Note: these are not given in the TRM */
> > +#define OMAP_USBTLL_REV1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000015 =A0 =
=A0 =A0/* OMAP3 */
> > +#define OMAP_USBTLL_REV2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000004 =A0 =
=A0 =A0/* OMAP4 */
> > +
> > +#define is_ehci_tll_mode(x) =A0 =A0(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
> > +
> > +struct usbtll_omap {
> > + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0*usbtll_p1_fck;
> > + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0*usbtll_p2_fck;
> > + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0platdata;
> > + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0lock;
> > +};
> > +
> > +/*--------------------------------------------------------------------=
-----*/
> > +
> > +const char usbtll_driver_name[] =3D USBTLL_DRIVER_NAME;
> > +struct platform_device *tll_pdev;
> > +
> > +/*--------------------------------------------------------------------=
-----*/
> > +
> > +static inline void usbtll_write(void __iomem *base, u32 reg, u32 val)
> > +{
> > + =A0 =A0 =A0 __raw_writel(val, base + reg);
> > +}
> > +
> > +static inline u32 usbtll_read(void __iomem *base, u32 reg)
> > +{
> > + =A0 =A0 =A0 return __raw_readl(base + reg);
> > +}
> > +
> > +static inline void usbtll_writeb(void __iomem *base, u8 reg, u8 val)
> > +{
> > + =A0 =A0 =A0 __raw_writeb(val, base + reg);
> > +}
> > +
> > +static inline u8 usbtll_readb(void __iomem *base, u8 reg)
> > +{
> > + =A0 =A0 =A0 return __raw_readb(base + reg);
> > +}
> > +
> > +/*--------------------------------------------------------------------=
-----*/
> > +
> > +static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
> > +{
> > + =A0 =A0 =A0 switch (pmode) {
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> > +
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +/*
> > + * convert the port-mode enum to a value we can use in the FSLSMODE
> > + * field of USBTLL_CHANNEL_CONF
> > + */
> > +static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
> > +{
> > + =A0 =A0 =A0 switch (mode) {
> > + =A0 =A0 =A0 case OMAP_USBHS_PORT_MODE_UNUSED:
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_3PIN_PHY;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_4PIN_PHY;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_3PIN_TLL;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_4PIN_TLL;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0;
> > +
> > + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM;
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Invalid port mode, using defa=
ult\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +/**
> > + * usbtll_omap_probe - initialize TI-based HCDs
> > + *
> > + * Allocates basic resources for this USB host controller.
> > + */
> > +static int __devinit usbtll_omap_probe(struct platform_device *pdev)
> > +{
> > + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *dev =3D =A0&pdev->dev;
> > + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D dev->platform_data;
> > + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*base;
> > + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 *res;
> > + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll;
> > + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0reg;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 ret =3D 0;
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 i, ver, count;
> > +
> > + =A0 =A0 =A0 dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
> > +
> > + =A0 =A0 =A0 tll =3D kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!tll) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory allocation failed\n"=
);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 spin_lock_init(&tll->lock);
> > +
> > + =A0 =A0 =A0 for (i =3D 0; i < OMAP3_HS_USB_PORTS; i++)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tll->platdata.port_mode[i] =3D pdata->por=
t_mode[i];
> > +
> > + =A0 =A0 =A0 tll->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_ch0_c=
lk");
> > + =A0 =A0 =A0 if (IS_ERR(tll->usbtll_p1_fck)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tll->usbtll_p1_fck);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p1_fck failed error:=
%d\n", ret);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 tll->usbtll_p2_fck =3D clk_get(dev, "usb_tll_hs_usb_ch1_c=
lk");
> > + =A0 =A0 =A0 if (IS_ERR(tll->usbtll_p2_fck)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tll->usbtll_p2_fck);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p2_fck failed error:=
%d\n", ret);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p1_fck;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + =A0 =A0 =A0 if (!res) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usb tll get resource failed=
\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 base =3D ioremap(res->start, resource_size(res));
> > + =A0 =A0 =A0 if (!base) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL ioremap failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, tll);
> > + =A0 =A0 =A0 pm_runtime_enable(dev);
> > + =A0 =A0 =A0 pm_runtime_get_sync(dev);
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> > +
> > + =A0 =A0 =A0 ver =3D =A0usbtll_read(base, OMAP_USBTLL_REVISION);
> > + =A0 =A0 =A0 if (ver =3D=3D OMAP_USBTLL_REV1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_TLL_CHANNEL_COUNT;
> > + =A0 =A0 =A0 else if (ver =3D=3D OMAP_USBTLL_REV2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
> > + =A0 =A0 =A0 else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL version failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_ehci_tll_mode(pdata->port_mode[1]) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_ehci_tll_mode(pdata->port_mode[2]) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[0])) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[1])) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[2]))) {
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Program Common TLL register */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D usbtll_read(base, OMAP_TLL_SHARED=
_CONF);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_TLL_SHARED_CONF_US=
B_DIVRATION);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_TLL_SHARED_CONF_USB_90D_DD=
R_EN;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_TLL_SHARED_CONF_USB_180D_S=
DR_EN;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_write(base, OMAP_TLL_SHARED_CONF, =
reg);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable channels now */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < count; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D usbtll_read(base,=
 OMAP_TLL_CHANNEL_CONF(i));
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ohci_port(pdata->p=
ort_mode[i])) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D =
ohci_omap3_fslsmode(pdata->port_mode[i])
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << OMAP_T=
LL_CHANNEL_CONF_FSLSMODE_SHIFT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D =
OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->port_mode[i] =
=3D=3D OMAP_EHCI_PORT_MODE_TLL) {
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Disa=
ble AutoIdle, BitStuffing
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and =
use SDR Mode
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D =
~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP_TLL_CHANNEL=
_CONF_CHANEN;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_write(base, OMAP_T=
LL_CHANNEL_CONF(i), reg);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_writeb(base,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TLL_=
ULPI_SCRATCH_REGISTER(i), 0xbe);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > +err_ioremap:
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> > + =A0 =A0 =A0 iounmap(base);
> > + =A0 =A0 =A0 pm_runtime_put_sync(dev);
> > + =A0 =A0 =A0 tll_pdev =3D pdev;
> > + =A0 =A0 =A0 if (!ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> > + =A0 =A0 =A0 pm_runtime_disable(dev);
> > +
> > +err_usbtll_p2_fck:
> > + =A0 =A0 =A0 clk_put(tll->usbtll_p2_fck);
> > +
> > +err_usbtll_p1_fck:
> > + =A0 =A0 =A0 clk_put(tll->usbtll_p1_fck);
> > +
> > +err_tll:
> > + =A0 =A0 =A0 kfree(tll);
> > +
> > +end:
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +/**
> > + * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
> > + * @pdev: USB Host Controller being removed
> > + *
> > + * Reverses the effect of usbtll_omap_probe().
> > + */
> > +static int __devexit usbtll_omap_remove(struct platform_device *pdev)
> > +{
> > + =A0 =A0 =A0 struct usbtll_omap *tll =3D platform_get_drvdata(pdev);
> > +
> > + =A0 =A0 =A0 clk_put(tll->usbtll_p2_fck);
> > + =A0 =A0 =A0 clk_put(tll->usbtll_p1_fck);
> > + =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
> > + =A0 =A0 =A0 kfree(tll);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static int usbtll_runtime_resume(struct device *dev)
> > +{
> > + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll =3D dev_get_drvdata(dev);
> > + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D &tll->platdata;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> > +
> > + =A0 =A0 =A0 dev_dbg(dev, "usbtll_runtime_resume\n");
> > +
> > + =A0 =A0 =A0 if (!pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> > +
> > + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p1_fck);
> > +
> > + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p2_fck);
> > +
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static int usbtll_runtime_suspend(struct device *dev)
> > +{
> > + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll =3D dev_get_drvdata(dev);
> > + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D &tll->platdata;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> > +
> > + =A0 =A0 =A0 dev_dbg(dev, "usbtll_runtime_suspend\n");
> > +
> > + =A0 =A0 =A0 if (!pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> > +
> > + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p1_fck);
> > +
> > + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p2_fck);
> > +
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
> > + =A0 =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbtll_runtime_suspen=
d,
> > + =A0 =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbtll_runtime_resume,
> > +};
> > +
> > +static struct platform_driver usbtll_omap_driver =3D {
> > + =A0 =A0 =A0 .driver =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D (char *)usb=
tll_driver_name,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &usbtllom=
ap_dev_pm_ops,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(usbtll_omap_remove),
> > +};
> > +
> > +int omap_tll_enable(void)
> > +{
> > + =A0 =A0 =A0 if (!tll_pdev) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platform=
_data\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return pm_runtime_get_sync(&tll_pdev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(omap_tll_enable);
> > +
> > +int omap_tll_disable(void)
> > +{
> > + =A0 =A0 =A0 if (!tll_pdev) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platform=
_data\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return pm_runtime_put_sync(&tll_pdev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(omap_tll_disable);
> > +
> > +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> > +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controlle=
rs");
> > +
> > +static int __init omap_usbtll_drvinit(void)
> > +{
> > + =A0 =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtll_=
omap_probe);
> > +}
> > +
> > +/*
> > + * init before usbhs core driver;
> > + * The usbtll driver should be initialized before
> > + * the usbhs core driver probe function is called.
> > + */
> > +fs_initcall(omap_usbtll_drvinit);
>=20
> Hi Felipe
>=20
>           do you have any comment here?
> The TLL driver uses fs_initcall
> and the UHH uses fs_initcall_sync
>=20
> Intension of using this is , TLL driver should be initialized before
> UHH.

At a first look, I don't think this trickery is necessary because UHH
uses exported symbol from TLL and modules.dep will solve that
dependency, but I'm not sure how that'll play with built-in modules, so
keep it as is (unless someone can clarify that part heh).

--=20
balbi

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaFV4AAoJEIaOsuA1yqREhuAP/03lTS3NxYIkxg+07wHUQkvg
KJ6IQWRx2MCK6WoJrunipjqu/tycy47S2J2Kzmu6jYpkBDl5abyDBczzB/+IYj0L
DKsWFUUqEqLBEyPfL3RW5KRnJsD1gSB/5ZaJM0BRRBumcszc+PUS8TZzyhTtEUpI
fTS9CJUX+6fEpGcH0Jsvf/JoWRdo+zToASqk90GZQdCF+B6uz5NLvZlgEaIgVIfq
fauj7BrWaKGmhR7TSZ4Hn9B3mCKg4oABhF7WJjEyWtYFx+yl0/aIcX1XXFXUhaCw
toXsypG9P5XrZsuSxlZsQ/scIe4Wkub07UiFNyiy1hoKI6FwrKheWFLuKTAY+Ztx
4vq+YaLrk00xslYpZMmECqR4W9kejVxs14IpDCFBJoJZ1v/QahAyGvdV79alzLb5
VgzMi8kfhhBILHu/N/OeWdeWa1ajlYcPDQ2XvgOC17ykpTUb3ST+Ys+BoYvs3rSK
UsKuKmWvHnajaLqRKLHI90hJqos80+OarFkppZH9df4xdnObZM/AL3JzAp79JbXg
TS3eqvIh55CpMzEUVKVas4CzT39On+4ShnSMfyb2haEBAPK/zpDVFE7xEPjh9oyR
a5gG3pJmpAmolq0fb5jC/jmusrcc+aQjuto6L9GMsNefjYCLhhPkhPjGimrqrZiX
6T2e7Q0wJl4pL++CfL85
=An2d
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
