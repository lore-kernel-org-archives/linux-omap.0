From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH] omap: cleanup NAND platform data
Date: Sat, 4 Jun 2011 02:44:41 +0530
Message-ID: <BANLkTimnP-HuvVruB5hNSMHVnQUmned8Pg@mail.gmail.com>
References: <1307130993-15265-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54888 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1FCVPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 17:15:04 -0400
Received: by wya21 with SMTP id 21so1673944wya.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 14:15:02 -0700 (PDT)
In-Reply-To: <1307130993-15265-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Sat, Jun 4, 2011 at 1:26 AM, Grazvydas Ignotas <notasas@gmail.com> w=
rote:
> omap_nand_platform_data fields 'options', 'gpio_irq', 'nand_setup' an=
d
> 'dma_channel' are never referenced by the NAND driver, yet various
> board files are initializing those fields. This is both incorrect and
> confusing, so remove them. This allows to get rid of a global
> variable in gpmc-nand.c.
>
> This also corrects an issue where some boards are trying to pass NAND
> 16bit flag through .options, but the driver is using .devsize instead
> and ignoring .options.
>
> Finally, .dev_ready is treated as a flag by the driver, so make it bo=
ol
> instead of a function pointer.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/arm/mach-omap2/board-cm-t3517.c =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap2/board-flash.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 --=
--
> =A0arch/arm/mach-omap2/common-board-devices.c | =A0 =A06 ++----
> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 ++=
+-------
> =A0arch/arm/plat-omap/include/plat/nand.h =A0 =A0 | =A0 =A06 +-----
> =A06 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2=
/board-cm-t35.c
> index c63115b..99238e6 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -164,9 +164,7 @@ static struct mtd_partition cm_t35_nand_partition=
s[] =3D {
> =A0static struct omap_nand_platform_data cm_t35_nand_data =3D {
> =A0 =A0 =A0 =A0.parts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cm_t35_n=
and_partitions,
> =A0 =A0 =A0 =A0.nr_parts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ARRAY_SIZE(c=
m_t35_nand_partitions),
> - =A0 =A0 =A0 .dma_channel =A0 =A0 =A0 =A0 =A0 =A0=3D -1, =A0 /* disa=
ble DMA in OMAP NAND driver */
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> -
> =A0};
>
> =A0static void __init cm_t35_init_nand(void)
> diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-oma=
p2/board-cm-t3517.c
> index 08f08e8..c80d862 100644
> --- a/arch/arm/mach-omap2/board-cm-t3517.c
> +++ b/arch/arm/mach-omap2/board-cm-t3517.c
> @@ -237,7 +237,6 @@ static struct mtd_partition cm_t3517_nand_partiti=
ons[] =3D {
> =A0static struct omap_nand_platform_data cm_t3517_nand_data =3D {
> =A0 =A0 =A0 =A0.parts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cm_t3517=
_nand_partitions,
> =A0 =A0 =A0 =A0.nr_parts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ARRAY_SIZE(c=
m_t3517_nand_partitions),
> - =A0 =A0 =A0 .dma_channel =A0 =A0 =A0 =A0 =A0 =A0=3D -1, =A0 /* disa=
ble DMA in OMAP NAND driver */
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> =A0};
>
> diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/=
board-flash.c
> index 729892f..aa1b0cb 100644
> --- a/arch/arm/mach-omap2/board-flash.c
> +++ b/arch/arm/mach-omap2/board-flash.c
> @@ -132,11 +132,7 @@ static struct gpmc_timings nand_timings =3D {
> =A0};
>
> =A0static struct omap_nand_platform_data board_nand_data =3D {
> - =A0 =A0 =A0 .nand_setup =A0 =A0 =3D NULL,
> =A0 =A0 =A0 =A0.gpmc_t =A0 =A0 =A0 =A0 =3D &nand_timings,
> - =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disa=
ble DMA in OMAP NAND driver */
> - =A0 =A0 =A0 .dev_ready =A0 =A0 =A0=3D NULL,
> - =A0 =A0 =A0 .devsize =A0 =A0 =A0 =A0=3D 0, =A0 =A0/* '0' for 8-bit,=
 '1' for 16-bit device */
> =A0};
>
> =A0void
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/ma=
ch-omap2/common-board-devices.c
> index e94903b..366171d 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -115,9 +115,7 @@ void __init omap_ads7846_init(int bus_num, int gp=
io_pendown, int gpio_debounce,
> =A0#endif
>
> =A0#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP=
2_MODULE)
> -static struct omap_nand_platform_data nand_data =3D {
> - =A0 =A0 =A0 .dma_channel =A0 =A0=3D -1, =A0 =A0 =A0 =A0 =A0 /* disa=
ble DMA in OMAP NAND driver */
> -};
> +static struct omap_nand_platform_data nand_data;
>
> =A0void __init omap_nand_flash_init(int options, struct mtd_partition=
 *parts,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int n=
r_parts)
> @@ -148,7 +146,7 @@ void __init omap_nand_flash_init(int options, str=
uct mtd_partition *parts,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nand_data.cs =3D nandcs;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nand_data.parts =3D parts;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nand_data.nr_parts =3D nr_parts;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand_data.options =3D options;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nand_data.devsize =3D options;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "Registering NAND on =
CS%d\n", nandcs);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpmc_nand_init(&nand_data) < 0)
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gp=
mc-nand.c
> index c1791d0..8ad210b 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -20,8 +20,6 @@
> =A0#include <plat/board.h>
> =A0#include <plat/gpmc.h>
>
> -static struct omap_nand_platform_data *gpmc_nand_data;
> -
> =A0static struct resource gpmc_nand_resource =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> =A0};
> @@ -33,7 +31,7 @@ static struct platform_device gpmc_nand_device =3D =
{
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D &gpmc_nand_resource,
> =A0};
>
> -static int omap2_nand_gpmc_retime(void)
> +static int omap2_nand_gpmc_retime(struct omap_nand_platform_data *gp=
mc_nand_data)
> =A0{
> =A0 =A0 =A0 =A0struct gpmc_timings t;
> =A0 =A0 =A0 =A0int err;
> @@ -83,13 +81,11 @@ static int omap2_nand_gpmc_retime(void)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data=
)
> +int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_=
data)
> =A0{
> =A0 =A0 =A0 =A0int err =3D 0;
> =A0 =A0 =A0 =A0struct device *dev =3D &gpmc_nand_device.dev;
>
> - =A0 =A0 =A0 gpmc_nand_data =3D _nand_data;
> - =A0 =A0 =A0 gpmc_nand_data->nand_setup =3D omap2_nand_gpmc_retime;

Purpose of doing this was to be able to utilise
'omap2_nand_gpmc_retime', when DVFS is ready to use it,
for changing timing parameter dynamically when a frequency change is do=
ne.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
