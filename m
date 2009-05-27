From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][RFC] OMAP4: McSPI Register Offset Changes For OMAP_4430SDP
Date: Wed, 27 May 2009 10:00:53 -0700
Message-ID: <87y6siv5tm.fsf@deeprootsystems.com>
References: <51753.192.168.10.89.1243442125.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:62603 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbZE0RAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 13:00:55 -0400
Received: by pxi29 with SMTP id 29so506840pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2009 10:00:56 -0700 (PDT)
In-Reply-To: <51753.192.168.10.89.1243442125.squirrel@dbdmail.itg.ti.com> (Syed Rafiuddin's message of "Wed\, 27 May 2009 22\:05\:25 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Syed Rafiuddin <rafiuddin.syed@ti.com>
Cc: linux-omap@vger.kernel.org

"Syed Rafiuddin" <rafiuddin.syed@ti.com> writes:

> This patch updates McSPI register offset addresses with respect to OMAP4
>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   10 ++++----
>  drivers/spi/omap2_mcspi.c     |   51 ++++++++++++++++++++++++++++--------------
>  2 files changed, 41 insertions(+), 20 deletions(-)
>
> Index: omap4_dev/arch/arm/mach-omap2/devices.c
> ===================================================================
> --- omap4_dev.orig/arch/arm/mach-omap2/devices.c
> +++ omap4_dev/arch/arm/mach-omap2/devices.c
> @@ -301,7 +301,8 @@ static struct platform_device omap2_mcsp
>  	},
>  };
>
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
> +defined(CONFIG_ARCH_OMAP4)
>  static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
>  	.num_cs		= 2,
>  };
> @@ -325,7 +326,7 @@ static struct platform_device omap2_mcsp
>  };
>  #endif
>
> -#ifdef CONFIG_ARCH_OMAP3
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
>  	.num_cs		= 1,
>  };
> @@ -353,10 +354,11 @@ static void omap_init_mcspi(void)
>  {
>  	platform_device_register(&omap2_mcspi1);
>  	platform_device_register(&omap2_mcspi2);
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
> +defined(CONFIG_ARCH_OMAP4)
>  	platform_device_register(&omap2_mcspi3);
>  #endif
> -#ifdef CONFIG_ARCH_OMAP3
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  	platform_device_register(&omap2_mcspi4);
>  #endif
>  }
> Index: omap4_dev/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- omap4_dev.orig/drivers/spi/omap2_mcspi.c
> +++ omap4_dev/drivers/spi/omap2_mcspi.c
> @@ -42,21 +42,38 @@
>  #define OMAP2_MCSPI_MAX_FREQ		48000000
>
>  #define OMAP2_MCSPI_REVISION		0x00
> -#define OMAP2_MCSPI_SYSCONFIG		0x10
> -#define OMAP2_MCSPI_SYSSTATUS		0x14
> -#define OMAP2_MCSPI_IRQSTATUS		0x18
> -#define OMAP2_MCSPI_IRQENABLE		0x1c
> -#define OMAP2_MCSPI_WAKEUPENABLE	0x20
> -#define OMAP2_MCSPI_SYST		0x24
> -#define OMAP2_MCSPI_MODULCTRL		0x28
> +#ifdef CONFIG_ARCH_OMAP4

Why do you need an #ifdef for OMAP4.  This breaks multi-omap.

> +#define OMAP2_MCSPI_SYSCONFIG		0x110
> +#define OMAP2_MCSPI_SYSSTATUS		0x114
> +#define OMAP2_MCSPI_IRQSTATUS		0x118
> +#define OMAP2_MCSPI_IRQENABLE		0x11c
> +#define OMAP2_MCSPI_WAKEUPENABLE	0x120
> +#define OMAP2_MCSPI_SYST		0x124
> +#define OMAP2_MCSPI_MODULCTRL		0x128

Looking closer, these are all the same register offsets as OMAP2/3,
except you are adding 0x100.

Instead of changing these register defines, you should just be
updating the base address for OMAP4.

The rest of the patch suggests that this is indeed an identical HW
block to what is on OMAP2/3.

Kevin

>  /* per-channel banks, 0x14 bytes each, first is: */
> -#define OMAP2_MCSPI_CHCONF0		0x2c
> -#define OMAP2_MCSPI_CHSTAT0		0x30
> -#define OMAP2_MCSPI_CHCTRL0		0x34
> -#define OMAP2_MCSPI_TX0			0x38
> -#define OMAP2_MCSPI_RX0			0x3c
> +#define OMAP2_MCSPI_CHCONF0		0x12c
> +#define OMAP2_MCSPI_CHSTAT0		0x130
> +#define OMAP2_MCSPI_CHCTRL0		0x134
> +#define OMAP2_MCSPI_TX0			0x138
> +#define OMAP2_MCSPI_RX0			0x13c
> +#else
> +#define OMAP2_MCSPI_REVISION            0x00
> +#define OMAP2_MCSPI_SYSCONFIG           0x10
> +#define OMAP2_MCSPI_SYSSTATUS           0x14
> +#define OMAP2_MCSPI_IRQSTATUS           0x18
> +#define OMAP2_MCSPI_IRQENABLE           0x1c
> +#define OMAP2_MCSPI_WAKEUPENABLE        0x20
> +#define OMAP2_MCSPI_SYST                0x24
> +#define OMAP2_MCSPI_MODULCTRL           0x28
>
> +/* per-channel banks, 0x14 bytes each, first is: */
> +#define OMAP2_MCSPI_CHCONF0             0x2c
> +#define OMAP2_MCSPI_CHSTAT0             0x30
> +#define OMAP2_MCSPI_CHCTRL0             0x34
> +#define OMAP2_MCSPI_TX0                 0x38
> +#define OMAP2_MCSPI_RX0                 0x3c
> +#endif
>  /* per-register bitmasks: */
>
>  #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
> @@ -918,7 +935,8 @@ static u8 __initdata spi2_txdma_id[] = {
>  	OMAP24XX_DMA_SPI2_TX1,
>  };
>
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) ||\
> +defined(CONFIG_ARCH_OMAP44XX)
>  static u8 __initdata spi3_rxdma_id[] = {
>  	OMAP24XX_DMA_SPI3_RX0,
>  	OMAP24XX_DMA_SPI3_RX1,
> @@ -930,7 +948,7 @@ static u8 __initdata spi3_txdma_id[] = {
>  };
>  #endif
>
> -#ifdef CONFIG_ARCH_OMAP3
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static u8 __initdata spi4_rxdma_id[] = {
>  	OMAP34XX_DMA_SPI4_RX0,
>  };
> @@ -960,14 +978,15 @@ static int __init omap2_mcspi_probe(stru
>  		txdma_id = spi2_txdma_id;
>  		num_chipselect = 2;
>  		break;
> -#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) ||\
> +defined(CONFIG_ARCH_OMAP4)
>  	case 3:
>  		rxdma_id = spi3_rxdma_id;
>  		txdma_id = spi3_txdma_id;
>  		num_chipselect = 2;
>  		break;
>  #endif
> -#ifdef CONFIG_ARCH_OMAP3
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  	case 4:
>  		rxdma_id = spi4_rxdma_id;
>  		txdma_id = spi4_txdma_id;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
