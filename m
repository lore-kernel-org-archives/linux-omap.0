From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap2_mcspi.c: Clock divider range check wrong for
 OMAP3
Date: Mon, 8 Mar 2010 17:53:55 +0200
Message-ID: <20100308155354.GA3867@gandalf>
References: <1268049411.2558.76.camel@quad>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44301 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0CHPxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 10:53:44 -0500
Content-Disposition: inline
In-Reply-To: <1268049411.2558.76.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 08, 2010 at 06:56:51AM -0500, Scott Ellis wrote:
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index fe1b56d..a73127b 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -38,8 +38,17 @@
>  #include <plat/dma.h>
>  #include <plat/clock.h>
>  
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +#define OMAP2_MCSPI_MAX_CLK_DIV                12
> +#else
> +/* could be 12 for OMAP24xxx also, no docs to check */
> +#define OMAP2_MCSPI_MAX_CLK_DIV                15
> +#endif
>  
>  #define OMAP2_MCSPI_MAX_FREQ           48000000
> +#define OMAP2_MCSPI_MIN_FREQ   (OMAP2_MCSPI_MAX_FREQ \
> +                                       / (1 << OMAP2_MCSPI_MAX_CLK_DIV))

please don't break multi-omap builds. Pass this constant using platform_data.

-- 
balbi

