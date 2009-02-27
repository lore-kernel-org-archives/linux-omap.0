From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP: McSPI: Unpaired clk_{en,dis}able calls.
Date: Fri, 27 Feb 2009 10:28:39 -0800
Message-ID: <20090227182838.GH11594@atomide.com>
References: <1235057042-6833-1-git-send-email-ext-phil.2.carmody@nokia.com> <e1ddb08341604496c13766d174bfe055662cc917.1235046721.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61625 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbZB0S2n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 13:28:43 -0500
Content-Disposition: inline
In-Reply-To: <e1ddb08341604496c13766d174bfe055662cc917.1235046721.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: linux-omap@vger.kernel.org

* Phil Carmody <ext-phil.2.carmody@nokia.com> [090219 07:26]:
> If the sky is always blue, and no functions fail, then the interface
> and functional clocks will always be in the same state. However,
> defensively, failure to enable the 2nd should re-disable the 1st.

This too should be sent for mainline integration. See "SPI SUBSYSTEM"
in the MAINTAINERS file.

Regards,

Tony
 
> Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
> ---
>  drivers/spi/omap2_mcspi.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 3da8825..bdccb27 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -277,9 +277,10 @@ static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
>  {
>  	if (clk_enable(mcspi->ick))
>  		return -ENODEV;
> -	if (clk_enable(mcspi->fck))
> +	if (clk_enable(mcspi->fck)) {
> +		clk_disable(mcspi->ick);
>  		return -ENODEV;
> -
> +	}
>  	omap2_mcspi_restore_ctx(mcspi);
>  
>  	return 0;
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
