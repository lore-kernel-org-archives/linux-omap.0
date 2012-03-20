From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 13:02:58 +0530
Message-ID: <CAP05o4Kw+si-CVK57WS_zFNf7PZdmM8qQe4QUktu689qEcGEOw@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:59696 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757688Ab2CTHkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 03:40:16 -0400
Received: by mail-iy0-f177.google.com with SMTP id y10so13317002iak.8
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 00:40:15 -0700 (PDT)
In-Reply-To: <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, balbi@ti.com
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-omap@vger.kernel.org

On Mon, Mar 19, 2012 at 12:18 PM, Keshava Munegowda
<keshava_mgowda@ti.com> wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>
> The platform driver for the TLL component of the OMAP USB host contro=
ller
> is implemented. Depending on the TLL hardware revision , the TLL chan=
nels
> are configured. The USB HS core driver uses this driver through expor=
ted
> APIs from the TLL platform driver.
> usb_tll_enable and usb_tll_disble are the exported APIs of the USB TL=
L
> platform driver.
>
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A08 +
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +-
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
> =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 +++++++=
++++++++++++++++++++++++++
> =A04 files changed, 473 insertions(+), 2 deletions(-)
> =A0create mode 100644 drivers/mfd/omap-usb-tll.c
>
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-om=
ap/include/plat/usb.h
> index dc864b5..eb1e47d 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -61,6 +61,10 @@ struct usbhs_omap_platform_data {
> =A0 =A0 =A0 =A0struct ehci_hcd_omap_platform_data =A0 =A0 =A0*ehci_da=
ta;
> =A0 =A0 =A0 =A0struct ohci_hcd_omap_platform_data =A0 =A0 =A0*ohci_da=
ta;
> =A0};
> +
> +struct usbtll_omap_platform_data {
> + =A0 =A0 =A0 enum usbhs_omap_port_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 p=
ort_mode[OMAP3_HS_USB_PORTS];
> +};
> =A0/*----------------------------------------------------------------=
---------*/
>
> =A0#define OMAP1_OTG_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfffb0400
> @@ -105,6 +109,10 @@ extern int omap4430_phy_set_clk(struct device *d=
ev, int on);
> =A0extern int omap4430_phy_init(struct device *dev);
> =A0extern int omap4430_phy_exit(struct device *dev);
> =A0extern int omap4430_phy_suspend(struct device *dev, int suspend);
> +
> +extern int omap_tll_enable(void);
> +extern int omap_tll_disable(void);
> +
> =A0#endif
>
> =A0extern void am35x_musb_reset(void);
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f147395..5f75ad4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -772,7 +772,7 @@ config MFD_WL1273_CORE
> =A0 =A0 =A0 =A0 =A0audio codec.
>
> =A0config MFD_OMAP_USB_HOST
> - =A0 =A0 =A0 bool "Support OMAP USBHS core driver"
> + =A0 =A0 =A0 bool "Support OMAP USBHS core and TLL driver"
> =A0 =A0 =A0 =A0depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b953bab..4b3a8e0 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -105,7 +105,7 @@ obj-$(CONFIG_MFD_TPS6586X) =A0+=3D tps6586x.o
> =A0obj-$(CONFIG_MFD_VX855) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D vx855.=
o
> =A0obj-$(CONFIG_MFD_WL1273_CORE) =A0+=3D wl1273-core.o
> =A0obj-$(CONFIG_MFD_CS5535) =A0 =A0 =A0 +=3D cs5535-mfd.o
> -obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0 =A0+=3D omap-usb-host.o
> +obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0 =A0+=3D omap-usb-host.o =
omap-usb-tll.o
> =A0obj-$(CONFIG_MFD_PM8921_CORE) =A0+=3D pm8921-core.o
> =A0obj-$(CONFIG_MFD_PM8XXX_IRQ) =A0 +=3D pm8xxx-irq.o
> =A0obj-$(CONFIG_TPS65911_COMPARATOR) =A0 =A0 =A0+=3D tps65911-compara=
tor.o
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> new file mode 100644
> index 0000000..3da468a
> --- /dev/null
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -0,0 +1,463 @@
> +/**
> + * omap-usb-tll.c - The USB TLL driver for OMAP EHCI & OHCI
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom
> + * Author: Keshava Munegowda <keshava_mgowda@ti.com>
> + *
> + * This program is free software: you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 =A0=
of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. =A0If not, see <http://www.gnu.org/licen=
ses/>.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <plat/usb.h>
> +#include <linux/pm_runtime.h>
> +
> +#define USBTLL_DRIVER_NAME =A0 =A0 "usbhs_tll"
> +
> +/* TLL Register Set */
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x10)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_CACTIVITY =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 8)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SIDLEMODE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 3)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_ENAWAKEUP =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 2)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SOFTRESET =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 1)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_AUTOIDLE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x14)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS_RESETDONE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 0)
> +
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x18)
> +#define =A0 =A0 =A0 =A0OMAP_USBTLL_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1C)
> +
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 6)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 5)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_DIVRATION =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 2)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_REQ =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (1 << 1)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_IS_ON =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 0)
> +
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x040 + 0x004 * num)
> +#define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT =A0 =A0 =A0 =A0 =A0 24
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 11)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE =A0 =A0=
 =A0 =A0 (1 << 10)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 9)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 8)
