From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 1/2] arm: omap: fix bug with multiple smsc911x devices
Date: Fri, 22 Apr 2011 15:51:46 +0300
Message-ID: <BANLkTi=PtDVewo-g-oZJw5=AG5TqvFBf0w@mail.gmail.com>
References: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1DVMvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 08:51:46 -0400
Received: by iyb14 with SMTP id 14so446504iyb.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 05:51:46 -0700 (PDT)
In-Reply-To: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Igor,

On Thu, Apr 21, 2011 at 5:50 PM, Igor Grinberg <grinberg@compulab.co.il=
> wrote:
>
> kobject (c06a4250): tried to init an initialized object, something is
> seriously wrong.
>
> introduced by commit 66293989:
> (omap: convert boards that use SMSC911x to use gpmc-smsc911x)
>
> fixed by allocating struct platform_device dynamically.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> This has been boot tested with nfs root on cm-t35,
> and build tested on all other affected boards.
>
> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 ++
> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A01 +
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A0arch/arm/mach-omap2/board-omap3logic.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 =A0 =A0| =A0 =A01=
 +
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 ++
> =A0arch/arm/mach-omap2/board-zoom-debugboard.c =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/gpmc-smsc911x.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
16 +++++-----------
> =A0arch/arm/plat-omap/include/plat/gpmc-smsc911x.h | =A0 =A01 +
> =A010 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2=
/board-cm-t35.c
> index b5772c1..7c70f56 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -69,6 +69,7 @@
> =A0#include <plat/gpmc-smsc911x.h>
>
> =A0static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg =3D =
{
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D CM_T35_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D CM_T35_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> @@ -76,6 +77,7 @@ static struct omap_smsc911x_platform_data cm_t35_sm=
sc911x_cfg =3D {
> =A0};
>
> =A0static struct omap_smsc911x_platform_data sb_t35_smsc911x_cfg =3D =
{
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D SB_T35_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D SB_T35_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index 5b9bde7..2bf12fb 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -195,6 +195,7 @@ static void __init igep2_flash_init(void) {}
> =A0#include <plat/gpmc-smsc911x.h>
>
> =A0static struct omap_smsc911x_platform_data smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D IGEP2_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D IGEP2_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/bo=
ard-ldp.c
> index ea9f049..94cfd82 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -218,6 +218,7 @@ static struct spi_board_info ldp_spi_board_info[]=
 __initdata =3D {
> =A0};
>
> =A0static struct omap_smsc911x_platform_data smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,

I believe you can keep the id field uninitialized, i.e. 0.  This
applies to other boards with single smsc device as well.

> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D LDP_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D LDP_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 3fc85c6..fc5c1d8 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -104,6 +104,7 @@ static void __init omap3_evm_get_revision(void)
> =A0#include <plat/gpmc-smsc911x.h>
>
> =A0static struct omap_smsc911x_platform_data smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3EVM_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D OMAP3EVM_ETHR_GPIO_IRQ,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-o=
map2/board-omap3logic.c
> index a49e6cf..06248e7 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -144,6 +144,7 @@ static void __init board_mmc_init(void)
> =A0}
>
> =A0static struct omap_smsc911x_platform_data __initdata board_smsc911=
x_data =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3LOGIC_SMSC911X_CS=
,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D -EINVAL,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach=
-omap2/board-omap3stalker.c
> index 848016c..ae4eaf5 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -64,6 +64,7 @@
> =A0#define OMAP3STALKER_SMC911X_CS =A0 =A0 =A0 =A05
>
> =A0static struct omap_smsc911x_platform_data smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3STALKER_SMC911X_C=
S,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D OMAP3STALKER_ETHR_GPIO_IRQ,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/=
board-overo.c
> index 4016166..165e1fa 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -149,6 +149,7 @@ static inline void __init overo_ads7846_init(void=
) { return; }
> =A0#include <plat/gpmc-smsc911x.h>
>
> =A0static struct omap_smsc911x_platform_data smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D OVERO_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D OVERO_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> @@ -156,6 +157,7 @@ static struct omap_smsc911x_platform_data smsc911=
x_cfg =3D {
> =A0};
>
> =A0static struct omap_smsc911x_platform_data smsc911x2_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D OVERO_SMSC911X2_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D OVERO_SMSC911X2_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/m=
ach-omap2/board-zoom-debugboard.c
> index 2ee9ab9..d6f6e93 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -28,6 +28,7 @@
> =A0#define ZOOM_ETHR_START =A0 =A0 =A0 =A0DEBUG_BASE
>
> =A0static struct omap_smsc911x_platform_data zoom_smsc911x_cfg =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> =A0 =A0 =A0 =A0.cs =A0 =A0 =A0 =A0 =A0 =A0 =3D ZOOM_SMSC911X_CS,
> =A0 =A0 =A0 =A0.gpio_irq =A0 =A0 =A0 =3D ZOOM_SMSC911X_GPIO,
> =A0 =A0 =A0 =A0.gpio_reset =A0 =A0 =3D -EINVAL,
> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap=
2/gpmc-smsc911x.c
> index b331f3c..d30293a 100644
> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> @@ -41,16 +41,6 @@ static struct smsc911x_platform_config gpmc_smsc91=
1x_config =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D SMSC911X_USE_16BIT,
> =A0};
>
> -static struct platform_device gpmc_smsc911x_device =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "smsc911x",
> - =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> - =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(gpmc_smsc911x_resource=
s),
> - =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D gpmc_smsc911x_resources,
> - =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &gpmc_smsc911x_confi=
g,
> - =A0 =A0 =A0 },
> -};
> -
> =A0/*
> =A0* Initialize smsc911x device connected to the GPMC. Note that we
> =A0* assume that pin multiplexing is done in the board-*.c file,
> @@ -58,6 +48,7 @@ static struct platform_device gpmc_smsc911x_device =
=3D {
> =A0*/
> =A0void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data =
*board_data)
> =A0{
> + =A0 =A0 =A0 struct platform_device *pdev;
> =A0 =A0 =A0 =A0unsigned long cs_mem_base;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -97,7 +88,10 @@ void __init gpmc_smsc911x_init(struct omap_smsc911=
x_platform_data *board_data)
> =A0 =A0 =A0 =A0if (gpmc_cfg->flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_smsc911x_config.flags =3D gpmc_cf=
g->flags;
>
> - =A0 =A0 =A0 if (platform_device_register(&gpmc_smsc911x_device) < 0=
) {
> + =A0 =A0 =A0 pdev =3D platform_device_register_resndata(NULL, "smsc9=
11x", gpmc_cfg->id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpmc_smsc911x_resources, ARRAY_SIZE(=
gpmc_smsc911x_resources),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gpmc_smsc911x_config, sizeof(gpmc_s=
msc911x_config));
> + =A0 =A0 =A0 if (!pdev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Unable to register sm=
sc911x device\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(gpmc_cfg->gpio_reset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free2;
> diff --git a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h b/arch/a=
rm/plat-omap/include/plat/gpmc-smsc911x.h
> index 872de0bf..d3f1579 100644
> --- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
> @@ -14,6 +14,7 @@
> =A0#ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
>
> =A0struct omap_smsc911x_platform_data {
> + =A0 =A0 =A0 int =A0 =A0 id;
> =A0 =A0 =A0 =A0int =A0 =A0 cs;
> =A0 =A0 =A0 =A0int =A0 =A0 gpio_irq;
> =A0 =A0 =A0 =A0int =A0 =A0 gpio_reset;
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--
=A0 =A0 Sincerely Yours,
=A0 =A0 =A0 =A0 Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
