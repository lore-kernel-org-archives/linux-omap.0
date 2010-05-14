From: Venkatraman S <svenkatr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3 v2] musb: add musb support for AM35x
Date: Sat, 15 May 2010 00:46:56 +0530
Message-ID: <AANLkTim_Ii_2qNt30ZXbseT-dWPB7kJCq72sTXRhG686@mail.gmail.com>
References: <1273838737-6995-1-git-send-email-ajay.gupta@ti.com>
	 <1273838737-6995-2-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1273838737-6995-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> AM35x is based on OMAP35x but has an updated musb interface which
> uses CPPI4.1 DMA engine.
>
> Current patch supports only PIO mode transfers.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
> Changes from v1: (Based on Sergei's comment)
> =A0 =A0 =A0 =A0- Moved PHY clock and OTGMODE settings to board files
> =A0 =A0 =A0 =A0- Added clk_disable/put in exit path
> =A0 =A0 =A0 =A0- Removed unwanted code related to vbus
> =A0 =A0 =A0 =A0- Removed unhandled interrupt check
> =A0 =A0 =A0 =A0- Added timeout in phy_on()
> I had to use MACH_OMAP3517EVM as there is no ARCH_xxx config specific=
 to
> AM3517 platforms other than ARCH_OMAP3.
>
> =A0drivers/usb/musb/Kconfig =A0| =A0 =A04 +-
> =A0drivers/usb/musb/Makefile | =A0 =A04 +
> =A0drivers/usb/musb/am3517.c | =A0517 +++++++++++++++++++++++++++++++=
+++++++++++++
> =A03 files changed, 523 insertions(+), 2 deletions(-)
> =A0create mode 100644 drivers/usb/musb/am3517.c
>
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index ea3a882..5ea3d45 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -10,7 +10,7 @@ comment "Enable Host or Gadget support to see Inven=
tra options"
> =A0config USB_MUSB_HDRC
> =A0 =A0 =A0 =A0depends on (USB || USB_GADGET)
> =A0 =A0 =A0 =A0depends on (ARM || (BF54x && !BF544) || (BF52x && !BF5=
22 && !BF523))
> - =A0 =A0 =A0 select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM =
|| BLACKFIN)
> + =A0 =A0 =A0 select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM =
|| BLACKFIN || MACH_OMAP3517EVM)
> =A0 =A0 =A0 =A0select TWL4030_USB if MACH_OMAP_3430SDP
> =A0 =A0 =A0 =A0select USB_OTG_UTILS
> =A0 =A0 =A0 =A0tristate 'Inventra Highspeed Dual Role Controller (TI,=
 ADI, ...)'
