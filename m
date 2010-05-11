From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/1] omap-hsmmc.c: re-organize dma line population
Date: Tue, 11 May 2010 13:52:34 +0300
Message-ID: <p2g6ed0b2681005110352i9b05f6a6oc8dace4e61efc3db@mail.gmail.com>
References: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:34805 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0EKKwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 06:52:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1237604fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 03:52:36 -0700 (PDT)
In-Reply-To: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhvapathi Sriram <sriram.m@ti.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

On Tue, May 11, 2010 at 11:32 AM, Madhvapathi Sriram <sriram.m@ti.com> =
wrote:
> =A0- This moves the dma line population from omap_hsmmc.c to plat-oma=
p/devices.c
> =A0- This is done to keep platform specific code inside the platform =
directory
> =A0 rather than the host driver
> =A0- This makes the porting work across OMAP platforms easier
>
> Signed-off-by: Madhvapathi Sriram <sriram.m@ti.com>
> ---
> =A0arch/arm/plat-omap/devices.c =A0| =A0 49 +++++++++++++++++++++++++=
+++++++++++++++-
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 35 +++++++--------------------=
-
> =A02 files changed, 57 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/device=
s.c
> index 95677d1..a62b148 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -30,6 +30,7 @@
> =A0#include <plat/mcbsp.h>
> =A0#include <plat/dsp_common.h>
> =A0#include <plat/omap44xx.h>
> +#include <plat/dma.h>
>
> =A0#if =A0 =A0defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MOD=
ULE)
>
> @@ -232,7 +233,7 @@ static inline void omap_init_mcpdm(void) {}
> =A0#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) ||=
 \
> =A0 =A0 =A0 =A0defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP=
_HS_MODULE)
>
> -#define OMAP_MMC_NR_RES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> +#define OMAP_MMC_NR_RES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
>
> =A0/*
> =A0* Register MMC devices. Called from mach-omap1 and mach-omap2 devi=
ce init.
> @@ -255,6 +256,52 @@ int __init omap_mmc_add(const char *name, int id=
, unsigned long base,
> =A0 =A0 =A0 =A0res[0].flags =3D IORESOURCE_MEM;
> =A0 =A0 =A0 =A0res[1].start =3D res[1].end =3D irq;
> =A0 =A0 =A0 =A0res[1].flags =3D IORESOURCE_IRQ;

You can just set .flags right here, no need to repeat in each switch ca=
se:
> +       res[2].flags =3D IORESOURCE_DMA;
> +       res[3].flags =3D IORESOURCE_DMA;

> + =A0 =A0 =A0 /* Populate DMA lines based on the instance used. Rx fi=
rst,Tx next*/
> + =A0 =A0 =A0 switch (id) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].start =3D OMAP24XX_DMA_MMC1_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].end =3D OMAP24XX_DMA_MMC1_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].start =3D OMAP24XX_DMA_MMC1_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].end =3D OMAP24XX_DMA_MMC1_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].start =3D OMAP24XX_DMA_MMC2_RX;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
