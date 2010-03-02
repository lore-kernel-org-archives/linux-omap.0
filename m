From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCHv3 2/4] Regulator: OMAP: Modifying Kconfig/Makefile to
	choose from available PMICs
Date: Tue, 2 Mar 2010 19:23:39 +0200
Message-ID: <6ed0b2681003020923m2c7526fn11995334c36c8a83@mail.gmail.com>
References: <1267525787-3169-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:2177 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0CBRXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 12:23:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so132816fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 09:23:40 -0800 (PST)
In-Reply-To: <1267525787-3169-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

On Tue, Mar 2, 2010 at 12:29 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> w=
rote:
> Kconfig is modified for OMAP3 EVM so that user can choose the appropr=
iate
> PMIC (currently only TWL4030). Config options for other PMICs will be
> added later on.
> Makefile is modified so that twl4030-pmic.c gets compiled for the
> platforms having TWL4030 as the PMIC.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0arch/arm/mach-omap2/Kconfig =A0| =A0 =A09 +++++++++
> =A0arch/arm/mach-omap2/Makefile | =A0 =A01 +
> =A02 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index a8a3d1e..1974dda 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -77,6 +77,15 @@ config MACH_OMAP3EVM
> =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBB
>
> +config PMIC_TWL4030
> + =A0 =A0 =A0 bool "TWL4030/TPS65950 Power Module"
> + =A0 =A0 =A0 default y
> + =A0 =A0 =A0 select TWL4030_CORE
> + =A0 =A0 =A0 select REGULATOR_TWL4030 if REGULATOR
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say yes here if you are using the TWL4030/TPS65950 =
based power module
> + =A0 =A0 =A0 =A0 for the EVM boards.
> +

Any reason to have this user configurable? The boards that depend on
it will always need it to be enabled to compile, and the ones that
don't always want it disabled.

> =A0config MACH_OMAP3517EVM
> =A0 =A0 =A0 =A0bool "OMAP3517/ AM3517 EVM board"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 2069fb3..c33e24d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_MACH_IGEP0020) =A0 =A0 =A0 =A0 +=3D =
board-igep0020.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK) =A0 =A0 +=3D board-omap3touchbo=
ok.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> +obj-$(CONFIG_PMIC_TWL4030) =A0 =A0 =A0 =A0 =A0 =A0 +=3D twl4030-pmic=
=2Eo
> =A0obj-$(CONFIG_MACH_OMAP_4430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-4430sdp.o
>
> =A0obj-$(CONFIG_MACH_OMAP3517EVM) =A0 =A0 =A0 =A0 +=3D board-am3517ev=
m.o
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
