From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform device
Date: Mon, 6 Dec 2010 21:19:26 -0800
Message-ID: <AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com> <1290689318-10191-11-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0LGFTs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:19:48 -0500
Received: by wyb28 with SMTP id 28so12846327wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:19:46 -0800 (PST)
In-Reply-To: <1290689318-10191-11-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, Rajendra Nayak <rnayak@ti.com>

On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> Implement GPIO as a platform device.
>
> GPIO APIs are used in machine_init functions. Hence it is
> required to complete GPIO probe before board_init. Therefore
> GPIO device register and driver register are implemented as
> postcore_initcalls.
>
> omap_gpio_init() does nothing now and this function would be
> removed in the next patch as it's usage is spread across most
> of the board files.
>
> Inorder to convert GPIO as platform device, modifications are
> required in clockxxxx_data.c file for OMAP1 so that device names
> can be used to obtain clock instead of getting clocks by
> name/NULL ptr.
>
> Use runtime pm APIs (pm_runtime_put*/pm_runtime_get*) for enabling
> or disabling the clocks, modify sysconfig settings and remove usage
> of clock FW APIs.
> Note 1: Converting GPIO driver to use runtime PM APIs is not done as =
a
> separate patch because GPIO clock names are different for various OMA=
Ps
> and are different for some of the banks in the same CPU. This would n=
eed
> usage of cpu_is checks and bank id checks while using clock FW APIs i=
n
> the gpio driver. Hence while making GPIO a platform driver framework,
> PM runtime APIs are used directly.
>
> Note 2: While implementing GPIO as a platform device, pm runtime APIs
> are used as mentioned above and modification is not done in gpio's
> prepare for idle/ resume after idle functions. This would be done
> in the next patch series and GPIO driver would be made to use dev_pm_=
ops
> instead of sysdev_class in that series only.
>
> Due to the above, the GPIO driver implicitly relies on
> CM_AUTOIDLE =3D 1 on its iclk for power management to work, since the
> driver never disables its iclk.
> This would be taken care in the next patch series (see Note 3 below).
>
> Refer to
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39112.html
> for more details.
>
> Note 3: only pm_runtime_get_sync is called in gpio's probe() and
> pm_runtime_put* is never called. This is to make the implementation
> similar to the existing GPIO code. Another patch series would be sent
> to correct this.
>
> In OMAP3 and OMAP4 gpio's debounce clocks are optional clocks. They
> are enabled/ disabled whenever required using clock framework APIs
>
> TODO:
> 1. Cleanup the GPIO driver. Use function pointers and register
> offest pointers instead of using hardcoded values
> 2. Remove all cpu_is_ checks and OMAP specific macros
> 3. Remove usage of gpio_bank array so that only
> =C2=A0 instance specific information is used in driver code
> 4. Rename 'method'/ avoid it's usage
> 5. Fix the non-wakeup gpios handling for OMAP2430, OMAP3 & OMAP4
> 6. Modify gpio's prepare for idle/ resume after idle functions
> =C2=A0 to use runtime pm implentation.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reviewed-by: Basak, Partha <p-basak2@ti.com>
> ---
> =C2=A0arch/arm/mach-omap1/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +
> =C2=A0arch/arm/mach-omap1/clock_data.c | =C2=A0 =C2=A04 +-
> =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/plat-omap/gpio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A042=
0 ++++++++++----------------------------
> =C2=A04 files changed, 114 insertions(+), 318 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makef=
ile
> index de3cc13..0b1c07f 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -49,6 +49,12 @@ ifeq ($(CONFIG_ARCH_OMAP15XX),y)
> =C2=A0obj-$(CONFIG_MACH_OMAP_INNOVATOR) =C2=A0 =C2=A0 =C2=A0+=3D fpga=
=2Eo
> =C2=A0endif
>
> +# GPIO
> +obj-$(CONFIG_ARCH_OMAP730) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D gpio7xx.o
> +obj-$(CONFIG_ARCH_OMAP850) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D gpio7xx.o
> +obj-$(CONFIG_ARCH_OMAP15XX) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
+=3D gpio15xx.o
> +obj-$(CONFIG_ARCH_OMAP16XX) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
+=3D gpio16xx.o
> +
> =C2=A0# LEDs support
> =C2=A0led-$(CONFIG_MACH_OMAP_H2) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +=3D leds-h2p2-debug.o
> =C2=A0led-$(CONFIG_MACH_OMAP_H3) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 +=3D leds-h2p2-debug.o
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/c=
lock_data.c
> index af54114..423d21d 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -143,7 +143,7 @@ static struct arm_idlect1_clk armper_ck =3D {
> =C2=A0* activation. =C2=A0[ GPIO code for 1510 ]
> =C2=A0*/
> =C2=A0static struct clk arm_gpio_ck =3D {
> - =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
arm_gpio_ck",
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
ick",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.ops =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D &clkops_generic,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &c=
k_dpll1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 ENABLE_ON_INIT,
> @@ -684,7 +684,7 @@ static struct omap_clk omap_clks[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "ck_sossi",=
 =C2=A0 =C2=A0 &sossi_ck, =C2=A0 =C2=A0 =C2=A0CK_16XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "arm_ck", =C2=
=A0 =C2=A0 =C2=A0 &arm_ck, =C2=A0 =C2=A0 =C2=A0 =C2=A0CK_16XX | CK_1510=
 | CK_310),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "armper_ck"=
, =C2=A0 =C2=A0&armper_ck.clk, CK_16XX | CK_1510 | CK_310),
> - =C2=A0 =C2=A0 =C2=A0 CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "arm_gpio_ck", =
=C2=A0&arm_gpio_ck, =C2=A0 CK_1510 | CK_310),
> + =C2=A0 =C2=A0 =C2=A0 CLK("omap_gpio.0", "ick", =C2=A0 =C2=A0 =C2=A0=
 &arm_gpio_ck, =C2=A0 CK_1510 | CK_310),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "armxor_ck"=
