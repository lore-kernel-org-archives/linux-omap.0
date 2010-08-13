From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] OMAP McSPI: Adapt McSPI driver to use omap hwmod
Date: Fri, 13 Aug 2010 17:09:08 -0600
Message-ID: <AANLkTi=qN2nOJ4nRmS=C0kBa7y3=13iQ-ZEHHw5FeGne@mail.gmail.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com> <1281708323-18989-3-git-send-email-charu@ti.com>
 <1281708323-18989-4-git-send-email-charu@ti.com> <1281708323-18989-5-git-send-email-charu@ti.com>
 <1281708323-18989-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48201 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab0HMXJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 19:09:29 -0400
Received: by gwj17 with SMTP id 17so178070gwj.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 16:09:28 -0700 (PDT)
In-Reply-To: <1281708323-18989-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, govindraj.raja@ti.com

On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
> From: Govindraj.R <govindraj.raja@ti.com>
>
> This patch converts the McSPI driver to use pm_runtime apis while
> implementing it in HWMOD FW way.

Hi Govindraj,

Some comments below.  Short version is that this patch seems to lump a
number of (mostly) unrelated changes (the register map, HWMOD stuff,
and runtime pm) that makes it hard to review and understand.  I could
use some help understanding what the intent of the patch is, and it
would also help to split it up.

Cheers,
g.