> @@ -140,7 +140,7 @@ config USB_MUSB_HDRC_HCD
> =A0config MUSB_PIO_ONLY
> =A0 =A0 =A0 =A0bool 'Disable DMA (always use PIO)'
> =A0 =A0 =A0 =A0depends on USB_MUSB_HDRC
> - =A0 =A0 =A0 default y if USB_TUSB6010
> + =A0 =A0 =A0 default USB_TUSB6010 || MACH_OMAP3517EVM
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0All data is copied between memory and FIFO by the =
CPU.
> =A0 =A0 =A0 =A0 =A0DMA controllers are ignored.
> diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
> index 3a485da..52a8cf6 100644
> --- a/drivers/usb/musb/Makefile
> +++ b/drivers/usb/musb/Makefile
> @@ -19,7 +19,11 @@ ifeq ($(CONFIG_ARCH_OMAP2430),y)
> =A0endif
>
> =A0ifeq ($(CONFIG_ARCH_OMAP3430),y)
> + =A0 ifeq ($(CONFIG_MACH_OMAP3517EVM),y)
> + =A0 =A0 =A0 musb_hdrc-objs =A0+=3D am3517.o
> + =A0 else
> =A0 =A0 =A0 =A0musb_hdrc-objs =A0+=3D omap2430.o
> + =A0 endif
> =A0endif
>
> =A0ifeq ($(CONFIG_BF54x),y)
> diff --git a/drivers/usb/musb/am3517.c b/drivers/usb/musb/am3517.c
> new file mode 100644
> index 0000000..dd9e883
> --- /dev/null
> +++ b/drivers/usb/musb/am3517.c
> @@ -0,0 +1,517 @@
> +/*
> + * Texas Instruments AM3517 "glue layer"
> + *
> + * Copyright (c) 2010, by Texas Instruments
> + *
> + * Based on the DA8xx "glue layer" code.
> + * Copyright (C) 2005-2006 by Texas Instruments
> + * Copyright (c) 2008, MontaVista Software, Inc. <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> + *
> + * This file is part of the Inventra Controller Driver for Linux.
> + *
> + * The Inventra Controller Driver for Linux is free software; you
> + * can redistribute it and/or modify it under the terms of the GNU
> + * General Public License version 2 as published by the Free Softwar=
e
> + * Foundation.
> + *
> + * The Inventra Controller Driver for Linux is distributed in
> + * the hope that it will be useful, but WITHOUT ANY WARRANTY;
> + * without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public
> + * License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with The Inventra Controller Driver for Linux ; if not,
> + * write to the Free Software Foundation, Inc., 59 Temple Place,
> + * Suite 330, Boston, MA =A002111-1307 =A0USA
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <plat/control.h>
> +#include <plat/usb.h>
> +
> +#include "musb_core.h"
> +
> +/*
> + * AM3517 specific definitions
> + */
> +/* USB 2.0 OTG module registers */
> +#define USB_REVISION_REG =A0 =A0 =A0 0x00
> +#define USB_CTRL_REG =A0 =A0 =A0 =A0 =A0 0x04
> +#define USB_STAT_REG =A0 =A0 =A0 =A0 =A0 0x08
> +#define USB_EMULATION_REG =A0 =A0 =A00x0c
> +/* 0x10 Reserved */
> +#define USB_AUTOREQ_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x14
> +#define USB_SRP_FIX_TIME_REG =A0 0x18
> +#define USB_TEARDOWN_REG =A0 =A0 =A0 0x1c
> +#define EP_INTR_SRC_REG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x20
> +#define EP_INTR_SRC_SET_REG =A0 =A00x24
> +#define EP_INTR_SRC_CLEAR_REG =A00x28
> +#define EP_INTR_MASK_REG =A0 =A0 =A0 0x2c
> +#define EP_INTR_MASK_SET_REG =A0 0x30
> +#define EP_INTR_MASK_CLEAR_REG 0x34
> +#define EP_INTR_SRC_MASKED_REG 0x38
> +#define CORE_INTR_SRC_REG =A0 =A0 =A00x40
> +#define CORE_INTR_SRC_SET_REG =A00x44
> +#define CORE_INTR_SRC_CLEAR_REG =A0 =A0 =A0 =A00x48
> +#define CORE_INTR_MASK_REG =A0 =A0 0x4c
> +#define CORE_INTR_MASK_SET_REG 0x50
> +#define CORE_INTR_MASK_CLEAR_REG 0x54
> +#define CORE_INTR_SRC_MASKED_REG 0x58
> +/* 0x5c Reserved */
> +#define USB_END_OF_INTR_REG =A0 =A00x60
> +
> +/* Control register bits */
> +#define USB_SOFT_RESET_MASK =A0 =A01
> +
> +/* USB interrupt register bits */
> +#define USB_INTR_USB_SHIFT =A0 =A0 16
> +#define USB_INTR_USB_MASK =A0 =A0 =A0(0x1ff << USB_INTR_USB_SHIFT)
> +#define USB_INTR_DRVVBUS =A0 =A0 =A0 0x100
> +#define USB_INTR_RX_SHIFT =A0 =A0 =A016
> +#define USB_INTR_TX_SHIFT =A0 =A0 =A00
> +#define AM3517_TX_EP_MASK =A0 =A0 =A00xffff =A0 =A0 =A0 =A0 =A0/* EP=
0 + 15 Tx EPs */
> +#define AM3517_RX_EP_MASK =A0 =A0 =A00xfffe =A0 =A0 =A0 =A0 =A0/* 15=
 Rx EPs */
