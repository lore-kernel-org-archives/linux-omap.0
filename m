From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Tue, 31 Mar 2009 11:48:52 +0900
Message-ID: <4d34a0a70903301948x3edee317m76d55c470c8d9891@mail.gmail.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45585 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbZCaCsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2009 22:48:55 -0400
Received: by fxm2 with SMTP id 2so2221445fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 19:48:52 -0700 (PDT)
In-Reply-To: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

Hi Kevin,

Sorry to bother you, but can I ask you feedback again?

Best regards,
Kyuwon

On Thu, Mar 19, 2009 at 1:25 PM, Kim Kyuwon <chammoru@gmail.com> wrote:
> Sometimes, it is necessary to find out "what does wake up my board
> from suspend?". Notifying wake-up source feature may be used to blame
> unexpected wake-up events which increase power consumption. And user
> mode applications can act smartly according to the wake-up event from
> Suspend-to-RAM state to minimize power consumption. Note that this
> driver can't inform wake-up events from idle state. This driver uses
> sysfs interface to give information to user mode applications like:
>
> cat /sys/power/omap_resume_irq
> cat /sys/power/omap_resume_event
>
> This driver also privides the unified GPIO wake-up source
> configuration. specific GPIO settings in the board files are:
>
> /* Wakeup source configuration */
> static struct gpio_wake boardname_gpio_wake[] =3D {
> =A0 =A0 =A0 =A0{ 23, =A0 IRQF_TRIGGER_RISING, =A0 =A0"BT_WAKEUP", =A0=
 =A01},
> =A0 =A0 =A0 =A0{ 24, =A0 IRQF_TRIGGER_RISING, =A0 =A0"USB_DETECT", =A0=
 1},
> };
>
> static struct omap_wake_platform_data boardname_wake_data =3D {
> =A0 =A0 =A0 =A0.gpio_wakes =A0 =A0 =A0 =A0 =A0 =A0 =3D boardname_gpio=
_wake,
> =A0 =A0 =A0 =A0.gpio_wake_num =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(board=
name_gpio_wake),
> };
>
> static struct platform_device boardname_wakeup =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "omap-wa=
ke",
> =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &boardname_wake_=
data,
> =A0 =A0 =A0 =A0},
> };
>
> The patch adds Kconfig options "OMAP34xx wakeup source support" under
> "System type"->"TI OMAP implementations" menu.
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 | =A0 12 +
> =A0arch/arm/mach-omap2/prcm-common.h =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-omap2/prm-regbits-34xx.h | =A0 =A06 +
> =A0arch/arm/mach-omap2/wake34xx.c =A0 =A0 =A0 =A0 | =A0539 ++++++++++=
++++++++++++++++++++++
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +
> =A0arch/arm/plat-omap/include/mach/irqs.h | =A0 =A04 +
> =A0arch/arm/plat-omap/include/mach/pm.h =A0 | =A0 10 +
> =A0arch/arm/plat-omap/include/mach/wake.h | =A0 30 ++
> =A010 files changed, 633 insertions(+), 3 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/wake34xx.c
> =A0create mode 100644 arch/arm/plat-omap/include/mach/wake.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 16c6fb8..29ad0f1 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D pm24xx.o
> =A0obj-$(CONFIG_ARCH_OMAP24XX) =A0 =A0 =A0 =A0 =A0 =A0+=3D sleep24xx.=
o
> =A0obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o=
 sleep34xx.o cpuidle34xx.o
> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-deb=
ug.o
> +obj-$(CONFIG_OMAP_WAKE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D wake34xx.o
> =A0endif
>
> =A0# SmartReflex driver
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index be4b596..6da285e 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -33,9 +33,6 @@
> =A0#define INTC_MIR_SET0 =A0 =A0 =A0 =A0 =A00x008c
> =A0#define INTC_PENDING_IRQ0 =A0 =A0 =A00x0098
>
> -/* Number of IRQ state bits in each MIR register */
> -#define IRQ_BITS_PER_REG =A0 =A0 =A0 32
> -
> =A0/*
> =A0* OMAP2 has a number of different interrupt controllers, each inte=
rrupt
> =A0* controller is identified as its own "bank". Register definitions=
 are
> @@ -193,6 +190,24 @@ int omap_irq_pending(void)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +void omap_get_pending_irqs(u32 *pending_irqs, unsigned len)
> +{
> + =A0 =A0 =A0 int i, idx =3D 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_irq_bank *bank =3D irq_bank=
s + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (irq =3D 0; irq < bank->nr_irqs && =
idx < len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 irq +=3D IRQ_BITS_PER_REG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int offset =3D irq & (~=
(IRQ_BITS_PER_REG - 1));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pending_irqs[idx++] =3D=
 intc_bank_read_reg(bank,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (INTC_PENDING_IRQ0 + offset));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> =A0void __init omap_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0unsigned long nr_of_irqs =3D 0;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 9102cee..2d17906 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -91,6 +91,13 @@ static struct prm_setup_times prm_setup =3D {
> =A0 =A0 =A0 =A0.voltsetup2 =3D 0xff,
> =A0};
>
> +static struct pm_wakeup_status omap3_pm_wkst;
> +
> +void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wkst)
> +{
> + =A0 =A0 =A0 *pm_wkst =3D &omap3_pm_wkst;
> +}
> +
> =A0static inline void omap3_per_save_context(void)
> =A0{
> =A0 =A0 =A0 =A0omap3_gpio_save_context();
> @@ -174,6 +181,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
> =A0 =A0 =A0 =A0/* WKUP */
> =A0 =A0 =A0 =A0wkst =3D prm_read_mod_reg(WKUP_MOD, PM_WKST);
> + =A0 =A0 =A0 omap3_pm_wkst.wkup =3D wkst;
> =A0 =A0 =A0 =A0if (wkst) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D cm_read_mod_reg(WKUP_MOD, CM_=
ICLKEN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclk =3D cm_read_mod_reg(WKUP_MOD, CM_=
=46CLKEN);
> @@ -187,6 +195,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
> =A0 =A0 =A0 =A0/* CORE */
> =A0 =A0 =A0 =A0wkst =3D prm_read_mod_reg(CORE_MOD, PM_WKST1);
> + =A0 =A0 =A0 omap3_pm_wkst.core1 =3D wkst;
> =A0 =A0 =A0 =A0if (wkst) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D cm_read_mod_reg(CORE_MOD, CM_=
ICLKEN1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclk =3D cm_read_mod_reg(CORE_MOD, CM_=
=46CLKEN1);
> @@ -198,6 +207,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cm_write_mod_reg(fclk, CORE_MOD, CM_FC=
LKEN1);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0wkst =3D prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKS=
T3);
> + =A0 =A0 =A0 omap3_pm_wkst.core3 =3D wkst;
> =A0 =A0 =A0 =A0if (wkst) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D cm_read_mod_reg(CORE_MOD, CM_=
ICLKEN3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclk =3D cm_read_mod_reg(CORE_MOD, OMA=
P3430ES2_CM_FCLKEN3);
> @@ -211,6 +221,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
>
> =A0 =A0 =A0 =A0/* PER */
> =A0 =A0 =A0 =A0wkst =3D prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
> + =A0 =A0 =A0 omap3_pm_wkst.per =3D wkst;
> =A0 =A0 =A0 =A0if (wkst) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D cm_read_mod_reg(OMAP3430_PER_=
MOD, CM_ICLKEN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclk =3D cm_read_mod_reg(OMAP3430_PER_=
MOD, CM_FCLKEN);
> @@ -225,6 +236,7 @@ static irqreturn_t prcm_interrupt_handler (int
> irq, void *dev_id)
> =A0 =A0 =A0 =A0if (omap_rev() > OMAP3430_REV_ES1_0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* USBHOST */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wkst =3D prm_read_mod_reg(OMAP3430ES2_=
USBHOST_MOD, PM_WKST);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_pm_wkst.usbhost =3D wkst;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (wkst) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iclk =3D cm_read_mod_r=
eg(OMAP3430ES2_USBHOST_MOD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 CM_ICLKEN);
> diff --git a/arch/arm/mach-omap2/prcm-common.h
> b/arch/arm/mach-omap2/prcm-common.h
> index cb1ae84..1f340aa 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -273,6 +273,10 @@
> =A0#define OMAP3430_ST_D2D_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A03
> =A0#define OMAP3430_ST_D2D_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 3)
>
> +/* PM_WKST3_CORE, CM_IDLEST3_CORE shared bits */
> +#define OMAP3430_ST_USBTLL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 2
> +#define OMAP3430_ST_USBTLL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +
> =A0/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
> =A0#define OMAP3430_EN_GPIO1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 3)
> =A0#define OMAP3430_EN_GPIO1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h
> b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index cb648f9..6066032 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -332,6 +332,8 @@
> =A0/* PM_IVA2GRPSEL1_CORE specific bits */
>
> =A0/* PM_WKST1_CORE specific bits */
> +#define OMAP3430_ST_MMC3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 30
> +#define OMAP3430_ST_MMC3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 30)
>
> =A0/* PM_PWSTCTRL_CORE specific bits */
> =A0#define OMAP3430_MEM2ONSTATE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 18
> @@ -373,6 +375,7 @@
> =A0/* PM_IVA2GRPSEL_WKUP specific bits */
>
> =A0/* PM_WKST_WKUP specific bits */
> +#define OMAP3430_ST_IO_CHAIN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (1 << 16)
> =A0#define OMAP3430_ST_IO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (1 << 8)
>
> =A0/* PRM_CLKSEL */
> @@ -430,6 +433,9 @@
>
> =A0/* PM_PREPWSTST_PER specific bits */
>
> +/* PM_WKST_USBHOST specific bits */
> +#define OMAP3430_ST_USBHOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 0)
> +
> =A0/* RM_RSTST_EMU specific bits */
>
> =A0/* PM_PWSTST_EMU specific bits */
> diff --git a/arch/arm/mach-omap2/wake34xx.c b/arch/arm/mach-omap2/wak=
e34xx.c
> new file mode 100644
> index 0000000..de21f97
> --- /dev/null
> +++ b/arch/arm/mach-omap2/wake34xx.c
> @@ -0,0 +1,539 @@
> +/*
> + * wake34xx.c
> + *
> + * Copyright (c) 2009 Samsung Eletronics
> + *
> + * Author: Kim Kyuwon <q1.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +
> +#include <mach/pm.h>
> +#include <mach/gpio.h>
> +#include <mach/wake.h>
> +
> +#include "prm-regbits-34xx.h"
> +
> +/*
> + * Sometimes, it is necessary to find out "what does wake up my boar=
d from
> + * suspend?". Notifying wake-up source feature may be used to blame
> + * unexpected wake-up events which increase power consumption. And u=
ser
> + * mode applications can act smartly according to the wake-up event =
from
> + * Suspend-to-RAM state to minimize power consumption. Note that thi=
s
> + * driver can't inform wake-up events from idle state. This driver u=
ses
> + * sysfs interface to give information to user mode applications.
> + */
> +
> +#define WAKE_STR_LEN =A0 64
> +#define WAKE_BUF_LEN =A0 32
> +
> +/* Note: Allowed to use Only in the wakeup_source_show() function */
> +static struct omap_wake *g_wake;
> +
> +static char wakeup_gpio[WAKE_STR_LEN];
> +
> +struct omap_wake {
> + =A0 =A0 =A0 u32 pending_irqs[INTCPS_NR_MIR_REGS];
> +};
> +
> +struct wake_event {
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 mask;
> + =A0 =A0 =A0 const char =A0 =A0 =A0*name;
> +};
> +
> +static struct wake_event omap3_wkup_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430_ST_IO_CHAIN, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "ST_IO" },
> + =A0 =A0 =A0 { OMAP3430_ST_IO, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "ST_SR2" },
> + =A0 =A0 =A0 { OMAP3430_ST_SR2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "ST_SR2" },
> + =A0 =A0 =A0 { OMAP3430_ST_SR1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "ST_SR1" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO1" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT12_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPT12" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT1" },
> +};
> +
> +static struct wake_event omap3_per_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO6_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO6" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO5_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO5" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO4_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO4" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO3" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPIO2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPIO2" },
> + =A0 =A0 =A0 { OMAP3430_ST_UART3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_UART3" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT9_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT9" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT8_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT8" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT7_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT7" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT6_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT6" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT5_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT5" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT4_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT4" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT3" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_GPT2" },
> + =A0 =A0 =A0 { OMAP3430_EN_MCBSP4, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "EN_MCBSP4" },
> + =A0 =A0 =A0 { OMAP3430_EN_MCBSP3, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "EN_MCBSP3" },
> + =A0 =A0 =A0 { OMAP3430_EN_MCBSP2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "EN_MCBSP2" },
> +};
> +
> +static struct wake_event omap3_core1_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430_ST_MMC3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_MMC3" },
> + =A0 =A0 =A0 { OMAP3430_ST_MMC2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_MMC2" },
> + =A0 =A0 =A0 { OMAP3430_ST_MMC1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_MMC1" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCSPI4_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCSPI4" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCSPI3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCSPI3" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCSPI2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCSPI2" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCSPI1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCSPI1" },
> + =A0 =A0 =A0 { OMAP3430_ST_I2C3_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_I2C3" },
> + =A0 =A0 =A0 { OMAP3430_ST_I2C2_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_I2C2" },
> + =A0 =A0 =A0 { OMAP3430_ST_I2C1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"ST_I2C1" },
> + =A0 =A0 =A0 { OMAP3430_ST_UART1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_UART1" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT11_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPT11" },
> + =A0 =A0 =A0 { OMAP3430_ST_GPT10_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ST_GPT10" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCBSP5_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCBSP5" },
> + =A0 =A0 =A0 { OMAP3430_ST_MCBSP1_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_MCBSP1" },
> +};
> +
> +static struct wake_event omap3es1_core1_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430ES1_ST_FSHOSTUSB_MASK, =A0 =A0 =A0 =A0"ST_FSH=
OSTUSB" },
> + =A0 =A0 =A0 { OMAP3430ES1_ST_HSOTGUSB_MASK, =A0 =A0 =A0 =A0 "ST_HSO=
TGUSB" },
> + =A0 =A0 =A0 { OMAP3430_ST_D2D_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "ST_D2D" },
> +};
> +
> +static struct wake_event omap3es2_core1_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK, =A0 "ST_HSOTGUSB"=
 },
> +};
> +
> +static struct wake_event omap3_core3_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430_ST_USBTLL_MASK, =A0 =A0 =A0 =A0 =A0 =A0 =A0"=
ST_USBTLL" },
> +};
> +
> +static struct wake_event omap3_usbhost_events[] =3D {
> + =A0 =A0 =A0 { OMAP3430_ST_USBHOST, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"ST_USBHOST" },
> +};
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
kobj_attribute *attr, char *buf);
> +
> +/*
> + * Get the first pending MPU IRQ number from 'irq_start'.
> + * If none, return -EINVAL.
> + */
> +int omap_wake_get_pending_irq(struct omap_wake *wake, unsigned int i=
rq_start)
> +{
> + =A0 =A0 =A0 int i, bits_skip, idx_start;
> +
> + =A0 =A0 =A0 if (irq_start >=3D INTCPS_NR_IRQS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 bits_skip =3D irq_start % IRQ_BITS_PER_REG;
> + =A0 =A0 =A0 idx_start =3D irq_start / IRQ_BITS_PER_REG;
> +
> + =A0 =A0 =A0 for (i =3D idx_start; i < ARRAY_SIZE(wake->pending_irqs=
); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, bit;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D wake->pending_irqs[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (idx_start =3D=3D i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D find_next_bit(&=
val, IRQ_BITS_PER_REG, bits_skip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D find_first_bit(=
&val, IRQ_BITS_PER_REG);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bit < IRQ_BITS_PER_REG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i * IRQ_BITS_PER=
_REG + bit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static void omap_wake_strncat(char *dest, char *src, size_t count)
> +{
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 if (!src[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (dest[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D strlen(dest) + strlen(src) + 2;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D strlen(dest) + strlen(src);
> +
> + =A0 =A0 =A0 if (len > count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't strncat: %s\n", =
src);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (dest[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(dest, ", ");
> + =A0 =A0 =A0 strcat(dest, src);
> +}
> +
> +static int omap_wake_lookup_event(u32 wkst, char *event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
wake_event *events, unsigned len)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < len; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wkst & events[i].mask) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(event, events[i=
].name, WAKE_BUF_LEN - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static void omap_wake_detect_wkup(u32 wkst, char *event)
> +{
> + =A0 =A0 =A0 int error =3D omap_wake_lookup_event(wkst, event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_wkup_events, ARRAY_SIZE(omap3_wku=
p_events));
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(event, WAKE_BUF_LEN, "WKUP:0x%=
08x", wkst);
> +}
> +
> +static void omap_wake_detect_per(u32 wkst, char *event)
> +{
> + =A0 =A0 =A0 int error =3D omap_wake_lookup_event(wkst, event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_per_events, ARRAY_SIZE(omap3_per_=
events));
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(event, WAKE_BUF_LEN, "PER:0x%0=
8x", wkst);
> +}
> +
> +static void omap_wake_detect_core1(u32 wkst, char *event)
> +{
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 error =3D omap_wake_lookup_event(wkst, event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core1_events, ARRAY_SIZE(omap3_co=
re1_events));
> + =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D omap_wake_lookup_event(wkst, =
event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap3es1_core1_events,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ARRAY_SIZE(omap3es1_core1_events));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D omap_wake_lookup_event(wkst, =
event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap3es2_core1_events,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ARRAY_SIZE(omap3es2_core1_events));
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 snprintf(event, WAKE_BUF_LEN, "CORE1:0x%08x", wkst);
> +}
> +
> +static void omap_wake_detect_core3(u32 wkst, char *event)
> +{
> + =A0 =A0 =A0 int error =3D omap_wake_lookup_event(wkst, event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core3_events, ARRAY_SIZE(omap3_co=
re3_events));
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(event, WAKE_BUF_LEN, "CORE3:0x=
%08x", wkst);
> +}
> +
> +static void omap_wake_detect_usbhost(u32 wkst, char *event)
> +{
> + =A0 =A0 =A0 int error =3D omap_wake_lookup_event(wkst, event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_usbhost_events, ARRAY_SIZE(omap3_=
usbhost_events));
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(event, WAKE_BUF_LEN, "USBHOST:=
0x%08x", wkst);
> +}
> +
> +/* Detect wake-up events */
> +static void omap_wake_detect_wakeup(struct omap_wake *wake,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 char *wake_irq, char *wake_event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size_t irq_size, size_t event_size)
> +{
> + =A0 =A0 =A0 struct pm_wakeup_status *pm_wkst;
> + =A0 =A0 =A0 char buf[WAKE_BUF_LEN] =3D {0, };
> + =A0 =A0 =A0 int irq, len, gpio_irq =3D 0, prcm_irq =3D 0;
> +
> + =A0 =A0 =A0 /* IRQ */
> + =A0 =A0 =A0 irq =3D omap_wake_get_pending_irq(wake, 0);
> + =A0 =A0 =A0 while (irq >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq =3D=3D INT_34XX_SYS_NIRQ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_=
event, "sys_nirq",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 event_size - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (irq =3D=3D INT_34XX_PRCM_MPU_I=
RQ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prcm_irq =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (irq >=3D INT_34XX_GPIO_BANK1 &=
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 irq <=3D INT_34XX_GPIO_BANK6)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_irq =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D strlen(wake_irq) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snprintf(buf, WAKE_BUF_=
LEN, "%d", irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > irq_size - 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(wake_irq, buf);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D omap_wake_get_pending_irq(wake,=
 irq + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D strlen(wake_irq=
) + 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > irq_size - 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcat(wake_irq, ", ");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!wake_irq[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(wake_irq, "Unknown", irq_size -=
 1);
> +
> + =A0 =A0 =A0 if (gpio_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, wakeup_gp=
io, event_size - 1);
> +
> + =A0 =A0 =A0 if (!prcm_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end_detect;
> +
> + =A0 =A0 =A0 omap3_get_wakeup_status(&pm_wkst);
> +
> + =A0 =A0 =A0 /* WKUP */
> + =A0 =A0 =A0 if (pm_wkst->wkup) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_detect_wkup(pm_wkst->wkup, bu=
f);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, buf, even=
t_size - 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* PER */
> + =A0 =A0 =A0 if (pm_wkst->per) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_detect_per(pm_wkst->per, buf)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, buf, even=
t_size - 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* CORE */
> + =A0 =A0 =A0 if (pm_wkst->core1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_detect_core1(pm_wkst->core1, =
buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, buf, even=
t_size - 1);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (pm_wkst->core3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_detect_core3(pm_wkst->core3, =
buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, buf, even=
t_size - 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* USBHOST */
> + =A0 =A0 =A0 if ((omap_rev() > OMAP3430_REV_ES1_0) && (pm_wkst->usbh=
ost)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_detect_usbhost(pm_wkst->usbho=
st, buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_wake_strncat(wake_event, buf, even=
t_size - 1);
> + =A0 =A0 =A0 }
> +
> +end_detect:
> + =A0 =A0 =A0 if (!wake_event[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(wake_event, "Unknown", event_si=
ze - 1);
> +}
> +
> +static struct kobj_attribute wakeup_irq_attr =3D
> + =A0 =A0 =A0 __ATTR(omap_resume_irq, 0644, wakeup_source_show, NULL)=
;
> +
> +static struct kobj_attribute wakeup_event_attr =3D
> + =A0 =A0 =A0 __ATTR(omap_resume_event, 0644, wakeup_source_show, NUL=
L);
> +
> +static ssize_t wakeup_source_show(struct kobject *kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
kobj_attribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 char wakeup_irq[WAKE_STR_LEN] =3D {0, };
> + =A0 =A0 =A0 char wakeup_event[WAKE_STR_LEN] =3D {0, };
> +
> + =A0 =A0 =A0 if (!g_wake)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 omap_wake_detect_wakeup(g_wake, wakeup_irq, wakeup_even=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
wakeup_irq), sizeof(wakeup_event));
> +
> + =A0 =A0 =A0 if (attr =3D=3D &wakeup_irq_attr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%s\n", wakeup_irq)=
;
> + =A0 =A0 =A0 else if (attr =3D=3D &wakeup_event_attr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%s\n", wakeup_even=
t);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static irqreturn_t omap_wake_detect_gpio(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 omap_wake_strncat(wakeup_gpio, dev_id, sizeof(wakeup_gp=
io) - 1);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int __devinit omap_wake_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_wake *wake;
> + =A0 =A0 =A0 struct omap_wake_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_wake *gw;
> + =A0 =A0 =A0 int i, ret;
> +
> + =A0 =A0 =A0 wake =3D kzalloc(sizeof(struct omap_wake), GFP_KERNEL);
> + =A0 =A0 =A0 if (wake =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate=
 driver data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, wake);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* It may be good to configure GPIO wake-up sources i=
n each driver.
> + =A0 =A0 =A0 =A0* Buf if the specific device driver doesn't exist, y=
ou can use
> + =A0 =A0 =A0 =A0* omap-wake driver to configure gpio wake-up sources=
=2E
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpio_wake_num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gw->request) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(gw=
->gpio, gw->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(&pdev->dev, "can't request gpio%d"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ", return %d\n", gw->gpio, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fa=
iled_free_gpio;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(gw->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(gpio_to_irq(gw->gpio));
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In wakeup_source_show(), we can't access platform_=
device
> + =A0 =A0 =A0 =A0* or omap_wake structure without a global variable. =
so 'g_wake' is
> + =A0 =A0 =A0 =A0* needed, but please use it carefully.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 g_wake =3D wake;
> +
> + =A0 =A0 =A0 ret =3D sysfs_create_file(power_kobj, &wakeup_irq_attr.=
attr);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "sysfs_create_file =
%s failed: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 wakeup_irq_attr.attr.name, ret);
> +
> + =A0 =A0 =A0 ret =3D sysfs_create_file(power_kobj, &wakeup_event_att=
r.attr);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "sysfs_create_file =
%s failed: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 wakeup_event_attr.attr.name, ret);
> +
> + =A0 =A0 =A0 return 0;
> +
> +failed_free_gpio:
> + =A0 =A0 =A0 for (i--; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gw->request)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(gw->gpio);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(wake);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit omap_wake_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_wake *wake =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct omap_wake_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_wake *gw;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpio_wake_num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gw->request)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(gw->gpio);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(gpio_to_irq(gw->gpio))=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(wake);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_wake_suspend(struct platform_device *pdev, pm_messag=
e_t state)
> +{
> + =A0 =A0 =A0 struct omap_wake_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_wake *gw;
> + =A0 =A0 =A0 int i, ret;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpio_wake_num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(gpio_to_irq(gw->gpi=
o), omap_wake_detect_gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw->irqflag | IRQF_SHAR=
ED, gw->name, (void *)gw->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ca=
n't get IRQ%d, return %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 gpio_to_irq(gw->gpio), ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 memset(wakeup_gpio, 0x0, WAKE_STR_LEN);
> +
> + =A0 =A0 =A0 return 0;
> +
> +failed_free_irq:
> + =A0 =A0 =A0 for (i--; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(gw->gpio), =A0(voi=
d *)gw->name);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int omap_wake_resume_early(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_wake *wake =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 omap_get_pending_irqs(wake->pending_irqs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ARRAY_SIZE(wake->pending_irqs));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap_wake_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct omap_wake_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_wake *gw;
> + =A0 =A0 =A0 int i;
> +
> +#ifdef CONFIG_PM_DEBUG
> + =A0 =A0 =A0 struct omap_wake *wake =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 char wakeup_irq[WAKE_STR_LEN] =3D {0, };
> + =A0 =A0 =A0 char wakeup_event[WAKE_STR_LEN] =3D {0, };
> +
> + =A0 =A0 =A0 omap_wake_detect_wakeup(wake, wakeup_irq, wakeup_event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
wakeup_irq), sizeof(wakeup_event));
> + =A0 =A0 =A0 printk(KERN_INFO "OMAP resume IRQ: %s\n", wakeup_irq);
> + =A0 =A0 =A0 printk(KERN_INFO "OMAP resume event: %s\n", wakeup_even=
t);
> +#endif
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpio_wake_num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gw =3D pdata->gpio_wakes + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(gw->gpio), (void *=
)gw->name);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver omap_wake_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_wake_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(omap_wake_remov=
e),
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D omap_wake_suspend,
> + =A0 =A0 =A0 .resume_early =A0 =3D omap_wake_resume_early,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D omap_wake_resume,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap-wake",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init omap_wake_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&omap_wake_driver);
> +}
> +
> +module_init(omap_wake_init);
> +
> +static void __exit omap_wake_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&omap_wake_driver);
> +}
> +module_exit(omap_wake_exit);
> +
> +MODULE_AUTHOR("Kim Kyuwon <q1.kim@samsung.com>");
> +MODULE_DESCRIPTION("OMAP34xx wakeup driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index b8f1298..f89efaa 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -184,6 +184,15 @@ config OMAP_IOMMU
> =A0 =A0 =A0 =A0 =A0Say Y here if you want to use OMAP IOMMU support f=
or IVA2 and
> =A0 =A0 =A0 =A0 =A0Camera in OMAP3.
>
> +config OMAP_WAKE
> + =A0 =A0 =A0 tristate "OMAP34xx wakeup source support"
> + =A0 =A0 =A0 depends on ARCH_OMAP34XX && PM
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this option if you want to know what kind of=
 wake-up event
> + =A0 =A0 =A0 =A0 wakes up your board from the low power mode. And th=
is option
> + =A0 =A0 =A0 =A0 provides the unified GPIO wake-up source configurat=
ion.
> +
> =A0choice
> =A0 =A0 =A0 =A0 prompt "System timer"
> =A0 =A0 =A0 =A0default OMAP_MPU_TIMER
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h
> b/arch/arm/plat-omap/include/mach/irqs.h
> index c9a5b19..ee15402 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -385,9 +385,13 @@
> =A0#define INTCPS_NR_MIR_REGS =A0 =A0 3
> =A0#define INTCPS_NR_IRQS =A0 =A0 =A0 =A0 96
>
> +/* Number of IRQ state bits in each MIR register */
> +#define IRQ_BITS_PER_REG =A0 =A0 =A0 32
> +
> =A0#ifndef __ASSEMBLY__
> =A0extern void omap_init_irq(void);
> =A0extern int omap_irq_pending(void);
> +extern void omap_get_pending_irqs(u32 *pending_irqs, unsigned len);
> =A0void omap3_intc_save_context(void);
> =A0void omap3_intc_restore_context(void);
> =A0#endif
> diff --git a/arch/arm/plat-omap/include/mach/pm.h
> b/arch/arm/plat-omap/include/mach/pm.h
> index 9df0175..b10f5b0 100644
> --- a/arch/arm/plat-omap/include/mach/pm.h
> +++ b/arch/arm/plat-omap/include/mach/pm.h
> @@ -175,6 +175,16 @@ extern void omap_serial_wake_trigger(int enable)=
;
> =A0#define omap_serial_wake_trigger(x) =A0 =A0{}
> =A0#endif /* CONFIG_OMAP_SERIAL_WAKE */
>
> +struct pm_wakeup_status {
> + =A0 =A0 =A0 u32 wkup;
> + =A0 =A0 =A0 u32 core1;
> + =A0 =A0 =A0 u32 core3;
> + =A0 =A0 =A0 u32 per;
> + =A0 =A0 =A0 u32 usbhost;
> +};
> +
> +extern void omap3_get_wakeup_status(struct pm_wakeup_status **pm_wks=
t);
> +
> =A0#define ARM_SAVE(x) arm_sleep_save[ARM_SLEEP_SAVE_##x] =3D omap_re=
adl(x)
> =A0#define ARM_RESTORE(x) omap_writel((arm_sleep_save[ARM_SLEEP_SAVE_=
##x]), (x))
> =A0#define ARM_SHOW(x) arm_sleep_save[ARM_SLEEP_SAVE_##x]
> diff --git a/arch/arm/plat-omap/include/mach/wake.h
> b/arch/arm/plat-omap/include/mach/wake.h
> new file mode 100644
> index 0000000..7da8ec8
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/wake.h
> @@ -0,0 +1,30 @@
> +/*
> + * wake.h
> + *
> + * Copyright (c) 2009 Samsung Eletronics
> + *
> + * Author: Kim Kyuwon <q1.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _WAKE_H_
> +#define _WAKE_H_
> +
> +struct gpio_wake {
> + =A0 =A0 =A0 unsigned int =A0 =A0gpio;
> + =A0 =A0 =A0 unsigned long =A0 irqflag;
> + =A0 =A0 =A0 const char =A0 =A0 =A0*name;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 request;
> +};
> +
> +struct omap_wake_platform_data{
> + =A0 =A0 =A0 struct gpio_wake =A0 =A0 =A0 =A0*gpio_wakes;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_wake_n=
um;
> +};
> +
> +#endif /* _WAKE_H_ */
> +
> --
> 1.5.2.5
>
>
> --
> Kim Kyuwon
>



--=20
Kyuwon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
