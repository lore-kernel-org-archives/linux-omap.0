From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [PATCH 2/4] OMAP4: SPI: Fix Driver Kconfig
Date: Wed, 5 May 2010 01:24:32 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEB8B8@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DC15EBB@dlee03.ent.ti.com>
 <20100504194833.GJ29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37346 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218Ab0EEGYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 02:24:47 -0400
In-Reply-To: <20100504194833.GJ29604@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Tony,

> >  config SPI_OMAP24XX
> > -	tristate "McSPI driver for OMAP24xx/OMAP34xx"
> > -	depends on ARCH_OMAP2 || ARCH_OMAP3
> > +	tristate "McSPI driver for OMAP24xx/OMAP34xx/OMAP44xx"
> > +	depends on ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
> >  	help
> > -	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
> > +	  SPI master controller for OMAP24xx/OMAP34xx/OMAP44xx Multichannel SPI
> >  	  (McSPI) modules.
> >
> >  config SPI_OMAP_100K
> 
> You can simplify this and make it more future proof with something like:
> 
> config SPI_OMAP24XX
> 	tristate "McSPI driver for OMAP"
> 	depends on ARCH_OMAP2PLUS
> 	help
> 	  SPI master controller for OMAP24XX and later

Changed as suggested...

ARCH_OMAP2PLUS
"Systems based on omap24xx, omap34xx or omap44xx"

Best Regards
Abraham