, =C2=A0 =C2=A0&armxor_ck.clk, CK_16XX | CK_1510 | CK_310 | CK_7XX),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK(NULL, =C2=A0 =C2=A0 =C2=A0 "armtim_ck"=
, =C2=A0 =C2=A0&armtim_ck.clk, CK_16XX | CK_1510 | CK_310),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CLK("omap_wdt", "fck", =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&armwdt_ck.clk, CK_16XX | CK_1510 | CK_310),
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index eb31c9c..31864e1 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>
> =C2=A0# Common support
> =C2=A0obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o =
timer-gp.o pm.o \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0common.o
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0common.o gpio.o
>
> =C2=A0omap-2-3-common =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D irq.=
o sdrc.o prm2xxx_3xxx.o
> =C2=A0hwmod-common =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap_hwmod.o \
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 610787c..d04ded2 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -21,6 +21,8 @@
> =C2=A0#include <linux/err.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>
> =C2=A0#include <mach/hardware.h>
> =C2=A0#include <asm/irq.h>
> @@ -32,7 +34,6 @@
> =C2=A0/*
> =C2=A0* OMAP1510 GPIO registers
> =C2=A0*/
> -#define OMAP1510_GPIO_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffce000
> =C2=A0#define OMAP1510_GPIO_DATA_INPUT =C2=A0 =C2=A0 =C2=A0 0x00
> =C2=A0#define OMAP1510_GPIO_DATA_OUTPUT =C2=A0 =C2=A0 =C2=A00x04
> =C2=A0#define OMAP1510_GPIO_DIR_CONTROL =C2=A0 =C2=A0 =C2=A00x08
> @@ -46,10 +47,6 @@
> =C2=A0/*
> =C2=A0* OMAP1610 specific GPIO registers
> =C2=A0*/
> -#define OMAP1610_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0xfffbe400
> -#define OMAP1610_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0xfffbec00
> -#define OMAP1610_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0xfffbb400
> -#define OMAP1610_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0xfffbbc00
> =C2=A0#define OMAP1610_GPIO_REVISION =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00=
00
> =C2=A0#define OMAP1610_GPIO_SYSCONFIG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0010
> =C2=A0#define OMAP1610_GPIO_SYSSTATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0014
> @@ -71,12 +68,6 @@
> =C2=A0/*
> =C2=A0* OMAP7XX specific GPIO registers
> =C2=A0*/
> -#define OMAP7XX_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbc000
> -#define OMAP7XX_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbc800
> -#define OMAP7XX_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbd000
> -#define OMAP7XX_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbd800
> -#define OMAP7XX_GPIO5_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbe000
> -#define OMAP7XX_GPIO6_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffbe800
> =C2=A0#define OMAP7XX_GPIO_DATA_INPUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x00
> =C2=A0#define OMAP7XX_GPIO_DATA_OUTPUT =C2=A0 =C2=A0 =C2=A0 0x04
> =C2=A0#define OMAP7XX_GPIO_DIR_CONTROL =C2=A0 =C2=A0 =C2=A0 0x08
> @@ -84,25 +75,10 @@
> =C2=A0#define OMAP7XX_GPIO_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x10
> =C2=A0#define OMAP7XX_GPIO_INT_STATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x14
>
> -#define OMAP1_MPUIO_VBASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0OMAP1_MPUIO_BASE
> -
> =C2=A0/*
> - * omap24xx specific GPIO registers
> + * omap2+ specific GPIO registers
> =C2=A0*/
> -#define OMAP242X_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x48018000
> -#define OMAP242X_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x4801a000
> -#define OMAP242X_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x4801c000
> -#define OMAP242X_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x4801e000
> -
> -#define OMAP243X_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x4900C000
> -#define OMAP243X_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x4900E000
> -#define OMAP243X_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49010000
> -#define OMAP243X_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49012000
> -#define OMAP243X_GPIO5_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x480B6000
> -
> =C2=A0#define OMAP24XX_GPIO_REVISION =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00=
00
> -#define OMAP24XX_GPIO_SYSCONFIG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0010
> -#define OMAP24XX_GPIO_SYSSTATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0014
> =C2=A0#define OMAP24XX_GPIO_IRQSTATUS1 =C2=A0 =C2=A0 =C2=A0 0x0018
> =C2=A0#define OMAP24XX_GPIO_IRQSTATUS2 =C2=A0 =C2=A0 =C2=A0 0x0028
> =C2=A0#define OMAP24XX_GPIO_IRQENABLE2 =C2=A0 =C2=A0 =C2=A0 0x002c
> @@ -126,7 +102,6 @@
> =C2=A0#define OMAP24XX_GPIO_SETDATAOUT =C2=A0 =C2=A0 =C2=A0 0x0094
>
> =C2=A0#define OMAP4_GPIO_REVISION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0000
> -#define OMAP4_GPIO_SYSCONFIG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00=
10
> =C2=A0#define OMAP4_GPIO_EOI =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0020
> =C2=A0#define OMAP4_GPIO_IRQSTATUSRAW0 =C2=A0 =C2=A0 =C2=A0 0x0024
> =C2=A0#define OMAP4_GPIO_IRQSTATUSRAW1 =C2=A0 =C2=A0 =C2=A0 0x0028
> @@ -138,7 +113,6 @@
> =C2=A0#define OMAP4_GPIO_IRQSTATUSCLR1 =C2=A0 =C2=A0 =C2=A0 0x0040
> =C2=A0#define OMAP4_GPIO_IRQWAKEN0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x0044
> =C2=A0#define OMAP4_GPIO_IRQWAKEN1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x0048
> -#define OMAP4_GPIO_SYSSTATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01=
14
> =C2=A0#define OMAP4_GPIO_IRQENABLE1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x011c
> =C2=A0#define OMAP4_GPIO_WAKE_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0120
> =C2=A0#define OMAP4_GPIO_IRQSTATUS2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x0128
> @@ -159,26 +133,6 @@
> =C2=A0#define OMAP4_GPIO_SETWKUENA =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x0184
> =C2=A0#define OMAP4_GPIO_CLEARDATAOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0190
> =C2=A0#define OMAP4_GPIO_SETDATAOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x0194
> -/*
> - * omap34xx specific GPIO registers
> - */
> -
> -#define OMAP34XX_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x48310000
> -#define OMAP34XX_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49050000
> -#define OMAP34XX_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49052000
> -#define OMAP34XX_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49054000
> -#define OMAP34XX_GPIO5_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49056000
> -#define OMAP34XX_GPIO6_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x49058000
> -
> -/*
> - * OMAP44XX =C2=A0specific GPIO registers
> - */
> -#define OMAP44XX_GPIO1_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x4a310000
> -#define OMAP44XX_GPIO2_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x48055000
> -#define OMAP44XX_GPIO3_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x48057000
> -#define OMAP44XX_GPIO4_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x48059000
> -#define OMAP44XX_GPIO5_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x4805B000
> -#define OMAP44XX_GPIO6_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x4805D000
>
> =C2=A0struct gpio_bank {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pbase;
> @@ -203,97 +157,12 @@ struct gpio_bank {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk *dbck;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mod_usage;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dbck_enable_mask;
> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
> + =C2=A0 =C2=A0 =C2=A0 bool dbck_flag;
> =C2=A0};
>
> -#ifdef CONFIG_ARCH_OMAP16XX
> -static struct gpio_bank gpio_bank_1610[5] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO=
_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_MPUIO },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1610_GPIO1_BASE, NULL, INT_GPIO_BANK1, I=
H_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_1610 }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1610_GPIO2_BASE, NULL, INT_1610_GPIO_BAN=
K2, IH_GPIO_BASE + 16,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_1610 }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1610_GPIO3_BASE, NULL, INT_1610_GPIO_BAN=
K3, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_1610 }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1610_GPIO4_BASE, NULL, INT_1610_GPIO_BAN=
K4, IH_GPIO_BASE + 48,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_1610 }=
,
> -};
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP15XX
> -static struct gpio_bank gpio_bank_1510[2] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO=
_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_MPUIO },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1510_GPIO_BASE, NULL, INT_GPIO_BANK1, IH=
_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_1510 }
> -};
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> -static struct gpio_bank gpio_bank_7xx[7] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP1_MPUIO_VBASE, NULL, INT_7XX_MPUIO, IH_M=
PUIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_MPUIO },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO1_BASE, NULL, INT_7XX_GPIO_BANK1=
, IH_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO2_BASE, NULL, INT_7XX_GPIO_BANK2=
, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO3_BASE, NULL, INT_7XX_GPIO_BANK3=
, IH_GPIO_BASE + 64,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO4_BASE, NULL, INT_7XX_GPIO_BANK4=
, =C2=A0IH_GPIO_BASE + 96,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO5_BASE, NULL, INT_7XX_GPIO_BANK5=
, =C2=A0IH_GPIO_BASE + 128,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> - =C2=A0 =C2=A0 =C2=A0 { OMAP7XX_GPIO6_BASE, NULL, INT_7XX_GPIO_BANK6=
, =C2=A0IH_GPIO_BASE + 160,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_7XX },
> -};
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -
> -static struct gpio_bank gpio_bank_242x[4] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP242X_GPIO1_BASE, NULL, INT_24XX_GPIO_BAN=
K1, IH_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP242X_GPIO2_BASE, NULL, INT_24XX_GPIO_BAN=
K2, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP242X_GPIO3_BASE, NULL, INT_24XX_GPIO_BAN=
K3, IH_GPIO_BASE + 64,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP242X_GPIO4_BASE, NULL, INT_24XX_GPIO_BAN=
K4, IH_GPIO_BASE + 96,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> -};
> -
> -static struct gpio_bank gpio_bank_243x[5] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP243X_GPIO1_BASE, NULL, INT_24XX_GPIO_BAN=
K1, IH_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP243X_GPIO2_BASE, NULL, INT_24XX_GPIO_BAN=
K2, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP243X_GPIO3_BASE, NULL, INT_24XX_GPIO_BAN=
K3, IH_GPIO_BASE + 64,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP243X_GPIO4_BASE, NULL, INT_24XX_GPIO_BAN=
K4, IH_GPIO_BASE + 96,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP243X_GPIO5_BASE, NULL, INT_24XX_GPIO_BAN=
K5, IH_GPIO_BASE + 128,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> -};
> -
> -#endif
> -
> =C2=A0#ifdef CONFIG_ARCH_OMAP3
> -static struct gpio_bank gpio_bank_34xx[6] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BAN=
K1, IH_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO2_BASE, NULL, INT_34XX_GPIO_BAN=
K2, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO3_BASE, NULL, INT_34XX_GPIO_BAN=
K3, IH_GPIO_BASE + 64,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO4_BASE, NULL, INT_34XX_GPIO_BAN=
K4, IH_GPIO_BASE + 96,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO5_BASE, NULL, INT_34XX_GPIO_BAN=
K5, IH_GPIO_BASE + 128,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP34XX_GPIO6_BASE, NULL, INT_34XX_GPIO_BAN=
K6, IH_GPIO_BASE + 160,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_24XX }=
,
> -};
> -
> =C2=A0struct omap3_gpio_regs {
> - =C2=A0 =C2=A0 =C2=A0 u32 sysconfig;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 irqenable1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 irqenable2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 wake_en;
> @@ -309,25 +178,14 @@ struct omap3_gpio_regs {
> =C2=A0static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
> =C2=A0#endif
>
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct gpio_bank gpio_bank_44xx[6] =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO1_BASE, NULL, OMAP44XX_IRQ_GPIO=
1, IH_GPIO_BASE,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO2_BASE, NULL, OMAP44XX_IRQ_GPIO=
2, IH_GPIO_BASE + 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO3_BASE, NULL, OMAP44XX_IRQ_GPIO=
3, IH_GPIO_BASE + 64,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO4_BASE, NULL, OMAP44XX_IRQ_GPIO=
4, IH_GPIO_BASE + 96,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO5_BASE, NULL, OMAP44XX_IRQ_GPIO=
5, IH_GPIO_BASE + 128,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> - =C2=A0 =C2=A0 =C2=A0 { OMAP44XX_GPIO6_BASE, NULL, OMAP44XX_IRQ_GPIO=
6, IH_GPIO_BASE + 160,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 METHOD_GPIO_44XX }=
,
> -};
> +/*
> + * TODO: Cleanup gpio_bank usage as it is having information
> + * related to all instances of the device
> + */
> +static struct gpio_bank *gpio_bank;
>
> -#endif
> +static int bank_width;
>
> -static struct gpio_bank *gpio_bank;
> =C2=A0/* TODO: Analyze removing gpio_bank_count usage from driver cod=
e */
> =C2=A0int gpio_bank_count;
>
> @@ -634,6 +492,9 @@ static void _set_gpio_debounce(struct gpio_bank *=
bank, unsigned gpio,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l;
>
> + =C2=A0 =C2=A0 =C2=A0 if (!bank->dbck_flag)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (debounce < 32)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debounce =3D 0=
x01;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (debounce > 7936)
> @@ -643,7 +504,7 @@ static void _set_gpio_debounce(struct gpio_bank *=
bank, unsigned gpio,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0l =3D 1 << get_gpio_index(gpio);
>
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap44xx())
> + =C2=A0 =C2=A0 =C2=A0 if (bank->method =3D=3D METHOD_GPIO_44XX)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D OMAP4=
_GPIO_DEBOUNCINGTIME;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D OMAP2=
4XX_GPIO_DEBOUNCE_VAL;
> @@ -651,7 +512,7 @@ static void _set_gpio_debounce(struct gpio_bank *=
bank, unsigned gpio,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__raw_writel(debounce, reg);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D bank->base;
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap44xx())
> + =C2=A0 =C2=A0 =C2=A0 if (bank->method =3D=3D METHOD_GPIO_44XX)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D OMAP4=
_GPIO_DEBOUNCENABLE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D OMAP2=
4XX_GPIO_DEBOUNCE_EN;
> @@ -660,12 +521,10 @@ static void _set_gpio_debounce(struct gpio_bank=
 *bank, unsigned gpio,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (debounce) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D l;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34x=
x() || cpu_is_omap44xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_enable(bank->dbck);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(bank->d=
bck);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val &=3D ~l;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34x=
x() || cpu_is_omap44xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_disable(bank->dbck);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(bank->=
dbck);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bank->dbck_enable_mask =3D val;
>
> @@ -1537,7 +1396,8 @@ static struct platform_device omap_mpuio_device=
 =3D {
>
> =C2=A0static inline void mpuio_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(&omap_mpuio_device, &gpio=
_bank_1610[0]);
> + =C2=A0 =C2=A0 =C2=A0 struct gpio_bank *bank =3D get_gpio_bank(OMAP_=
MPUIO(0));
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(&omap_mpuio_device, bank)=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (platform_driver_register(&omap_mpuio_d=
river) =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void) platfor=
m_device_register(&omap_mpuio_device);
> @@ -1642,6 +1502,13 @@ static int gpio_debounce(struct gpio_chip *chi=
p, unsigned offset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bank =3D container_of(chip, struct gpio_ba=
nk, chip);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!bank->dbck) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->dbck =3D clk=
_get(bank->dev, "dbclk");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(bank->d=
bck))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(bank->dev, "Could not get gpio dbck\n");
> + =C2=A0 =C2=A0 =C2=A0 }
> +

I'm testing this on omap7xx, which doesn't have a dbclk.  Even with
dbck_flag set to false, this code still runs, causing these messages
to show up:

    omap_gpio omap_gpio.5: Could not get gpio dbck
    omap_gpio omap_gpio.6: Could not get gpio dbck

I think that 'if' should be:

    if (bank->dbck_flag && !bank->dbck) {

Also, see my comments in patch 4 - OMAP7xx: GPIO: Introduce support
for GPIO init, as there's dbck_flag entries there that are needed for
omap7xx.  Otherwise, seems to work well.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