>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 | =A0233 +++++++=
+++-----------------
> =A0arch/arm/plat-omap/include/plat/mcspi.h | =A0 27 +++
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0273 +++=
+++++++---------------------
> =A04 files changed, 204 insertions(+), 333 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-oma=
p2/clock3xxx_data.c
> index 138646d..9482e4d 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -1558,6 +1558,7 @@ static struct clk mcspi4_fck =3D {
> =A0 =A0 =A0 =A0.enable_reg =A0 =A0 =3D OMAP_CM_REGADDR(CORE_MOD, CM_F=
CLKEN1),
> =A0 =A0 =A0 =A0.enable_bit =A0 =A0 =3D OMAP3430_EN_MCSPI4_SHIFT,
> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &followparent_recalc,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "core_l4_clkdm",
> =A0};
>
> =A0static struct clk mcspi3_fck =3D {
> @@ -1567,6 +1568,7 @@ static struct clk mcspi3_fck =3D {
> =A0 =A0 =A0 =A0.enable_reg =A0 =A0 =3D OMAP_CM_REGADDR(CORE_MOD, CM_F=
CLKEN1),
> =A0 =A0 =A0 =A0.enable_bit =A0 =A0 =3D OMAP3430_EN_MCSPI3_SHIFT,
> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &followparent_recalc,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "core_l4_clkdm",
> =A0};
>
> =A0static struct clk mcspi2_fck =3D {
> @@ -1576,6 +1578,7 @@ static struct clk mcspi2_fck =3D {
> =A0 =A0 =A0 =A0.enable_reg =A0 =A0 =3D OMAP_CM_REGADDR(CORE_MOD, CM_F=
CLKEN1),
> =A0 =A0 =A0 =A0.enable_bit =A0 =A0 =3D OMAP3430_EN_MCSPI2_SHIFT,
> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &followparent_recalc,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "core_l4_clkdm",
> =A0};
>
> =A0static struct clk mcspi1_fck =3D {
> @@ -1585,6 +1588,7 @@ static struct clk mcspi1_fck =3D {
> =A0 =A0 =A0 =A0.enable_reg =A0 =A0 =3D OMAP_CM_REGADDR(CORE_MOD, CM_F=
CLKEN1),
> =A0 =A0 =A0 =A0.enable_bit =A0 =A0 =3D OMAP3430_EN_MCSPI1_SHIFT,
> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &followparent_recalc,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "core_l4_clkdm",
> =A0};
>
> =A0static struct clk uart2_fck =3D {
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index fa99da1..a869c35 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -15,6 +15,8 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/io.h>
> =A0#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
>
> =A0#include <mach/hardware.h>
> =A0#include <mach/irqs.h>
> @@ -239,170 +241,103 @@ static inline void omap_init_sti(void) {}
>
> =A0#include <plat/mcspi.h>
>
> -#define OMAP2_MCSPI1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x48098000
> -#define OMAP2_MCSPI2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x4809a000
> -#define OMAP2_MCSPI3_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x480b8000
> -#define OMAP2_MCSPI4_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x480ba000
> -
> -#define OMAP4_MCSPI1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x48098100
> -#define OMAP4_MCSPI2_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x4809a100
> -#define OMAP4_MCSPI3_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x480b8100
> -#define OMAP4_MCSPI4_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A00x480ba100
> -
> -static struct omap2_mcspi_platform_config omap2_mcspi1_config =3D {
> - =A0 =A0 =A0 .num_cs =A0 =A0 =A0 =A0 =3D 4,
> - =A0 =A0 =A0 .force_cs_mode =A0=3D 1,
> -};
> -
> -static struct resource omap2_mcspi1_resources[] =3D {
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP2_MCS=
PI1_BASE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP2_M=
CSPI1_BASE + 0xff,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURC=
E_MEM,
> - =A0 =A0 =A0 },
> -};
> -
> -static struct platform_device omap2_mcspi1 =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2_mcspi",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> - =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(omap2_mcspi1_resources=
),
> - =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D omap2_mcspi1_resources,
> - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &omap2_mcspi1_config=
,
> - =A0 =A0 =A0 },
> -};
> -
> -static struct omap2_mcspi_platform_config omap2_mcspi2_config =3D {
> - =A0 =A0 =A0 .num_cs =A0 =A0 =A0 =A0 =3D 2,
> - =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =3D OMAP2_MCSPI_MASTER,
> - =A0 =A0 =A0 .dma_mode =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .force_cs_mode =A0=3D 0,
> - =A0 =A0 =A0 .fifo_depth =A0 =A0 =3D 0,
> -};
> -
> -static struct resource omap2_mcspi2_resources[] =3D {
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP2_MCS=
PI2_BASE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP2_M=
CSPI2_BASE + 0xff,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURC=
E_MEM,
> - =A0 =A0 =A0 },
> -};
> -
> -static struct platform_device omap2_mcspi2 =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2_mcspi",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 2,
> - =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(omap2_mcspi2_resources=
),
> - =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D omap2_mcspi2_resources,
> - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &omap2_mcspi2_config=
,
> - =A0 =A0 =A0 },
> -};
> -
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
> - =A0 =A0 =A0 defined(CONFIG_ARCH_OMAP4)
> -static struct omap2_mcspi_platform_config omap2_mcspi3_config =3D {
> - =A0 =A0 =A0 .num_cs =A0 =A0 =A0 =A0 =3D 2,
> -};
> -
> -static struct resource omap2_mcspi3_resources[] =3D {
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP2_MCSPI3_BASE,
> - =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP2_MCSPI3_BASE + 0xf=
f,
> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> - =A0 =A0 =A0 },
> -};
> -
> -static struct platform_device omap2_mcspi3 =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2_mcspi",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 3,
> - =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(omap2_mcspi3_resources=
),
> - =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D omap2_mcspi3_resources,
> - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &omap2_mcspi3_config=
,
> - =A0 =A0 =A0 },
> -};
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -static struct omap2_mcspi_platform_config omap2_mcspi4_config =3D {
> - =A0 =A0 =A0 .num_cs =A0 =A0 =A0 =A0 =3D 1,
> -};
> -
> -static struct resource omap2_mcspi4_resources[] =3D {
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0 =A0 =A0 =A0 =A0=3D OMAP2_MCS=
PI4_BASE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP2_M=
CSPI4_BASE + 0xff,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D IORESOURC=
E_MEM,
> - =A0 =A0 =A0 },
> -};
> -
> -static struct platform_device omap2_mcspi4 =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap2_mcspi",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 4,
> - =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(omap2_mcspi4_resources=
),
> - =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D omap2_mcspi4_resources,
> - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &omap2_mcspi4_config=
,
> - =A0 =A0 =A0 },
> -};
> -#endif
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static inline void omap4_mcspi_fixup(void)
> +struct omap_device_pm_latency omap_mcspi_latency[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enab=
le_hwmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =3D OMAP_DEV=
ICE_LATENCY_AUTO_ADJUST,
> + =A0 =A0 =A0 },
> +};
> +
> +static const u16 omap2_reg_map[] =3D {
> + =A0 =A0 =A0 [OMAP2_MCSPI_REVISION] =A0 =A0 =A0 =A0 =A0=3D 0x00,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYSCONFIG] =A0 =A0 =A0 =A0 =3D 0x10,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYSSTATUS] =A0 =A0 =A0 =A0 =3D 0x14,
> + =A0 =A0 =A0 [OMAP2_MCSPI_IRQSTATUS] =A0 =A0 =A0 =A0 =3D 0x18,
> + =A0 =A0 =A0 [OMAP2_MCSPI_IRQENABLE] =A0 =A0 =A0 =A0 =3D 0x1c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_WAKEUPENABLE] =A0 =A0 =A0=3D 0x20,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYST] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x24,
> + =A0 =A0 =A0 [OMAP2_MCSPI_MODULCTRL] =A0 =A0 =A0 =A0 =3D 0x28,
> + =A0 =A0 =A0 [OMAP2_MCSPI_XFERLEVEL] =A0 =A0 =A0 =A0 =3D 0x7c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHCONF0] =A0 =A0 =A0 =A0 =A0 =3D 0x2c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHSTAT0] =A0 =A0 =A0 =A0 =A0 =3D 0x30,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHCTRL0] =A0 =A0 =A0 =A0 =A0 =3D 0x34,
> + =A0 =A0 =A0 [OMAP2_MCSPI_TX0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x38,
> + =A0 =A0 =A0 [OMAP2_MCSPI_RX0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x3c,
> +};
> +
> +static const u16 omap4_reg_map[] =3D {
> + =A0 =A0 =A0 [OMAP2_MCSPI_REVISION] =A0 =A0 =A0 =A0 =A0=3D 0x100,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYSCONFIG] =A0 =A0 =A0 =A0 =3D 0x110,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYSSTATUS] =A0 =A0 =A0 =A0 =3D 0x114,
> + =A0 =A0 =A0 [OMAP2_MCSPI_IRQSTATUS] =A0 =A0 =A0 =A0 =3D 0x118,
> + =A0 =A0 =A0 [OMAP2_MCSPI_IRQENABLE] =A0 =A0 =A0 =A0 =3D 0x01c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_WAKEUPENABLE] =A0 =A0 =A0=3D 0x120,
> + =A0 =A0 =A0 [OMAP2_MCSPI_SYST] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x124=
,
> + =A0 =A0 =A0 [OMAP2_MCSPI_MODULCTRL] =A0 =A0 =A0 =A0 =3D 0x128,
> + =A0 =A0 =A0 [OMAP2_MCSPI_XFERLEVEL] =A0 =A0 =A0 =A0 =3D 0x17c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHCONF0] =A0 =A0 =A0 =A0 =A0 =3D 0x12c,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHSTAT0] =A0 =A0 =A0 =A0 =A0 =3D 0x130,
> + =A0 =A0 =A0 [OMAP2_MCSPI_CHCTRL0] =A0 =A0 =A0 =A0 =A0 =3D 0x134,
> + =A0 =A0 =A0 [OMAP2_MCSPI_TX0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x138=
,
> + =A0 =A0 =A0 [OMAP2_MCSPI_RX0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x13c=
,
> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_REV] =A0 =A0 =A0 =A0 =A0 =A0=3D 0x000,
> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_HWINFO] =A0 =A0 =A0 =A0 =3D 0x004,
> + =A0 =A0 =A0 [OMAP2_MCSPI_HL_SYSCONFIG] =A0 =A0 =A0=3D 0x010,
> +};

