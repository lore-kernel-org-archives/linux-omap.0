From: Venkatraman S <svenkatr@gmail.com>
Subject: Re: [PATCH 1/1] omap-hsmmc.c: re-organize dma line population
Date: Tue, 11 May 2010 16:49:36 +0530
Message-ID: <AANLkTil_hTRTuVrGk6VEWfUJv_fXaVg2e3c7lajHl-RP@mail.gmail.com>
References: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57768 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0EKLTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 07:19:37 -0400
Received: by pwi5 with SMTP id 5so2161564pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 04:19:37 -0700 (PDT)
In-Reply-To: <1273566733-22572-1-git-send-email-sriram.m@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhvapathi Sriram <sriram.m@ti.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

Madhvapathi Sriram <sriram.m@ti.com> wrote:
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].end =3D OMAP24XX_DMA_MMC2_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].start =3D OMAP24XX_DMA_MMC2_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].end =3D OMAP24XX_DMA_MMC2_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].start =3D OMAP34XX_DMA_MMC3_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].end =3D OMAP34XX_DMA_MMC3_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].start =3D OMAP34XX_DMA_MMC3_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].end =3D OMAP34XX_DMA_MMC3_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].start =3D OMAP44XX_DMA_MMC4_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].end =3D OMAP44XX_DMA_MMC4_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].start =3D OMAP44XX_DMA_MMC4_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].end =3D OMAP44XX_DMA_MMC4_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].start =3D OMAP44XX_DMA_MMC5_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].end =3D OMAP44XX_DMA_MMC5_RX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[2].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].start =3D OMAP44XX_DMA_MMC5_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].end =3D OMAP44XX_DMA_MMC5_TX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res[3].flags =3D IORESOURCE_DMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0ret =3D platform_device_add_resources(pdev, res, ARRAY=
_SIZE(res));
> =A0 =A0 =A0 =A0if (ret =3D=3D 0)
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index e9caf69..61d30ab 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2096,32 +2096,15 @@ static int __init omap_hsmmc_probe(struct pla=
tform_device *pdev)
>
> =A0 =A0 =A0 =A0omap_hsmmc_conf_bus_power(host);
>
> - =A0 =A0 =A0 /* Select DMA lines */
> - =A0 =A0 =A0 switch (host->id) {
> - =A0 =A0 =A0 case OMAP_MMC1_DEVID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_tx =3D OMAP24XX_DMA_MMC1=
_TX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_rx =3D OMAP24XX_DMA_MMC1=
_RX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case OMAP_MMC2_DEVID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_tx =3D OMAP24XX_DMA_MMC2=
_TX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_rx =3D OMAP24XX_DMA_MMC2=
_RX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case OMAP_MMC3_DEVID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_tx =3D OMAP34XX_DMA_MMC3=
_TX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_rx =3D OMAP34XX_DMA_MMC3=
_RX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case OMAP_MMC4_DEVID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_tx =3D OMAP44XX_DMA_MMC4=
_TX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_rx =3D OMAP44XX_DMA_MMC4=
_RX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case OMAP_MMC5_DEVID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_tx =3D OMAP44XX_DMA_MMC5=
_TX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_line_rx =3D OMAP44XX_DMA_MMC5=
_RX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc), "Invalid MM=
C id\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> + =A0 =A0 =A0 if (!res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 host->dma_line_rx =3D res->start;
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
> + =A0 =A0 =A0 if (!res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 host->dma_line_tx =3D res->start;
>
> =A0 =A0 =A0 =A0/* Request IRQ for MMC operations */
> =A0 =A0 =A0 =A0ret =3D request_irq(host->irq, omap_hsmmc_irq, IRQF_DI=
SABLED,
> --

This is part of hwmod work and present in Kevin's runtime PM changes. S=
ee
http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=
=3Dcommit;h=3D78977ffbbe9f90ee6becc543526252d081381f72
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
