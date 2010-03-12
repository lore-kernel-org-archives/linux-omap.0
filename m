From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] SPI omap2_mcspi: Add max_clk_div field to mcspi
 platform config
Date: Fri, 12 Mar 2010 09:21:48 -0800
Message-ID: <20100312172148.GG2900@atomide.com>
References: <1268407307.14445.51.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54845 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238Ab0CLRUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 12:20:39 -0500
Content-Disposition: inline
In-Reply-To: <1268407307.14445.51.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org

* Scott Ellis <scott@jumpnowtek.com> [100312 07:20]:
> The McSPI_CHxCONF.CLKD register field has different limits for the
> OMAP3 then the OMAP24xx. As per recommendation from the linux-omap
> list, added a field for max_clk_div to the platform data for use in 
> omap2_mcspi.c.
> 
> Used in a subsequent patch. 
> 
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
> 
>  arch/arm/mach-omap2/devices.c           |   16 ++++++++++++++++
>  arch/arm/plat-omap/include/plat/mcspi.h |    1 +
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 23e4d77..d4ad126 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -302,6 +302,11 @@ static inline void omap_init_sti(void) {}
>  
>  static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
>  	.num_cs		= 4,
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +	.max_clk_div	= 0x0c,
> +#else
> +	.max_clk_div	= 0x0f,
> +#endif
>  };
>  

Can't do ifdef else like this. It will break multi-omap booting on
omap2 + 3 + 4. In the platform init just set the values once with
cpu_is_omapXXXX() instead.

Regards,

Tony