Other than an 0x100 offset for omap4 and the addition of revision
registers, these two register maps are identical.  Is it really worth
having a complete register map table for two things that aren't really
different?  It looks overengineered.

Personally I'd handle this by having two base address pointers; the
regs pointer and the info/revision pointer.  omap4 would have the
revision base set, and omap2 would not.

> +
> +static int omap_mcspi_init(struct omap_hwmod *oh, void *user)
> =A0{
> - =A0 =A0 =A0 omap2_mcspi1_resources[0].start =3D OMAP4_MCSPI1_BASE;
> - =A0 =A0 =A0 omap2_mcspi1_resources[0].end =A0 =3D OMAP4_MCSPI1_BASE=
 + 0xff;
> - =A0 =A0 =A0 omap2_mcspi2_resources[0].start =3D OMAP4_MCSPI2_BASE;
> - =A0 =A0 =A0 omap2_mcspi2_resources[0].end =A0 =3D OMAP4_MCSPI2_BASE=
 + 0xff;
> - =A0 =A0 =A0 omap2_mcspi3_resources[0].start =3D OMAP4_MCSPI3_BASE;
> - =A0 =A0 =A0 omap2_mcspi3_resources[0].end =A0 =3D OMAP4_MCSPI3_BASE=
 + 0xff;
> - =A0 =A0 =A0 omap2_mcspi4_resources[0].start =3D OMAP4_MCSPI4_BASE;
> - =A0 =A0 =A0 omap2_mcspi4_resources[0].end =A0 =3D OMAP4_MCSPI4_BASE=
 + 0xff;
> -}
> -#else
> -static inline void omap4_mcspi_fixup(void)
> -{
> -}
> -#endif
> + =A0 =A0 =A0 struct omap_device *od;
> + =A0 =A0 =A0 char *name =3D "omap2_mcspi";
> + =A0 =A0 =A0 struct omap2_mcspi_platform_config *pdata;
> + =A0 =A0 =A0 static int spi_num;
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(struct omap2_mcspi_platform_co=
nfig),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\nMemory allocation for Mcspi d=
evice failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
>
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
> - =A0 =A0 =A0 defined(CONFIG_ARCH_OMAP4)
> -static inline void omap2_mcspi3_init(void)
> -{
> - =A0 =A0 =A0 platform_device_register(&omap2_mcspi3);
> -}
> -#else
> -static inline void omap2_mcspi3_init(void)
> -{
> -}
> -#endif
> + =A0 =A0 =A0 switch (spi_num) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->force_cs_mode =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->mode =3D OMAP2_MCSPI_MASTER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->dma_mode =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->force_cs_mode =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->fifo_depth =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->num_cs =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }

HWMOD appears to have the purpose of making device instantiation data
driven.  If so, shouldn't these parameters also be extracted from the
HWMOD data?

> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -static inline void omap2_mcspi4_init(void)
> -{
> - =A0 =A0 =A0 platform_device_register(&omap2_mcspi4);
> -}
> -#else
> -static inline void omap2_mcspi4_init(void)
> -{
> + =A0 =A0 =A0 if (cpu_is_omap44xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs_data =3D (u16 *)omap4_reg_m=
ap;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->regs_data =3D (u16 *)omap2_reg_m=
ap;
> +
> + =A0 =A0 =A0 od =3D omap_device_build(name, spi_num + 1, oh, pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
*pdata), omap_mcspi_latency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_S=
IZE(omap_mcspi_latency), 0);
> + =A0 =A0 =A0 WARN(IS_ERR(od), "\nCant build omap_device for %s:%s\n"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, o=
h->name);
> + =A0 =A0 =A0 spi_num++;
> + =A0 =A0 =A0 return 0;
> =A0}
> -#endif
>
> =A0static void omap_init_mcspi(void)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_mcspi_fixup();
> -
> - =A0 =A0 =A0 platform_device_register(&omap2_mcspi1);
> - =A0 =A0 =A0 platform_device_register(&omap2_mcspi2);
> -
> - =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_om=
ap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi3_init();
> -
> - =A0 =A0 =A0 if (cpu_is_omap343x() || cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi4_init();
> + =A0 =A0 =A0 omap_hwmod_for_each_by_class("mcspi", omap_mcspi_init, =
NULL);
> =A0}
> -
> =A0#else
> =A0static inline void omap_init_mcspi(void) {}
> =A0#endif
> diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-=
omap/include/plat/mcspi.h
> index 23b928b..27161be 100644
> --- a/arch/arm/plat-omap/include/plat/mcspi.h
> +++ b/arch/arm/plat-omap/include/plat/mcspi.h
> @@ -1,6 +1,10 @@
> =A0#ifndef _OMAP2_MCSPI_H
> =A0#define _OMAP2_MCSPI_H
>
> +#if defined CONFIG_ARCH_OMAP2PLUS
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +
> =A0#define OMAP2_MCSPI_MASTER =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0#define OMAP2_MCSPI_SLAVE =A0 =A0 =A0 =A0 =A0 =A0 =A01
>
> @@ -30,6 +34,7 @@ struct omap2_mcspi_platform_config {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0dma_mode;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0force_cs_mode;
> =A0 =A0 =A0 =A0unsigned short fifo_depth;
> + =A0 =A0 =A0 u16 =A0 =A0 *regs_data;
> =A0};
>
> =A0struct omap2_mcspi_device_config {
> @@ -39,4 +44,26 @@ struct omap2_mcspi_device_config {
> =A0 =A0 =A0 =A0unsigned single_channel:1;
> =A0};
>
> +enum {
> + =A0 =A0 =A0 OMAP2_MCSPI_REVISION =3D 0,
> + =A0 =A0 =A0 OMAP2_MCSPI_SYSCONFIG,
> + =A0 =A0 =A0 OMAP2_MCSPI_SYSSTATUS,
> + =A0 =A0 =A0 OMAP2_MCSPI_IRQSTATUS,
> + =A0 =A0 =A0 OMAP2_MCSPI_IRQENABLE,
> + =A0 =A0 =A0 OMAP2_MCSPI_WAKEUPENABLE,
> + =A0 =A0 =A0 OMAP2_MCSPI_SYST,
> + =A0 =A0 =A0 OMAP2_MCSPI_MODULCTRL,
> + =A0 =A0 =A0 OMAP2_MCSPI_XFERLEVEL,
> + =A0 =A0 =A0 OMAP2_MCSPI_CHCONF0,
> + =A0 =A0 =A0 OMAP2_MCSPI_CHSTAT0,
> + =A0 =A0 =A0 OMAP2_MCSPI_CHCTRL0,
> + =A0 =A0 =A0 OMAP2_MCSPI_TX0,
> + =A0 =A0 =A0 OMAP2_MCSPI_RX0,
> + =A0 =A0 =A0 OMAP2_MCSPI_HL_REV,
> + =A0 =A0 =A0 OMAP2_MCSPI_HL_HWINFO,
> + =A0 =A0 =A0 OMAP2_MCSPI_HL_SYSCONFIG,
> +};
> +
> +#endif
> +
> =A0#endif
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 0c9d1be..44a8bb0 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -33,6 +33,7 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include <linux/spi/spi.h>
>
> @@ -43,35 +44,11 @@
> =A0#define OMAP2_MCSPI_MAX_FREQ =A0 =A0 =A0 =A0 =A0 48000000
> =A0#define OMAP2_MCSPI_MAX_FIFODEPTH =A0 =A0 =A0 64
>
> -/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
> +/* OMAP2 has 3 SPI controllers, while OMAP3/4 has 4 */
> =A0#define OMAP2_MCSPI_MAX_CTRL =A0 =A0 =A0 =A0 =A0 4
>
> -#define OMAP2_MCSPI_REVISION =A0 =A0 =A0 =A0 =A0 0x00
> -#define OMAP2_MCSPI_SYSCONFIG =A0 =A0 =A0 =A0 =A00x10
> -#define OMAP2_MCSPI_SYSSTATUS =A0 =A0 =A0 =A0 =A00x14
> -#define OMAP2_MCSPI_IRQSTATUS =A0 =A0 =A0 =A0 =A00x18
> -#define OMAP2_MCSPI_IRQENABLE =A0 =A0 =A0 =A0 =A00x1c
> -#define OMAP2_MCSPI_WAKEUPENABLE =A0 =A0 =A0 0x20
> -#define OMAP2_MCSPI_SYST =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x24
> -#define OMAP2_MCSPI_MODULCTRL =A0 =A0 =A0 =A0 =A00x28
> -#define OMAP2_MCSPI_XFERLEVEL =A0 =A0 =A0 =A0 =A00x7c
> -
> -/* per-channel banks, 0x14 bytes each, first is: */
> -#define OMAP2_MCSPI_CHCONF0 =A0 =A0 =A0 =A0 =A0 =A00x2c
> -#define OMAP2_MCSPI_CHSTAT0 =A0 =A0 =A0 =A0 =A0 =A00x30
> -#define OMAP2_MCSPI_CHCTRL0 =A0 =A0 =A0 =A0 =A0 =A00x34
> -#define OMAP2_MCSPI_TX0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x38
> -#define OMAP2_MCSPI_RX0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x3c
> -
> =A0/* per-register bitmasks: */
>
> -#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE =A0 =A0 =A0 =A0BIT(4)
> -#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP =A0 =A0 =A0 =A0BIT(2)
> -#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE BIT(0)
> -#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET =A0 =A0 =A0 =A0BIT(1)
> -
> -#define OMAP2_MCSPI_SYSSTATUS_RESETDONE =A0 =A0 =A0 =A0BIT(0)
> -
> =A0#define OMAP2_MCSPI_MODULCTRL_SINGLE =A0 BIT(0)
> =A0#define OMAP2_MCSPI_MODULCTRL_MS =A0 =A0 =A0 BIT(2)
> =A0#define OMAP2_MCSPI_MODULCTRL_STEST =A0 =A0BIT(3)
> @@ -127,10 +104,9 @@ struct omap2_mcspi {
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0msg_queue;
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*ick;
> - =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*fck;
> =A0 =A0 =A0 =A0/* Virtual base address of the controller */
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *regs;

would void __iomem * be more appropriate for regs?  I imagine regs
should never be dereferenced directly.

> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 phys;
> =A0 =A0 =A0 =A0/* SPI1 has 4 channels, while SPI2 has 2 */
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*dma_channels;
> @@ -138,6 +114,7 @@ struct omap2_mcspi {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_mode=
;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0force_cs=
_mode;
> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifo_depth=
;
> + =A0 =A0 =A0 struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
> =A0};
>
> =A0struct omap2_mcspi_cs {
> @@ -153,7 +130,6 @@ struct omap2_mcspi_cs {
> =A0* corresponding registers are modified.
> =A0*/
> =A0struct omap2_mcspi_regs {
> - =A0 =A0 =A0 u32 sysconfig;
> =A0 =A0 =A0 =A0u32 modulctrl;
> =A0 =A0 =A0 =A0u32 wakeupenable;
> =A0 =A0 =A0 =A0struct list_head cs;
> @@ -206,29 +182,33 @@ static inline void mcspi_write_reg(struct spi_m=
aster *master,
> =A0{
> =A0 =A0 =A0 =A0struct omap2_mcspi *mcspi =3D spi_master_get_devdata(m=
aster);
>
> - =A0 =A0 =A0 __raw_writel(val, mcspi->base + idx);
> + =A0 =A0 =A0 __raw_writel(val, mcspi->base + mcspi->regs[idx]);
> =A0}
>
> =A0static inline u32 mcspi_read_reg(struct spi_master *master, int id=
x)
> =A0{
> =A0 =A0 =A0 =A0struct omap2_mcspi *mcspi =3D spi_master_get_devdata(m=
aster);
>
> - =A0 =A0 =A0 return __raw_readl(mcspi->base + idx);
> + =A0 =A0 =A0 return __raw_readl(mcspi->base + mcspi->regs[idx]);
> =A0}
>
> =A0static inline void mcspi_write_cs_reg(const struct spi_device *spi=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int idx, u32 val)
> =A0{
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs =3D spi->controller_stat=
e;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
>
> - =A0 =A0 =A0 __raw_writel(val, cs->base + =A0idx);
> + =A0 =A0 =A0 __raw_writel(val, cs->base + mcspi->regs[idx]);
> =A0}
>
> =A0static inline u32 mcspi_read_cs_reg(const struct spi_device *spi, =
int idx)
> =A0{
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs =3D spi->controller_stat=
e;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(ma=
ster);
>
> - =A0 =A0 =A0 return __raw_readl(cs->base + idx);
> + =A0 =A0 =A0 return __raw_readl(cs->base + mcspi->regs[idx]);
> =A0}
>
> =A0static inline u32 mcspi_cached_chconf0(const struct spi_device *sp=
i)
> @@ -454,32 +434,23 @@ static void omap2_mcspi_restore_ctx(struct omap=
2_mcspi *mcspi)
> =A0 =A0 =A0 =A0mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_ctx[spi_cn=
trl->bus_num - 1].modulctrl);
>
> - =A0 =A0 =A0 mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_ctx[spi_cnt=
rl->bus_num - 1].sysconfig);
> -
> =A0 =A0 =A0 =A0mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_ctx[spi_cn=
trl->bus_num - 1].wakeupenable);
>
> =A0 =A0 =A0 =A0list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bu=
s_num - 1].cs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(cs->chconf0, cs->base + OM=
AP2_MCSPI_CHCONF0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(cs->chconf0, cs->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->=
regs[OMAP2_MCSPI_CHCONF0]);
> =A0}
> -static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> +
> +static inline void omap2_mcspi_disable_clocks(struct omap2_mcspi *mc=
spi)
> =A0{
> - =A0 =A0 =A0 clk_disable(mcspi->ick);
> - =A0 =A0 =A0 clk_disable(mcspi->fck);
> + =A0 =A0 =A0 pm_runtime_put_sync(mcspi->dev);
> =A0}
>
> -static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
> +static inline int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcsp=
i)
> =A0{
> - =A0 =A0 =A0 if (clk_enable(mcspi->ick))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 if (clk_enable(mcspi->fck))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 omap2_mcspi_restore_ctx(mcspi);
> -
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return pm_runtime_get_sync(mcspi->dev);
> =A0}
>
> =A0static unsigned
> @@ -499,7 +470,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, stru=
ct spi_transfer *xfer)
>
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
> - =A0 =A0 =A0 irqstat_reg =3D mcspi->base + OMAP2_MCSPI_IRQSTATUS;
> + =A0 =A0 =A0 irqstat_reg =3D mcspi->base + mcspi->regs[OMAP2_MCSPI_I=
RQSTATUS];
> =A0 =A0 =A0 =A0l =3D mcspi_cached_chconf0(spi);
>
> =A0 =A0 =A0 =A0count =3D xfer->len;
> @@ -507,8 +478,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, stru=
ct spi_transfer *xfer)
> =A0 =A0 =A0 =A0word_len =3D cs->word_len;
>
> =A0 =A0 =A0 =A0base =3D cs->phys;
> - =A0 =A0 =A0 tx_reg =3D base + OMAP2_MCSPI_TX0;
> - =A0 =A0 =A0 rx_reg =3D base + OMAP2_MCSPI_RX0;
> + =A0 =A0 =A0 tx_reg =3D base + mcspi->regs[OMAP2_MCSPI_TX0];
> + =A0 =A0 =A0 rx_reg =3D base + mcspi->regs[OMAP2_MCSPI_RX0];
> =A0 =A0 =A0 =A0rx =3D xfer->rx_buf;
> =A0 =A0 =A0 =A0tx =3D xfer->tx_buf;
>
> @@ -692,9 +663,9 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, stru=
ct spi_transfer *xfer)
>
> =A0 =A0 =A0 =A0/* We store the pre-calculated register addresses on s=
tack to speed
> =A0 =A0 =A0 =A0 * up the transfer loop. */
> - =A0 =A0 =A0 tx_reg =A0 =A0 =A0 =A0 =A0=3D base + OMAP2_MCSPI_TX0;
> - =A0 =A0 =A0 rx_reg =A0 =A0 =A0 =A0 =A0=3D base + OMAP2_MCSPI_RX0;
> - =A0 =A0 =A0 chstat_reg =A0 =A0 =A0=3D base + OMAP2_MCSPI_CHSTAT0;
> + =A0 =A0 =A0 tx_reg =A0 =A0 =A0 =A0 =A0=3D base + mcspi->regs[OMAP2_=
MCSPI_TX0];
> + =A0 =A0 =A0 rx_reg =A0 =A0 =A0 =A0 =A0=3D base + mcspi->regs[OMAP2_=
MCSPI_RX0];
> + =A0 =A0 =A0 chstat_reg =A0 =A0 =A0=3D base + mcspi->regs[OMAP2_MCSP=
I_CHSTAT0];
>
> =A0 =A0 =A0 =A0if (word_len <=3D 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx;
> @@ -1047,7 +1018,7 @@ static int omap2_mcspi_setup(struct spi_device =
*spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (omap2_mcspi_enable_clocks(mcspi))
> + =A0 =A0 =A0 if (omap2_mcspi_enable_clocks(mcspi) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> =A0 =A0 =A0 =A0ret =3D omap2_mcspi_setup_transfer(spi, NULL);
> @@ -1091,10 +1062,11 @@ static void omap2_mcspi_work(struct work_stru=
ct *work)
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
>
> =A0 =A0 =A0 =A0mcspi =3D container_of(work, struct omap2_mcspi, work)=
;
> - =A0 =A0 =A0 spin_lock_irq(&mcspi->lock);
>
> =A0 =A0 =A0 =A0if (omap2_mcspi_enable_clocks(mcspi))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 spin_lock_irq(&mcspi->lock);
>
> =A0 =A0 =A0 =A0/* We only enable one channel at a time -- the one who=
se message is
> =A0 =A0 =A0 =A0 * at the head of the queue -- although this controlle=
r would gladly
> @@ -1169,7 +1141,7 @@ static void omap2_mcspi_work(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RX_=
ONLY mode needs dummy data in TX reg */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t-=
>tx_buf =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__raw_writel(0, cs->base
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP2_MCSPI_TX0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + mcspi->regs[OMAP2_MCSPI_TX0]);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (m-=
>is_dma_mapped ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0t->len >=3D DMA_MIN_BYTES ||
> @@ -1218,10 +1190,9 @@ static void omap2_mcspi_work(struct work_struc=
t *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(&mcspi->lock);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap2_mcspi_disable_clocks(mcspi);
> -
> -out:
> =A0 =A0 =A0 =A0spin_unlock_irq(&mcspi->lock);
> +
> + =A0 =A0 =A0 omap2_mcspi_disable_clocks(mcspi);
> =A0}
>
> =A0static int omap2_mcspi_transfer(struct spi_device *spi, struct spi=
_message *m)
> @@ -1315,21 +1286,9 @@ static int __init omap2_mcspi_reset(struct oma=
p2_mcspi *mcspi)
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D =
0;
>
> - =A0 =A0 =A0 if (omap2_mcspi_enable_clocks(mcspi))
> + =A0 =A0 =A0 if (omap2_mcspi_enable_clocks(mcspi) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_MCSPI_SYSCONFIG_S=
OFTRESET);
> - =A0 =A0 =A0 do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D mcspi_read_reg(master, OMAP2_MC=
SPI_SYSSTATUS);
> - =A0 =A0 =A0 } while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
> -
> - =A0 =A0 =A0 tmp =3D OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP2_MCSPI_SYSCONFIG_SMARTIDLE;
> - =A0 =A0 =A0 mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG, tmp);
> - =A0 =A0 =A0 omap2_mcspi_ctx[master->bus_num - 1].sysconfig =3D tmp;
> -
> =A0 =A0 =A0 =A0tmp =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp)=
;
> =A0 =A0 =A0 =A0omap2_mcspi_ctx[master->bus_num - 1].wakeupenable =3D =
tmp;
> @@ -1343,52 +1302,22 @@ static int __init omap2_mcspi_reset(struct om=
ap2_mcspi *mcspi)
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> -static u8 __initdata spi1_rxdma_id [] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_RX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_RX1,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_RX2,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_RX3,
> -};
> -
> -static u8 __initdata spi1_txdma_id [] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_TX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_TX1,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_TX2,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI1_TX3,
> -};
> -
> -static u8 __initdata spi2_rxdma_id[] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI2_RX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI2_RX1,
> -};
> -
> -static u8 __initdata spi2_txdma_id[] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI2_TX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI2_TX1,
> -};
> -
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
> - =A0 =A0 =A0 || defined(CONFIG_ARCH_OMAP4)
> -static u8 __initdata spi3_rxdma_id[] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI3_RX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI3_RX1,
> -};
> +static int omap_mcspi_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
>
> -static u8 __initdata spi3_txdma_id[] =3D {
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI3_TX0,
> - =A0 =A0 =A0 OMAP24XX_DMA_SPI3_TX1,
> -};
> -#endif
> +static int omap_mcspi_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct omap2_mcspi =A0 =A0 =A0*mcspi;
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master;
>
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -static u8 __initdata spi4_rxdma_id[] =3D {
> - =A0 =A0 =A0 OMAP34XX_DMA_SPI4_RX0,
> -};
> + =A0 =A0 =A0 master =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 omap2_mcspi_restore_ctx(mcspi);
>
> -static u8 __initdata spi4_txdma_id[] =3D {
> - =A0 =A0 =A0 OMAP34XX_DMA_SPI4_TX0,
> -};
> -#endif
> + =A0 =A0 =A0 return 0;
> +}
>
> =A0static int __init omap2_mcspi_probe(struct platform_device *pdev)
> =A0{
> @@ -1398,38 +1327,6 @@ static int __init omap2_mcspi_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *r;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D=
 0, i;
> - =A0 =A0 =A0 const u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rxdma_id, *txd=
ma_id;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_chipselect;
> -
> - =A0 =A0 =A0 switch (pdev->id) {
> - =A0 =A0 =A0 case 1:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdma_id =3D spi1_rxdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdma_id =3D spi1_txdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_chipselect =3D 4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case 2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdma_id =3D spi2_rxdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdma_id =3D spi2_txdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_chipselect =3D 2;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
> - =A0 =A0 =A0 || defined(CONFIG_ARCH_OMAP4)
> - =A0 =A0 =A0 case 3:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdma_id =3D spi3_rxdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdma_id =3D spi3_txdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_chipselect =3D 2;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> - =A0 =A0 =A0 case 4:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdma_id =3D spi4_rxdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdma_id =3D spi4_txdma_id;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_chipselect =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -#endif
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }

This seems appropriate.  It makes sense to make things like assigned
dma ids more data driven and remove the hard coded case tables.

>
> =A0 =A0 =A0 =A0master =3D spi_alloc_master(&pdev->dev, sizeof *mcspi)=
;
> =A0 =A0 =A0 =A0if (master =3D=3D NULL) {
> @@ -1446,7 +1343,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0master->setup =3D omap2_mcspi_setup;
> =A0 =A0 =A0 =A0master->transfer =3D omap2_mcspi_transfer;
> =A0 =A0 =A0 =A0master->cleanup =3D omap2_mcspi_cleanup;
> - =A0 =A0 =A0 master->num_chipselect =3D num_chipselect;
> + =A0 =A0 =A0 master->num_chipselect =3D pdata->num_cs;
>
> =A0 =A0 =A0 =A0dev_set_drvdata(&pdev->dev, master);
>
> @@ -1455,6 +1352,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0mcspi->mcspi_mode =3D OMAP2_MCSPI_MASTER;
> =A0 =A0 =A0 =A0mcspi->dma_mode =3D pdata->dma_mode;
> =A0 =A0 =A0 =A0mcspi->force_cs_mode =3D pdata->force_cs_mode;
> + =A0 =A0 =A0 mcspi->regs =3D pdata->regs_data;
>
> =A0 =A0 =A0 =A0if (pdata->fifo_depth <=3D OMAP2_MCSPI_MAX_FIFODEPTH)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->fifo_depth =3D pdata->fifo_dept=
h;
> @@ -1479,63 +1377,67 @@ static int __init omap2_mcspi_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0if (!mcspi->base) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "can't ioremap MCS=
PI\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1aa;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 mcspi->dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0INIT_WORK(&mcspi->work, omap2_mcspi_work);
>
> =A0 =A0 =A0 =A0spin_lock_init(&mcspi->lock);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&mcspi->msg_queue);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].c=
s);
>
> - =A0 =A0 =A0 mcspi->ick =3D clk_get(&pdev->dev, "ick");
> - =A0 =A0 =A0 if (IS_ERR(mcspi->ick)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "can't get mcspi_ic=
k\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(mcspi->ick);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1a;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 mcspi->fck =3D clk_get(&pdev->dev, "fck");
> - =A0 =A0 =A0 if (IS_ERR(mcspi->fck)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "can't get mcspi_fc=
k\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D PTR_ERR(mcspi->fck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> - =A0 =A0 =A0 }
> -

I'm obviously missing some context here.  The driver doesn't seem to
manage the clocks anymore.  What code does now?

> =A0 =A0 =A0 =A0mcspi->dma_channels =3D kcalloc(master->num_chipselect=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct omap2_mc=
spi_dma),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>
> =A0 =A0 =A0 =A0if (mcspi->dma_channels =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>
> - =A0 =A0 =A0 for (i =3D 0; i < num_chipselect; i++) {
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_cs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char dma_ch_name[14];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *dma_res;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(dma_ch_name, "rx%d", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_res =3D platform_get_resource_bynam=
e(pdev, IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_ch_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dma_res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "ca=
nnot get DMA RX channel\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->dma_channels[i].dma_rx_channel =
=3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->dma_channels[i].dma_rx_sync_dev =
=3D rxdma_id[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->dma_channels[i].dma_rx_sync_dev =
=3D dma_res->start;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(dma_ch_name, "tx%d", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_res =3D platform_get_resource_bynam=
e(pdev, IORESOURCE_DMA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_ch_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dma_res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "ca=
nnot get DMA TX channel\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->dma_channels[i].dma_tx_channel =
=3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->dma_channels[i].dma_tx_sync_dev =
=3D txdma_id[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi->dma_channels[i].dma_tx_sync_dev =
=3D dma_res->start;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (omap2_mcspi_reset(mcspi) < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
> + =A0 =A0 =A0 if (status || omap2_mcspi_reset(mcspi) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
>
> =A0 =A0 =A0 =A0status =3D spi_register_master(master);
> =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err4;
>
> =A0 =A0 =A0 =A0return status;
> -
> =A0err4:
> - =A0 =A0 =A0 kfree(mcspi->dma_channels);
> + =A0 =A0 =A0 spi_master_put(master);
> =A0err3:
> - =A0 =A0 =A0 clk_put(mcspi->fck);
> + =A0 =A0 =A0 kfree(mcspi->dma_channels);
> =A0err2:
> - =A0 =A0 =A0 clk_put(mcspi->ick);
> -err1a:
> - =A0 =A0 =A0 iounmap(mcspi->base);
> -err1aa:
> =A0 =A0 =A0 =A0release_mem_region(r->start, (r->end - r->start) + 1);
> + =A0 =A0 =A0 iounmap(mcspi->base);
> =A0err1:
> - =A0 =A0 =A0 spi_master_put(master);
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> @@ -1551,9 +1453,7 @@ static int __exit omap2_mcspi_remove(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0dma_channels =3D mcspi->dma_channels;
>
> - =A0 =A0 =A0 clk_put(mcspi->fck);
> - =A0 =A0 =A0 clk_put(mcspi->ick);
> -
> + =A0 =A0 =A0 omap2_mcspi_disable_clocks(mcspi);
> =A0 =A0 =A0 =A0r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0release_mem_region(r->start, (r->end - r->start) + 1);
>
> @@ -1568,15 +1468,20 @@ static int __exit omap2_mcspi_remove(struct p=
latform_device *pdev)
> =A0/* work with hotplug and coldplug */
> =A0MODULE_ALIAS("platform:omap2_mcspi");
>
> +static const struct dev_pm_ops omap_mcspi_dev_pm_ops =3D {
> + =A0 =A0 =A0 .runtime_suspend =3D omap_mcspi_runtime_suspend,
> + =A0 =A0 =A0 .runtime_resume =3D omap_mcspi_runtime_resume,
> +};
> +
> =A0static struct platform_driver omap2_mcspi_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D =A0 =A0 =A0 =A0 "omap2_mcspi"=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap2_mcspi",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &omap_mcspi_dev_pm_ops,

nit: Unrelated whitespace changes.

> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.remove =3D =A0 =A0 =A0 __exit_p(omap2_mcspi_remove),
> =A0};
>
> -
> =A0static int __init omap2_mcspi_init(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_mcspi_wq =3D create_singlethread_workqueue(
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
