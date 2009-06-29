From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH]OMAP4: McSPI Support for OMAP_4430
Date: Mon, 29 Jun 2009 23:28:31 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F54DB172@dbde02.ent.ti.com>
References: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42631 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbZF2R6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:58:45 -0400
In-Reply-To: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "dbrownell@users.sourceforge.net" <dbrownell@users.sou>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Rafiuddin

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Syed,
>Rafiuddin
>Sent: Monday, June 29, 2009 7:55 AM
>To: spi-devel-general@lists.sourceforge.net; dbrownell@users.sourceforge.net
>Cc: linux-omap@vger.kernel.org
>Subject: [PATCH]OMAP4: McSPI Support for OMAP_4430

Your mailer is having formatting issues like:
TABS getting converted to spaces, etc.

Please use git send-email instead and for setting this up you can refer to this wiki page https://omapzoom.org/gf/project/omapkernel/wiki/?pagename=How+to+submit+patches


>
>This patch adds McSPI support for OMAP4430 SDP platform. All the base addresses
>are changed between OMAP1/2/3 and OMAP4.The fields of the resource structures
>are filled at runtime to have McSPI support on OMAP4.
>
>Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
>Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>Acked-by: Tony Lindgren <tony@atomide.com>
>Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>---
> arch/arm/mach-omap2/devices.c |   25 +++++++++++++++++++++----
> drivers/spi/omap2_mcspi.c     |   10 ++++++----
> 2 files changed, 27 insertions(+), 8 deletions(-)
>
>Index: omap4_dev/arch/arm/mach-omap2/devices.c
>=================================================================== ---
>omap4_dev.orig/arch/arm/mach-omap2/devices.c        2009-06-24
>19:22:04.000000000
>+0530
Here is a bad formatting example.

>+++ omap4_dev/arch/arm/mach-omap2/devices.c        2009-06-25
>10:05:39.000000000 +0530
> static void omap_init_mcspi(void)
> {
>+        if (cpu_is_omap44xx()) {
>+                omap2_mcspi1_resources[0].start = OMAP4_MCSPI1_BASE; +
>       omap2_mcspi1_resources[0].end         = OMAP4_MCSPI1_BASE + 0xff; +
>          omap2_mcspi2_resources[0].start = OMAP4_MCSPI2_BASE; +
>omap2_mcspi2_resources[0].end         = OMAP4_MCSPI2_BASE + 0xff; +
>   omap2_mcspi3_resources[0].start = OMAP4_MCSPI3_BASE; +
>omap2_mcspi3_resources[0].end         = OMAP4_MCSPI3_BASE + 0xff; +
>   omap2_mcspi4_resources[0].start = OMAP4_MCSPI4_BASE; +
>omap2_mcspi4_resources[0].end         = OMAP4_MCSPI4_BASE + 0xff; +        }
>         platform_device_register(&omap2_mcspi1);
>         platform_device_register(&omap2_mcspi2);
>-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
>+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \ +
>defined(CONFIG_ARCH_OMAP4)
>         platform_device_register(&omap2_mcspi3);
> #endif
>-#ifdef CONFIG_ARCH_OMAP3
>+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>         platform_device_register(&omap2_mcspi4);
> #endif
> }
>Index: omap4_dev/drivers/spi/omap2_mcspi.c
>=================================================================== ---
>omap4_dev.orig/drivers/spi/omap2_mcspi.c        2009-06-24
>19:22:23.000000000 +0530
>+++ omap4_dev/drivers/spi/omap2_mcspi.c        2009-06-24 19:22:46.000000000
>+0530 @@ -918,7 +918,8 @@
>         OMAP24XX_DMA_SPI2_TX1,
> };
>
>-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) +#if

This is some formatting issue which will not come if you use git send-email

>defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) || \ +
>defined(CONFIG_ARCH_OMAP4)
> static u8 __initdata spi3_rxdma_id[] = {
>         OMAP24XX_DMA_SPI3_RX0,
>         OMAP24XX_DMA_SPI3_RX1,
>@@ -930,7 +931,7 @@
> };
> #endif
>
>-#ifdef CONFIG_ARCH_OMAP3
>+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> static u8 __initdata spi4_rxdma_id[] = {
>         OMAP34XX_DMA_SPI4_RX0,
> };
>@@ -960,14 +961,15 @@
>                 txdma_id = spi2_txdma_id;
>                 num_chipselect = 2;
>                 break;
>-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
>+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \ +
>defined(CONFIG_ARCH_OMAP4)
>         case 3:
>                 rxdma_id = spi3_rxdma_id;
>                 txdma_id = spi3_txdma_id;
>                 num_chipselect = 2;
>                 break;
> #endif
>-#ifdef CONFIG_ARCH_OMAP3
>+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>         case 4:
>                 rxdma_id = spi4_rxdma_id;
>                 txdma_id = spi4_txdma_id;
>
