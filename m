From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] OMAP4: SPI: Fix Driver Kconfig
Date: Tue, 4 May 2010 12:48:33 -0700
Message-ID: <20100504194833.GJ29604@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DC15EBB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57528 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669Ab0EDTsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 15:48:47 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DC15EBB@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Arce, Abraham <x0066660@ti.com> [100422 07:39]:
> From: Syed Rafiuddin <rafiuddin.syed@ti.com>
> 
> Add OMAP4 data to allow McSPI driver built
> 
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Signed-off-by: Shubhro <a0393217@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh shilimkar@ti.com>
> Signed-off-by: Abraham Arce <x0066660@ti.com>
> ---
>  drivers/spi/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a191fa2..5f54235 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -180,10 +180,10 @@ config SPI_OMAP_UWIRE
>  	  This hooks up to the MicroWire controller on OMAP1 chips.
>  
>  config SPI_OMAP24XX
> -	tristate "McSPI driver for OMAP24xx/OMAP34xx"
> -	depends on ARCH_OMAP2 || ARCH_OMAP3
> +	tristate "McSPI driver for OMAP24xx/OMAP34xx/OMAP44xx"
> +	depends on ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
>  	help
> -	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
> +	  SPI master controller for OMAP24xx/OMAP34xx/OMAP44xx Multichannel SPI
>  	  (McSPI) modules.
>  
>  config SPI_OMAP_100K

You can simplify this and make it more future proof with something like:

config SPI_OMAP24XX
	tristate "McSPI driver for OMAP"
	depends on ARCH_OMAP2PLUS
	help
	  SPI master controller for OMAP24XX and later

Regards,

Tony
