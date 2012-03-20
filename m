From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 12:58:49 +0530
Message-ID: <CAP05o4+A7AZ0SmMLgCfbBHs+zhsN-c2zM8caYe8M3-OC3YmZzg@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
	<4F66FF47.7000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F66FF47.7000800-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 19, 2012 at 3:11 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wro=
te:
> Hi Keshava,
> Some doubts / comments .
> On Monday 19 March 2012 12:18 PM, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> The platform driver for the TLL component of the OMAP USB host contr=
oller
>> is implemented. Depending on the TLL hardware revision , the TLL cha=
nnels
>> are configured. The USB HS core driver uses this driver through expo=
rted
>> APIs from the TLL platform driver.
>> usb_tll_enable and usb_tll_disble are the exported APIs of the USB T=
LL
>> platform driver.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
>> ---
>> =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A08 +
>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>> =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 ++++++=
+++++++++++++++++++++++++++
>> =A04 files changed, 473 insertions(+), 2 deletions(-)
>> =A0create mode 100644 drivers/mfd/omap-usb-tll.c
>>
>> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-o=
map/include/plat/usb.h
>> index dc864b5..eb1e47d 100644
>> --- a/arch/arm/plat-omap/include/plat/usb.h
>> +++ b/arch/arm/plat-omap/include/plat/usb.h
>> @@ -61,6 +61,10 @@ struct usbhs_omap_platform_data {
>> =A0 =A0 =A0 struct ehci_hcd_omap_platform_data =A0 =A0 =A0*ehci_data=
;
>> =A0 =A0 =A0 struct ohci_hcd_omap_platform_data =A0 =A0 =A0*ohci_data=
;
>> =A0};
>> +
>> +struct usbtll_omap_platform_data {
>> + =A0 =A0 enum usbhs_omap_port_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 port=
_mode[OMAP3_HS_USB_PORTS];
>> +};
>> =A0/*---------------------------------------------------------------=
----------*/
>>
>> =A0#define OMAP1_OTG_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0xfffb0400
>> @@ -105,6 +109,10 @@ extern int omap4430_phy_set_clk(struct device *=
dev, int on);
>> =A0extern int omap4430_phy_init(struct device *dev);
>> =A0extern int omap4430_phy_exit(struct device *dev);
>> =A0extern int omap4430_phy_suspend(struct device *dev, int suspend);
>> +
>> +extern int omap_tll_enable(void);
>> +extern int omap_tll_disable(void);
>> +
>> =A0#endif
>>
>> =A0extern void am35x_musb_reset(void);
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index f147395..5f75ad4 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -772,7 +772,7 @@ config MFD_WL1273_CORE
>> =A0 =A0 =A0 =A0 audio codec.
>>
>> =A0config MFD_OMAP_USB_HOST
>> - =A0 =A0 bool "Support OMAP USBHS core driver"
>> + =A0 =A0 bool "Support OMAP USBHS core and TLL driver"
>> =A0 =A0 =A0 depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
>> =A0 =A0 =A0 default y
>> =A0 =A0 =A0 help
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index b953bab..4b3a8e0 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -105,7 +105,7 @@ obj-$(CONFIG_MFD_TPS6586X) =A0 =A0 =A0 =A0+=3D t=
ps6586x.o
>> =A0obj-$(CONFIG_MFD_VX855) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D vx855.o
>> =A0obj-$(CONFIG_MFD_WL1273_CORE) =A0 =A0 =A0 =A0+=3D wl1273-core.o
>> =A0obj-$(CONFIG_MFD_CS5535) =A0 =A0 +=3D cs5535-mfd.o
>> -obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0+=3D omap-usb-host.o
>> +obj-$(CONFIG_MFD_OMAP_USB_HOST) =A0 =A0 =A0+=3D omap-usb-host.o oma=
p-usb-tll.o
>> =A0obj-$(CONFIG_MFD_PM8921_CORE) =A0 =A0 =A0 =A0+=3D pm8921-core.o
>> =A0obj-$(CONFIG_MFD_PM8XXX_IRQ) =A0 =A0 =A0 =A0 +=3D pm8xxx-irq.o
>> =A0obj-$(CONFIG_TPS65911_COMPARATOR) =A0 =A0+=3D tps65911-comparator=
=2Eo
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> new file mode 100644
>> index 0000000..3da468a
>> --- /dev/null
>> +++ b/drivers/mfd/omap-usb-tll.c
>> @@ -0,0 +1,463 @@
>> +/**
>> + * omap-usb-tll.c - The USB TLL driver for OMAP EHCI & OHCI
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com
> Nitpick : 2012
>> + * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> + *
>> + * This program is free software: you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 =A0=
of
>> + * the License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program. =A0If not, see <http://www.gnu.org/lice=
nses/>.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <plat/usb.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#define USBTLL_DRIVER_NAME =A0 "usbhs_tll"
>> +
>> +/* TLL Register Set */
>> +#define =A0 =A0 =A0OMAP_USBTLL_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (0x10)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_CACTIVITY =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 8)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SIDLEMODE =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 3)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_ENAWAKEUP =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 2)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_SOFTRESET =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 1)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG_AUTOIDLE =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (0x14)
>> +#define =A0 =A0 =A0OMAP_USBTLL_SYSSTATUS_RESETDONE =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 0)
>> +
>> +#define =A0 =A0 =A0OMAP_USBTLL_IRQSTATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (0x18)
>> +#define =A0 =A0 =A0OMAP_USBTLL_IRQENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (0x1C)
>> +
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30)
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 6)
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 5)
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF_USB_DIVRATION =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 2)
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_REQ =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (1 << 1)
>> +#define =A0 =A0 =A0OMAP_TLL_SHARED_CONF_FCLK_IS_ON =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 0)
>> +
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF(num) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x040 + 0x004 * num)
>> +#define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT =A0 =A0 =A0 =A0 24
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 11)
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE =A0 =A0 =
=A0 =A0 (1 << 10)
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 9)
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 8)
>> +#define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS =A0 =A0 =A0 =A0 =A0(1 <=
< 1)
>> +#define =A0 =A0 =A0OMAP_TLL_CHANNEL_CONF_CHANEN =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +
>> +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0 =A0 =A0 =A0 =A0 =A0 0x0
>> +#define OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 0x=
1
>> +#define OMAP_TLL_FSLSMODE_3PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x2
>> +#define OMAP_TLL_FSLSMODE_4PIN_PHY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x3
>> +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 0x4
>> +#define OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 0x=
5
>> +#define OMAP_TLL_FSLSMODE_3PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x6
>> +#define OMAP_TLL_FSLSMODE_4PIN_TLL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0x7
>> +#define OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0 =A0 =A0 =A0 =A0 =A0 0xA
>> +#define OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM =A0 =A0 =A0 =A0 =A0 =A0 0x=
B
>> +
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_FUNCTION_CTRL(num) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x804 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_INTERFACE_CTRL(num) =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (0x807 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_OTG_CTRL(num) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x80A + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_RISE(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x80D + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_INT_EN_FALL(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x810 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_INT_STATUS(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 (0x813 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_INT_LATCH(num) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x814 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_DEBUG(num) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0(0x815 + 0x100 * num)
>> +#define =A0 =A0 =A0OMAP_TLL_ULPI_SCRATCH_REGISTER(num) =A0 =A0 =A0 =
=A0 =A0 =A0 (0x816 + 0x100 * num)
>> +
>> +#define OMAP_REV2_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A02
>> +#define OMAP_TLL_CHANNEL_COUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 3
>> +#define OMAP_TLL_CHANNEL_1_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 0)
>> +#define OMAP_TLL_CHANNEL_2_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 1)
>> +#define OMAP_TLL_CHANNEL_3_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 2)
>> +
>> +/* Values of USBTLL_REVISION - Note: these are not given in the TRM=
 */
> How are these values found? experimentally ?

yes,


>> +#define OMAP_USBTLL_REV1 =A0 =A0 =A0 =A0 =A0 =A0 0x00000015 =A0 =A0=
 =A0/* OMAP3 */
>> +#define OMAP_USBTLL_REV2 =A0 =A0 =A0 =A0 =A0 =A0 0x00000004 =A0 =A0=
 =A0/* OMAP4 */
>> +
> <snip>
>
> + =A0 =A0 =A0 else if (ver =3D=3D OMAP_USBTLL_REV2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D OMAP_REV2_TLL_CHANNEL_COUNT;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "TLL version failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
> + =A0 =A0 =A0 }
>
>
> <Snip>
>
>
>> +
>> +err_ioremap:
>> + =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
>> + =A0 =A0 iounmap(base);
>> + =A0 =A0 pm_runtime_put_sync(dev);
>> + =A0 =A0 tll_pdev =3D pdev;
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> Did not understand this check as ret is made -ENODEV so this is alway=
s true?
> Am I missing something?

I need to check this.

>> + =A0 =A0 pm_runtime_disable(dev);
>> +
>> +err_usbtll_p2_fck:
>> + =A0 =A0 clk_put(tll->usbtll_p2_fck);
>> +
>> +err_usbtll_p1_fck:
>> + =A0 =A0 clk_put(tll->usbtll_p1_fck);
>> +
>> +err_tll:
>> + =A0 =A0 kfree(tll);
>> +
>> +end:
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
>> + * @pdev: USB Host Controller being removed
>> + *
>> + * Reverses the effect of usbtll_omap_probe().
>> + */
>> +static int __devexit usbtll_omap_remove(struct platform_device *pde=
v)
>> +{
>> + =A0 =A0 struct usbtll_omap *tll =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 clk_put(tll->usbtll_p2_fck);
>> + =A0 =A0 clk_put(tll->usbtll_p1_fck);
>> + =A0 =A0 pm_runtime_disable(&pdev->dev);
>> + =A0 =A0 kfree(tll);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int usbtll_runtime_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*tll =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =3D=
 &tll->platdata;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 flags;
>> +
>> + =A0 =A0 dev_dbg(dev, "usbtll_runtime_resume\n");
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
>> +
>> + =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p1_fck);
>> +
>> + =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(tll->usbtll_p2_fck);
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int usbtll_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct usbtll_omap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*tll =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct usbtll_omap_platform_data =A0 =A0 =A0 =A0*pdata =3D=
 &tll->platdata;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 flags;
>> +
>> + =A0 =A0 dev_dbg(dev, "usbtll_runtime_suspend\n");
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "missing platform_data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return =A0-ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irqsave(&tll->lock, flags);
>> +
>> + =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[0]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p1_fck);
>> +
>> + =A0 =A0 if (is_ehci_tll_mode(pdata->port_mode[1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(tll->usbtll_p2_fck);
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&tll->lock, flags);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
>> + =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D usbtll_runtime_suspend=
,
>> + =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D usbtll_runtime_resume,
>> +};
>> +
> Also how about using runtime_pm_ops ?
Sorry I din't get this? what exact alternative are you suggesting here?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