> +#define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS =A0 =A0 =A0 =A0 =A0 =A0(=
1 << 1)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_CHANEN =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +
> +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x0
> +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x1
> +#define OMAP_TLL_FSLSMODE_3PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x2
> +#define OMAP_TLL_FSLSMODE_4PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x3
> +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x4
> +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x5
> +#define OMAP_TLL_FSLSMODE_3PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x6
> +#define OMAP_TLL_FSLSMODE_4PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x7
> +#define OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 =A0 0=
xA
> +#define OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0xB
> +
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_FUNCTION_CTRL(num) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x804 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INTERFACE_CTRL(num) =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (0x807 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_OTG_CTRL(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (0x80A + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_RISE(num) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x80D + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_FALL(num) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x810 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_STATUS(num) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (0x813 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_INT_LATCH(num) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0x814 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_DEBUG(num) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(0x815 + 0x100 * num)
> +#define =A0 =A0 =A0 =A0OMAP_TLL_ULPI_SCRATCH_REGISTER(num) =A0 =A0 =A0=
 =A0 =A0 =A0 (0x816 + 0x100 * num)
> +
> +#define OMAP_REV2_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A02
> +#define OMAP_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 3
> +#define OMAP_TLL_CHANNEL_1_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 0)
> +#define OMAP_TLL_CHANNEL_2_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 1)
> +#define OMAP_TLL_CHANNEL_3_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << 2)
> +
> +/* Values of USBTLL_REVISION - Note: these are not given in the TRM =
*/
> +#define OMAP_USBTLL_REV1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000015 =A0 =
=A0 =A0/* OMAP3 */
> +#define OMAP_USBTLL_REV2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000004 =A0 =
=A0 =A0/* OMAP4 */
> +
> +#define is_ehci_tll_mode(x) =A0 =A0(x =3D=3D OMAP_EHCI_PORT_MODE_TLL=
)
> +
> +struct usbtll_omap {
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0*usbtll_p1_fck;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0*usbtll_p2_fck;
> + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0platdat=
a;
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0lock;
> +};
> +
> +/*------------------------------------------------------------------=
-------*/
> +
> +const char usbtll_driver_name[] =3D USBTLL_DRIVER_NAME;
> +struct platform_device *tll_pdev;
> +
> +/*------------------------------------------------------------------=
-------*/
> +
> +static inline void usbtll_write(void __iomem *base, u32 reg, u32 val=
)
> +{
> + =A0 =A0 =A0 __raw_writel(val, base + reg);
> +}
> +
> +static inline u32 usbtll_read(void __iomem *base, u32 reg)
> +{
> + =A0 =A0 =A0 return __raw_readl(base + reg);
> +}
> +
> +static inline void usbtll_writeb(void __iomem *base, u8 reg, u8 val)
> +{
> + =A0 =A0 =A0 __raw_writeb(val, base + reg);
> +}
> +
> +static inline u8 usbtll_readb(void __iomem *base, u8 reg)
> +{
> + =A0 =A0 =A0 return __raw_readb(base + reg);
> +}
> +
> +/*------------------------------------------------------------------=
-------*/
> +
> +static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
> +{
> + =A0 =A0 =A0 switch (pmode) {
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 }
> +}
> +
> +/*
> + * convert the port-mode enum to a value we can use in the FSLSMODE
> + * field of USBTLL_CHANNEL_CONF
> + */
> +static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
> +{
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case OMAP_USBHS_PORT_MODE_UNUSED:
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_S=
E0;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM=
;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_3PIN_PHY;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_4PIN_PHY;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_S=
E0;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM=
;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_3PIN_TLL;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_4PIN_TLL;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_S=
E0;
> +
> + =A0 =A0 =A0 case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM=
;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Invalid port mode, using de=
fault\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_S=
E0;
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * usbtll_omap_probe - initialize TI-based HCDs
> + *
> + * Allocates basic resources for this USB host controller.
> + */
> +static int __devinit usbtll_omap_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *dev =3D =A0&pdev->dev;
> + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D dev->platform_data;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 *res;
> + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0reg;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 i, ver, count;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
> +
> + =A0 =A0 =A0 tll =3D kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL)=
;
> + =A0 =A0 =A0 if (!tll) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory allocation failed\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_init(&tll->lock);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < OMAP3_HS_USB_PORTS; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tll->platdata.port_mode[i] =3D pdata->p=
ort_mode[i];
> +
> + =A0 =A0 =A0 tll->usbtll_p1_fck =3D clk_get(dev, "usb_tll_hs_usb_ch0=
_clk");
> + =A0 =A0 =A0 if (IS_ERR(tll->usbtll_p1_fck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tll->usbtll_p1_fck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p1_fck failed erro=
r:%d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tll->usbtll_p2_fck =3D clk_get(dev, "usb_tll_hs_usb_ch1=
_clk");
> + =A0 =A0 =A0 if (IS_ERR(tll->usbtll_p2_fck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(tll->usbtll_p2_fck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usbtll_p2_fck failed erro=
r:%d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p1_fck;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "usb tll get resource fail=
ed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 base =3D ioremap(res->start, resource_size(res));
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL ioremap failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_usbtll_p2_fck;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, tll);
> + =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 pm_runtime_get_sync(dev);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> +
> + =A0 =A0 =A0 ver =3D =A0usbtll_read(base, OMAP_USBTLL_REVISION);
> + =A0 =A0 =A0 if (ver =3D=3D OMAP_USBTLL_REV1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_TLL_CHANNEL_COUNT;
> + =A0 =A0 =A0 else if (ver =3D=3D OMAP_USBTLL_REV2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL version failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_ehci_tll_mode(pdata->port_mode[1]) |=
|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_ehci_tll_mode(pdata->port_mode[2]) |=
|
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[0])) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[1])) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (is_ohci_port(pdata->port_mode[2]))) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Program Common TLL register */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D usbtll_read(base, OMAP_TLL_SHAR=
ED_CONF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP_TLL_SHARED_CONF_FCLK_IS_=
ON
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_TLL_SHARED_CONF_=
USB_DIVRATION);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_TLL_SHARED_CONF_USB_90D_=
DDR_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_TLL_SHARED_CONF_USB_180D=
_SDR_EN;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_write(base, OMAP_TLL_SHARED_CONF=
, reg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable channels now */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D usbtll_read(bas=
e, OMAP_TLL_CHANNEL_CONF(i));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_ohci_port(pdata-=
>port_mode[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D=
 ohci_omap3_fslsmode(pdata->port_mode[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 << OMAP=
_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D=
 OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->port_mode[i]=
 =3D=3D OMAP_EHCI_PORT_MODE_TLL) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Di=
sable AutoIdle, BitStuffing
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* an=
d use SDR Mode
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D=
 ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP_TLL_CHANN=
EL_CONF_CHANEN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_write(base, OMAP=
_TLL_CHANNEL_CONF(i), reg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbtll_writeb(base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TL=
L_ULPI_SCRATCH_REGISTER(i), 0xbe);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> +err_ioremap:
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> + =A0 =A0 =A0 iounmap(base);
> + =A0 =A0 =A0 pm_runtime_put_sync(dev);
> + =A0 =A0 =A0 tll_pdev =3D pdev;
> + =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> + =A0 =A0 =A0 pm_runtime_disable(dev);
> +
> +err_usbtll_p2_fck:
> + =A0 =A0 =A0 clk_put(tll->usbtll_p2_fck);
> +
> +err_usbtll_p1_fck:
> + =A0 =A0 =A0 clk_put(tll->usbtll_p1_fck);
> +
> +err_tll:
> + =A0 =A0 =A0 kfree(tll);
> +
> +end:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
> + * @pdev: USB Host Controller being removed
> + *
> + * Reverses the effect of usbtll_omap_probe().
> + */
> +static int __devexit usbtll_omap_remove(struct platform_device *pdev=
)
> +{
> + =A0 =A0 =A0 struct usbtll_omap *tll =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 clk_put(tll->usbtll_p2_fck);
> + =A0 =A0 =A0 clk_put(tll->usbtll_p1_fck);
> + =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
> + =A0 =A0 =A0 kfree(tll);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int usbtll_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D &tll->platdata;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "usbtll_runtime_resume\n");
> +
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> +
> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p1_fck);
> +
> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p2_fck);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int usbtll_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*tll =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =
=3D &tll->platdata;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 flags;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "usbtll_runtime_suspend\n");
> +
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
> +
> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p1_fck);
> +
> + =A0 =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p2_fck);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
> + =A0 =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbtll_runtime_susp=
end,
> + =A0 =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbtll_runtime_resu=
me,
> +};
> +
> +static struct platform_driver usbtll_omap_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D (char *)u=
sbtll_driver_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODU=
LE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &usbtll=
omap_dev_pm_ops,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(usbtll_omap_remove=
),
> +};
> +
> +int omap_tll_enable(void)
> +{
> + =A0 =A0 =A0 if (!tll_pdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platfo=
rm_data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return pm_runtime_get_sync(&tll_pdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(omap_tll_enable);
> +
> +int omap_tll_disable(void)
> +{
> + =A0 =A0 =A0 if (!tll_pdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&tll_pdev->dev, "missing platfo=
rm_data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return pm_runtime_put_sync(&tll_pdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(omap_tll_disable);
> +
> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI control=
lers");
> +
> +static int __init omap_usbtll_drvinit(void)
> +{
> + =A0 =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtl=
l_omap_probe);
> +}
> +
> +/*
> + * init before usbhs core driver;
> + * The usbtll driver should be initialized before
> + * the usbhs core driver probe function is called.
> + */
> +fs_initcall(omap_usbtll_drvinit);

Hi Felipe

          do you have any comment here?
The TLL driver uses fs_initcall
and the UHH uses fs_initcall_sync

Intension of using this is , TLL driver should be initialized before UH=
H.


regards
keshava



> +
> +static void __exit omap_usbtll_drvexit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&usbtll_omap_driver);
> +}
> +module_exit(omap_usbtll_drvexit);
> --
> 1.6.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
