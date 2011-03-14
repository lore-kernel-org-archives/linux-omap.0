From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Mon, 14 Mar 2011 13:27:18 -0600
Message-ID: <20110314192718.GG16096@angua.secretlab.ca>
References: <87ipvmx2ok.fsf@gmail.com>
 <1300043119-11262-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39423 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab1CNT1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 15:27:22 -0400
Received: by ywj3 with SMTP id 3so2184202ywj.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 12:27:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300043119-11262-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sun, Mar 13, 2011 at 03:05:19PM -0400, Ben Gamari wrote:
> Many applications require more chip select lines than the board or
> processor allow. Introduce a mechanism to allow use of GPIO pins as
> chip select lines with the McSPI controller. To use this functionality,
> one simply provides a table mapping CS line numbers to GPIO numbers in
> omap2_mcspi_platform_config.cs_gpios.
> 
> Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcspi.h |    3 ++-
>  drivers/spi/omap2_mcspi.c               |   15 ++++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
> index 1254e49..cac1d84 100644
> --- a/arch/arm/plat-omap/include/plat/mcspi.h
> +++ b/arch/arm/plat-omap/include/plat/mcspi.h
> @@ -2,7 +2,8 @@
>  #define _OMAP2_MCSPI_H
>  
>  struct omap2_mcspi_platform_config {
> -	unsigned short	num_cs;
> +	unsigned short num_cs;
> +	int *cs_gpios;
>  };
>  
>  struct omap2_mcspi_device_config {
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index abb1ffb..59cbed4 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  
>  #include <linux/spi/spi.h>
> +#include <linux/gpio.h>
>  
>  #include <plat/dma.h>
>  #include <plat/clock.h>
> @@ -235,11 +236,15 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
>  
>  static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
>  {
> -	u32 l;
> -
> -	l = mcspi_cached_chconf0(spi);
> -	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
> -	mcspi_write_chconf0(spi, l);
> +	struct omap2_mcspi_platform_config *pconfig = spi->master->dev.platform_data;
> +	if (pconfig->cs_gpios) {
> +		int gpio = pconfig->cs_gpios[spi->chip_select];
> +		gpio_set_value(gpio, cs_active);
> +	} else {
> +		u32 l = mcspi_cached_chconf0(spi);
> +		MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
> +		mcspi_write_chconf0(spi, l);
> +	}

What if the board wanted to use both the native SPI ss line as well as
one or more GPIOs?  You probably want to reserve cs0 for the native
gpio line.

Otherwise this patch looks good to me.

g.


