From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][RFT][PATCH 3/4 v5b] OMAP: McBSP: Introduce caching in
 register write operations
Date: Mon, 7 Dec 2009 09:55:35 -0800
Message-ID: <20091207175534.GZ24013@atomide.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
 <4B19074B.1000606@tis.icnet.pl>
 <20091204191745.GH24013@atomide.com>
 <200912051447.41777.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54389 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200AbZLGRzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 12:55:35 -0500
Content-Disposition: inline
In-Reply-To: <200912051447.41777.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Hi,

This is pretty close :) Few more tweaks are still needed.

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091205 05:46]:
> Reserve static space for storing cached copies of McBSP register values.
> Split omap_mcbsp_read()/omap_mcbsp_write() into separate functions for OMAP1
> and OMAP2/3/4, move them from plat-omap to mach-omap1 / mach-omap2 to be able
> to access the static cache.
> Modify omap_msbcp_write() to update the cache with every register write
> operation.
> Modify omap_mcbsp_read() to support reading from cache or hardware.
> Update MCBSP_READ/MCBSP_WRITE macros for modified function APIs.
> Introduce a new macro that reads from the cache.
> 
> Applies on top of patch 2 from this series:
> [PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros API for caching
> 
> Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
> commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c.
> Compile-tested with omap_generic_2420_defconfig, omap_3430sdp_defconfig.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> ---
> 
> Tony,
> 
> Since I was not sure what your primary concern was, I've prepared two
> alternative versions of patch 3/4.
> Please take this one as a base for further discussion if your primary concern
> was storage class for the cache.
> Otherwise, have a look at the other one (v5a), since this one has even more
> ifdefs than before.
> 
> Thanks,
> Janusz
> 
> diff -upr git.orig/arch/arm/mach-omap1/mcbsp.c git/arch/arm/mach-omap1/mcbsp.c
> --- git.orig/arch/arm/mach-omap1/mcbsp.c	2009-12-02 15:48:37.000000000 +0100
> +++ git/arch/arm/mach-omap1/mcbsp.c	2009-12-05 06:42:35.000000000 +0100
> @@ -200,3 +200,26 @@ int __init omap1_mcbsp_init(void)
>  }
>  
>  arch_initcall(omap1_mcbsp_init);
> +
> +/* if adding more, put larger first */
> +#if defined(CONFIG_ARCH_OMAP16XX)
> +static u16 omap_mcbsp_cache[OMAP16XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
> +#elif defined(CONFIG_ARCH_OMAP15XX)
> +static u16 omap_mcbsp_cache[OMAP15XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
> +#elif defined(CONFIG_ARCH_OMAP7XX)
> +static u16 omap_mcbsp_cache[OMAP7XX_MCBSP_PDATA_SZ][OMAP_MCBSP_REG_COUNT];
> +#else
> +#define omap_mcbsp_cache	NULL
> +#endif

As 15xx and 16xx can be compiled into the same kernel binary, we need to
get rid of the ifdef elif else (untested):

#ifdef(CONFIG_ARCH_OMAP7XX)
static u16 omap7xx_mcbsp_cache[OMAP7XX_MCBSP_PDATA_SZ][OMAP7XX_MCBSP_REG_COUNT];
#else
static 16 omap7xx_mcbsp_cache;
#endif

#if defined(CONFIG_ARCH_OMAP15XX)
static u16 omap15xx_mcbsp_cache[OMAP15XX_MCBSP_PDATA_SZ][OMAP15XX_MCBSP_REG_COUNT];
#else
static 16 omap15xx_mcbsp_cache;
#endif

#if defined(CONFIG_ARCH_OMAP16XX)
static u16 omap16xx_mcbsp_cache[OMAP16XX_MCBSP_PDATA_SZ][OMAP_16XXMCBSP_REG_COUNT];
#else
static 16 omap16xx_mcbsp_cache;
#endif
...


> +void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
> +{
> +	omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] = (u16)val;
> +	__raw_writew((u16)val, mcbsp->io_base + reg);
> +}
> +
> +int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
> +{
> +	return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
> +			omap_mcbsp_cache[mcbsp->id][reg / sizeof(u16)];
> +}

Then these can become something like this:

void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
{
	if (cpu_is_omap7xx())
		omap7xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] = (u16)val;
	else if (cpu_is_omap15xx())
		omap15xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] = (u16)val;
	else if (cpu_is_omap16xx())
		omap16xx_mcbsp_cache[mcbsp->id][reg / sizeof(u16)] = (u16)val;

	__raw_writew((u16)val, mcbsp->io_base + reg);
}
...

The code for processors that are not compiled in will get automatically
optimized out as the cpu_is_xxxx() becomes 0.

Regards,

Tony