> +#define AM3517_TX_INTR_MASK =A0 =A0(AM3517_TX_EP_MASK << USB_INTR_TX=
_SHIFT)
> +#define AM3517_RX_INTR_MASK =A0 =A0(AM3517_RX_EP_MASK << USB_INTR_RX=
_SHIFT)
> +
> +#define USB_MENTOR_CORE_OFFSET 0x400
> +
> +static inline void phy_on(void)
> +{
> + =A0 =A0 =A0 unsigned long timeout =3D jiffies + msecs_to_jiffies(10=
0);
> + =A0 =A0 =A0 u32 devconf2;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Start the on-chip PHY and its PLL.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 devconf2 =3D omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> +
> + =A0 =A0 =A0 devconf2 &=3D ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OT=
GPWRDN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONF2_PHY_GPIOMODE);
> + =A0 =A0 =A0 devconf2 |=3D CONF2_PHY_PLLON | CONF2_DATPOL;
> +
> + =A0 =A0 =A0 omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> +
> + =A0 =A0 =A0 DBG(1, "Waiting for PHY clock good...\n");
> + =A0 =A0 =A0 while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & CONF2_PHYCLKGD)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(1, "musb PHY clock =
good timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
A 'break' would have been more appropriate.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static inline void phy_off(void)
> +{
> + =A0 =A0 =A0 u32 devconf2;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Power down the on-chip PHY.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 devconf2 =3D omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> +
> + =A0 =A0 =A0 devconf2 &=3D ~CONF2_PHY_PLLON;
> + =A0 =A0 =A0 devconf2 |=3D =A0CONF2_PHYPWRDN | CONF2_OTGPWRDN;
> + =A0 =A0 =A0 omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> +}
> +
> +/**
> + * musb_platform_enable - enable interrupts
> + */
> +void musb_platform_enable(struct musb *musb)
> +{
> + =A0 =A0 =A0 void __iomem *reg_base =3D musb->ctrl_base;
> + =A0 =A0 =A0 u32 epmask, coremask;
> +
> + =A0 =A0 =A0 /* Workaround: setup IRQs through both register sets. *=
/
> + =A0 =A0 =A0 epmask =3D ((musb->epmask & AM3517_TX_EP_MASK) << USB_I=
NTR_TX_SHIFT) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((musb->epmask & AM3517_RX_EP_MASK) << U=
SB_INTR_RX_SHIFT);
> + =A0 =A0 =A0 coremask =3D USB_INTR_USB_MASK;
> +
> + =A0 =A0 =A0 musb_writel(reg_base, EP_INTR_MASK_SET_REG, epmask);
> + =A0 =A0 =A0 musb_writel(reg_base, CORE_INTR_MASK_SET_REG, coremask)=
;
Is the variable 'coremask' really needed ?
Why not use USB_INTR_USB_MASK diretctly?
> +
> + =A0 =A0 =A0 /* Force the DRVVBUS IRQ so we can start polling for ID=
 change. */
> + =A0 =A0 =A0 if (is_otg_enabled(musb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(reg_base, CORE_INTR_SRC_SET=
_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_INTR_DRVVBU=
S << USB_INTR_USB_SHIFT);
> +}
> +
> +/**
extra '*'
> + * musb_platform_disable - disable HDRC and flush interrupts
> + */
> +void musb_platform_disable(struct musb *musb)
> +{
> + =A0 =A0 =A0 void __iomem *reg_base =3D musb->ctrl_base;
> +
> + =A0 =A0 =A0 musb_writel(reg_base, CORE_INTR_MASK_CLEAR_REG, USB_INT=
R_USB_MASK);
> + =A0 =A0 =A0 musb_writel(reg_base, EP_INTR_MASK_CLEAR_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AM3517_TX_INTR_MASK =
| AM3517_RX_INTR_MASK);
> + =A0 =A0 =A0 musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> + =A0 =A0 =A0 musb_writel(reg_base, USB_END_OF_INTR_REG, 0);
> +}
> +
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> +#define portstate(stmt) =A0 =A0 =A0 =A0stmt
> +#else
> +#define portstate(stmt)
> +#endif
> +
> +static void am3517_set_vbus(struct musb *musb, int is_on)
> +{
> + =A0 =A0 =A0 WARN_ON(is_on && is_peripheral_active(musb));
> +}
> +
> +#define =A0 =A0 =A0 =A0POLL_SECONDS =A0 =A02
> +
> +static struct timer_list otg_workaround;
> +
> +static void otg_timer(unsigned long _musb)
> +{
> + =A0 =A0 =A0 struct musb =A0 =A0 =A0 =A0 =A0 =A0 *musb =3D (void *)_=
musb;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*mregs =3D musb->mr=
egs;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devctl;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;
> +
> + =A0 =A0 =A0 /* We poll because AM3517's won't expose several OTG-cr=
itical
> + =A0 =A0 =A0 =A0* status change events (from the transceiver) otherw=
ise.
> + =A0 =A0 =A0 =A0*/
Check multiline comments style
> + =A0 =A0 =A0 devctl =3D musb_readb(mregs, MUSB_DEVCTL);
> + =A0 =A0 =A0 DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_str=
ing(musb));
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&musb->lock, flags);
> + =A0 =A0 =A0 switch (musb->xceiv->state) {
> + =A0 =A0 =A0 case OTG_STATE_A_WAIT_BCON:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devctl &=3D ~MUSB_DEVCTL_SESSION;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writeb(musb->mregs, MUSB_DEVCTL, d=
evctl);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devctl =3D musb_readb(musb->mregs, MUSB=
_DEVCTL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devctl & MUSB_DEVCTL_BDEVICE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_B_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_DEV_MODE(musb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_A_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_HST_MODE(musb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OTG_STATE_A_WAIT_VFALL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D OTG_STATE_A_WAIT=
_VRISE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(musb->ctrl_base, CORE_INTR_=
SRC_SET_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_INTR_VBUSE=
RROR << USB_INTR_USB_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OTG_STATE_B_IDLE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_peripheral_enabled(musb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devctl =3D musb_readb(mregs, MUSB_DEVCT=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devctl & MUSB_DEVCTL_BDEVICE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&otg_workarou=
nd, jiffies + POLL_SECONDS * HZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_A_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&musb->lock, flags);
> +}
> +
> +void musb_platform_try_idle(struct musb *musb, unsigned long timeout=
)
> +{
> + =A0 =A0 =A0 static unsigned long last_timer;
> +
> + =A0 =A0 =A0 if (!is_otg_enabled(musb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (timeout =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(=
3);
> +
> + =A0 =A0 =A0 /* Never idle if active, or when VBUS timeout is not se=
t as host */
> + =A0 =A0 =A0 if (musb->is_active || (musb->a_wait_bcon =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->x=
ceiv->state =3D=3D OTG_STATE_A_WAIT_BCON)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(4, "%s active, deleting timer\n", o=
tg_state_string(musb));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&otg_workaround);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_timer =3D jiffies;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (time_after(last_timer, timeout) && timer_pending(&o=
tg_workaround)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(4, "Longer idle timer already pendi=
ng, ignoring...\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 last_timer =3D timeout;
> +
> + =A0 =A0 =A0 DBG(4, "%s inactive, starting idle timer for %u ms\n",
> + =A0 =A0 =A0 =A0 =A0 otg_state_string(musb), jiffies_to_msecs(timeou=
t - jiffies));
> + =A0 =A0 =A0 mod_timer(&otg_workaround, timeout);
> +}
> +
> +static irqreturn_t am3517_interrupt(int irq, void *hci)
> +{
> + =A0 =A0 =A0 struct musb =A0*musb =3D hci;
> + =A0 =A0 =A0 void __iomem *reg_base =3D musb->ctrl_base;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 irqreturn_t ret =3D IRQ_NONE;
> + =A0 =A0 =A0 u32 epintr, usbintr, lvl_intr;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&musb->lock, flags);
> +
> + =A0 =A0 =A0 /* Get endpoint interrupts */
> + =A0 =A0 =A0 epintr =3D musb_readl(reg_base, EP_INTR_SRC_MASKED_REG)=
;
> +
> + =A0 =A0 =A0 if (epintr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(reg_base, EP_INTR_SRC_CLEAR=
_REG, epintr);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->int_rx =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (epintr & AM3517_RX_INT=
R_MASK) >> USB_INTR_RX_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->int_tx =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (epintr & AM3517_TX_INT=
R_MASK) >> USB_INTR_TX_SHIFT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Get usb core interrupts */
> + =A0 =A0 =A0 usbintr =3D musb_readl(reg_base, CORE_INTR_SRC_MASKED_R=
EG);
> + =A0 =A0 =A0 if (!usbintr && !epintr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eoi;
> +
> + =A0 =A0 =A0 if (usbintr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(reg_base, CORE_INTR_SRC_CLE=
AR_REG, usbintr);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->int_usb =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (usbintr & USB_INTR_USB=
_MASK) >> USB_INTR_USB_SHIFT;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* DRVVBUS IRQs are the only proxy we have (a very po=
or one!) for
> + =A0 =A0 =A0 =A0* AM3517's missing ID change IRQ. =A0We need an ID c=
hange IRQ to
> + =A0 =A0 =A0 =A0* switch appropriately between halves of the OTG sta=
te machine.
> + =A0 =A0 =A0 =A0* Managing DEVCTL.SESSION per Mentor docs requires t=
hat we know its
> + =A0 =A0 =A0 =A0* value but DEVCTL.BDEVICE is invalid without DEVCTL=
=2ESESSION set.
> + =A0 =A0 =A0 =A0* Also, DRVVBUS pulses for SRP (but not at 5V) ...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (usbintr & (USB_INTR_DRVVBUS << USB_INTR_USB_SHIFT))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int drvvbus =3D musb_readl(reg_base, US=
B_STAT_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *mregs =3D musb->mregs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 devctl =3D musb_readb(mregs, MUSB_DE=
VCTL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D is_host_enabled(musb) && (musb-=
>int_usb &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_INTR_VBUSERROR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The Mentor core do=
esn't debounce VBUS as needed
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to cope with devic=
e connect current spikes. This
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* means it's not unc=
ommon for bus-powered devices
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to get VBUS errors=
 during enumeration.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is a workarou=
nd, but newer RTL from Mentor
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* seems to allow a b=
etter one: "re"-starting sessions
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* without waiting fo=
r VBUS to stop registering in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* devctl.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->int_usb &=3D ~MUS=
B_INTR_VBUSERROR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_A_WAIT_VFALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&otg_workarou=
nd, jiffies + POLL_SECONDS * HZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARNING("VBUS error wor=
karound (delay coming)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_host_enabled(musb) && drv=
vbus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->is_active =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_HST_MODE(musb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->default_a =
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_A_WAIT_VRISE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 portstate(musb->port1_s=
tatus |=3D USB_PORT_STAT_POWER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&otg_workarou=
nd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->is_active =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MUSB_DEV_MODE(musb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->default_a =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->xceiv->state =3D =
OTG_STATE_B_IDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 portstate(musb->port1_s=
tatus &=3D ~USB_PORT_STAT_POWER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: this must complete power-on wi=
thin 100 ms. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(2, "VBUS %s (%s)%s, devctl %02x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvvbus=
 ? "on" : "off",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 otg_sta=
te_string(musb),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err ? "=
 ERROR" : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devctl)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (musb->int_tx || musb->int_rx || musb->int_usb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D musb_interrupt(musb);
> +
> + eoi:
> + =A0 =A0 =A0 /* EOI needs to be written for the IRQ to be re-asserte=
d. */
> + =A0 =A0 =A0 if (ret =3D=3D IRQ_HANDLED || epintr || usbintr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear level interrupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvl_intr =3D omap_ctrl_readl(AM35XX_CON=
TROL_LVL_INTR_CLEAR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvl_intr |=3D AM35XX_USBOTGSS_INT_CLR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ctrl_writel(lvl_intr, AM35XX_CONTR=
OL_LVL_INTR_CLEAR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write EOI */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb_writel(reg_base, USB_END_OF_INTR_R=
EG, 0);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Poll for ID change */
> + =A0 =A0 =A0 if (is_otg_enabled(musb) && musb->xceiv->state =3D=3D O=
TG_STATE_B_IDLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&otg_workaround, jiffies + PO=
LL_SECONDS * HZ);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&musb->lock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
> +{
> + =A0 =A0 =A0 u32 devconf2 =3D omap_ctrl_readl(AM35XX_CONTROL_DEVCONF=
2);
> +
> + =A0 =A0 =A0 devconf2 &=3D ~CONF2_OTGMODE;
> + =A0 =A0 =A0 switch (musb_mode) {
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
> + =A0 =A0 =A0 case MUSB_HOST: =A0 =A0 =A0 =A0 /* Force VBUS valid, ID=
 =3D 0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_FORCE_HOST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +#endif
> +#ifdef CONFIG_USB_GADGET_MUSB_HDRC
> + =A0 =A0 =A0 case MUSB_PERIPHERAL: =A0 /* Force VBUS valid, ID =3D 1=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_FORCE_DEVICE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +#endif
> +#ifdef CONFIG_USB_MUSB_OTG
> + =A0 =A0 =A0 case MUSB_OTG: =A0 =A0 =A0 =A0 =A0/* Don't override the=
 VBUS/ID comparators */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devconf2 |=3D CONF2_NO_OVERRIDE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +#endif
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(2, "Trying to set unsupported mode =
%u\n", musb_mode);
> + =A0 =A0 =A0 }
Either the switch case or the compile time flag is redundant.

> +
> + =A0 =A0 =A0 omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int __init musb_platform_init(struct musb *musb)
> +{
> + =A0 =A0 =A0 void __iomem *reg_base =3D musb->ctrl_base;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*otg_fck;
> + =A0 =A0 =A0 u32 rev, lvl_intr, sw_reset;
> +
> + =A0 =A0 =A0 musb->mregs +=3D USB_MENTOR_CORE_OFFSET;
> +
> + =A0 =A0 =A0 if (musb->set_clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->set_clock(musb->clock, 1);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(musb->clock);
> + =A0 =A0 =A0 DBG(2, "usbotg_ck=3D%lud\n", clk_get_rate(musb->clock))=
;
> +
> + =A0 =A0 =A0 otg_fck =3D clk_get(musb->controller, "fck");
> + =A0 =A0 =A0 clk_enable(otg_fck);
> + =A0 =A0 =A0 DBG(2, "usbotg_phy_ck=3D%lud\n", clk_get_rate(otg_fck))=
;
> +
> + =A0 =A0 =A0 /* Returns zero if e.g. not clocked */
> + =A0 =A0 =A0 rev =3D musb_readl(reg_base, USB_REVISION_REG);
> + =A0 =A0 =A0 if (!rev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 usb_nop_xceiv_register();
> + =A0 =A0 =A0 musb->xceiv =3D otg_get_transceiver();
> + =A0 =A0 =A0 if (!musb->xceiv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 if (is_host_enabled(musb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setup_timer(&otg_workaround, otg_timer,=
 (unsigned long) musb);
> +
> + =A0 =A0 =A0 musb->board_set_vbus =3D am3517_set_vbus;
> +
> + =A0 =A0 =A0 /* Global reset */
> + =A0 =A0 =A0 sw_reset =3D omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET=
);
> +
> + =A0 =A0 =A0 sw_reset |=3D AM35XX_USBOTGSS_SW_RST;
> + =A0 =A0 =A0 omap_ctrl_writel(sw_reset, AM35XX_CONTROL_IP_SW_RESET);
> +
> + =A0 =A0 =A0 sw_reset &=3D ~AM35XX_USBOTGSS_SW_RST;
> + =A0 =A0 =A0 omap_ctrl_writel(sw_reset, AM35XX_CONTROL_IP_SW_RESET);
> +
> + =A0 =A0 =A0 /* Reset the controller */
> + =A0 =A0 =A0 musb_writel(reg_base, USB_CTRL_REG, USB_SOFT_RESET_MASK=
);
> +
> + =A0 =A0 =A0 /* Start the on-chip PHY and its PLL. */
> + =A0 =A0 =A0 phy_on();
> +
> + =A0 =A0 =A0 msleep(5);
> +
> + =A0 =A0 =A0 musb->isr =3D am3517_interrupt;
> +
> + =A0 =A0 =A0 /* clear level interrupt */
> + =A0 =A0 =A0 lvl_intr =3D omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CL=
EAR);
> + =A0 =A0 =A0 lvl_intr |=3D AM35XX_USBOTGSS_INT_CLR;
> + =A0 =A0 =A0 omap_ctrl_writel(lvl_intr, AM35XX_CONTROL_LVL_INTR_CLEA=
R);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int musb_platform_exit(struct musb *musb)
> +{
> + =A0 =A0 =A0 struct clk *otg_fck =3D clk_get(musb->controller, "fck"=
);
> +
> + =A0 =A0 =A0 if (is_host_enabled(musb))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&otg_workaround);
> +
> + =A0 =A0 =A0 /* Delay to avoid problems with module reload... */
> + =A0 =A0 =A0 if (is_host_enabled(musb) && musb->xceiv->default_a) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 devctl, warn =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int delay;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If there's no peripheral connected=
, VBUS can take a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* long time to fall...
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (delay =3D 30; delay > 0; delay--) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devctl =3D musb_readb(m=
usb->mregs, MUSB_DEVCTL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(devctl & MUSB_DEV=
CTL_VBUS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do=
ne;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((devctl & MUSB_DEVC=
TL_VBUS) !=3D warn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 warn =3D=
 devctl & MUSB_DEVCTL_VBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(1, =
"VBUS %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 warn >> MUSB_DEVCTL_VBUS_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* In OTG mode, another host might be c=
onnected... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DBG(1, "VBUS off timeout (devctl %02x)\=
n", devctl);
> + =A0 =A0 =A0 }
> +done:
> + =A0 =A0 =A0 phy_off();
> +
> + =A0 =A0 =A0 usb_nop_xceiv_unregister();
> +
> + =A0 =A0 =A0 if (musb->set_clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 musb->set_clock(musb->clock, 0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(musb->clock);
> +
> + =A0 =A0 =A0 if (otg_fck) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(otg_fck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(otg_fck);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +void musb_platform_save_context(struct musb_context_registers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *musb_context)
> +{
> + =A0 =A0 =A0 phy_off();
> +}
> +
> +void musb_platform_restore_context(struct musb_context_registers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *musb_context)
> +{
> + =A0 =A0 =A0 phy_on();
> +}
> +#endif
> --
> 1.6.2.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
