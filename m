From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2+: Disable code that currently does not work with multiplaform
Date: Thu, 03 Jan 2013 22:23:42 +0100
Message-ID: <2770938.Qr8SHcYrK2@avalon>
References: <20121219192354.22098.33408.stgit@muffinssi.local> <20121219192627.22098.10760.stgit@muffinssi.local> <20130103201521.GI25633@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41819 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab3ACVWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 16:22:09 -0500
In-Reply-To: <20130103201521.GI25633@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Sean Young <sean@mess.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>, Herbert Xu <herbert@gondor.apana.org.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,

On Thursday 03 January 2013 12:15:21 Tony Lindgren wrote:
> Hi all,
>=20
> Looks like we need to also disable mailbox to avoid dependencies to
> the mailbox series as it's being moved to live under drivers.
>=20
> And we need to disable omap3isp as it tries to use the now private
> include <plat/*.h> headers.

I've posted a patch to the linux-media mailing list to remove plat/*.h =
headers=20
that are not present anymore in v3.8. It will be pushed to v3.8, as thi=
s=20
breaks compilation of the driver.

The driver still includes the plat/cpu.h header that can be removed as =
well.=20
I've just posted a patch that remove the header and will push it to v3.=
9. The=20
OMAP3 ISP part of this patch can thus be dropped.

> Updated patch below.
>=20
> Tony
>=20
>=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 2 Jan 2013 10:24:09 -0800
> Subject: [PATCH] ARM: OMAP2+: Disable code that currently does not wo=
rk with
> multiplaform MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> We still need to fix up few places for multiplatform support,
> but that can proceed separately. Fix the issue by making the
> problem drivers depends !ARCH_MULTIPLATFORM for now.
>=20
> The remaining pieces that are not multiplatform compatible
> for omap2+ SoCs are:
>=20
> 1. Some drivers are using custom omap_dm_timer calls
>=20
> There are two drivers that are directly usign omap hardware
> timers for PWM and DSP clocking: drivers/media/rc/ir-rx51.c and
> drivers/staging/tidspbridge/core/dsp-clock.c. These can be
> fixed for multiplatform by allowing a minimal set of hardware
> timers to be accessed, and for some functionality by using the
> hrtimer framework.
>=20
> 2. Hardware OMAP4_ERRATA_I688 needs to be fixed up
>=20
> This can't be enabled for multiplatform configurations in
> it's current form. It may be possible to fix it up to do
> instruction replacement early on during init. Luckily it
> looks like this errata does not seem to get hit with
> mainline kernel code alone at least currently.
>=20
> 3. Legacy header needed for omap-sham.c
>=20
> Looks like it still needs mach/irqs.h for omap1 that
> does not exist for multiplatform systems. Just ifdef
> it for now.
>=20
> 4. Mailbox is waiting to get moved to drivers
>=20
> Disable it for now to avoid adding a dependency to the
> mailbox patches.
>=20
> 5. Camera omap3isp needs to be disabled
>=20
> The include <plat/*.h> files won't be available to drivers
> after multiplatform support is enabled.
>=20
> Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> Cc: Sean Young <sean@mess.org>
> Cc: "V=EDctor Manuel J=E1quez Leal" <vjaquez@igalia.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> [tony@atomide.com: updated to disable mailbox and omap3isp]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 41b581f..492d764 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -397,7 +397,7 @@ config OMAP3_SDRC_AC_TIMING
>=20
>  config OMAP4_ERRATA_I688
>  	bool "OMAP4 errata: Async Bridge Corruption"
> -	depends on ARCH_OMAP4
> +	depends on ARCH_OMAP4 && !ARCH_MULTIPLATFORM
>  	select ARCH_HAS_BARRIERS
>  	help
>  	  If a data is stalled inside asynchronous bridge because of back
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 665870d..03f1252 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -118,7 +118,7 @@ config OMAP_MUX_WARNINGS
>=20
>  config OMAP_MBOX_FWK
>  	tristate "Mailbox framework support"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP && !ARCH_MULTIPLATFORM
>  	help
>  	  Say Y here if you want to use OMAP Mailbox framework support for
>  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
> index 1d75e6f..d65f22c 100644
> --- a/drivers/crypto/omap-sham.c
> +++ b/drivers/crypto/omap-sham.c
> @@ -38,7 +38,10 @@
>  #include <crypto/internal/hash.h>
>=20
>  #include <linux/omap-dma.h>
> +
> +#ifdef CONFIG_ARCH_OMAP1
>  #include <mach/irqs.h>
> +#endif
>=20
>  #define SHA_REG_DIGEST(x)		(0x00 + ((x) * 0x04))
>  #define SHA_REG_DIN(x)			(0x1C + ((x) * 0x04))
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/=
Kconfig
> index 3dcfea6..eff53c9 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -99,7 +99,7 @@ config VIDEO_OMAP2
>=20
>  config VIDEO_OMAP3
>  	tristate "OMAP 3 Camera support (EXPERIMENTAL)"
> -	depends on OMAP_IOVMM && VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API=
 &&
> ARCH_OMAP3 && EXPERIMENTAL +	depends on OMAP_IOVMM && VIDEO_V4L2 && I=
2C &&
> VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3 && EXPERIMENTAL && !ARCH_MULTIPLA=
TFORM
> ---help---
>  	  Driver for an OMAP 3 camera controller.
>=20
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index 79ba242..19f3563 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -291,7 +291,7 @@ config IR_TTUSBIR
>=20
>  config IR_RX51
>  	tristate "Nokia N900 IR transmitter diode"
> -	depends on OMAP_DM_TIMER && LIRC
> +	depends on OMAP_DM_TIMER && LIRC && !ARCH_MULTIPLATFORM
>  	---help---
>  	   Say Y or M here if you want to enable support for the IR
>  	   transmitter diode built in the Nokia N900 (RX51) device.
> diff --git a/drivers/staging/tidspbridge/Kconfig
> b/drivers/staging/tidspbridge/Kconfig index 0dd479f..60848f1 100644
> --- a/drivers/staging/tidspbridge/Kconfig
> +++ b/drivers/staging/tidspbridge/Kconfig
> @@ -4,7 +4,7 @@
>=20
>  menuconfig TIDSPBRIDGE
>  	tristate "DSP Bridge driver"
> -	depends on ARCH_OMAP3
> +	depends on ARCH_OMAP3 && !ARCH_MULTIPLATFORM
>  	select OMAP_MBOX_FWK
>  	help
>  	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
--=20
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
