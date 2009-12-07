From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] [SPI] [OMAP] Add OMAP spi100k driver
Date: Mon, 7 Dec 2009 10:08:05 -0800
Message-ID: <20091207180805.GD24013@atomide.com>
References: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
 <1260161299-17656-2-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60199 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964868AbZLGSIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 13:08:01 -0500
Content-Disposition: inline
In-Reply-To: <1260161299-17656-2-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

Hi,

* Cory Maccarrone <darkstar6262@gmail.com> [091206 20:48]:
> This change adds the OMAP SPI 100k driver created by
> Fabrice Crohas <fcrohas@gmail.com>.  This SPI bus is found on
> OMAP7xx-series smartphones, and for many, the touchscreen is
> attached to this bus.
> 
> The lion's share of the work was done by Fabrice on this driver --
> I am merely porting it from the Linwizard project on his behalf.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  drivers/spi/Kconfig         |    6 +
>  drivers/spi/Makefile        |    1 +
>  drivers/spi/omap_spi_100k.c |  642 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 649 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/omap_spi_100k.c

<snip>

> +static void spi100k_enable_clock(struct spi_master *master)
> +{
> +	unsigned int val;
> +	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
> +
> +	/* enable SPI */
> +	val = omap_readw(spi100k->base_addr + SPI_SETUP1);
> +	val |= SPI_SETUP1_CLOCK_ENABLE;
> +	omap_writew(val, spi100k->base_addr + SPI_SETUP1);
> +}

Please do not use omap_read/write for the new drivers.

Instead, please use ioremap in the platform init code in
arch/arm/mach-omap1/, and pass the virtual address in
platform_data to the driver. Then you can use readw/writew
in the driver.

We have static mappings in place for ioremap, so there's
no extra overhead.

Regards,

Tony
