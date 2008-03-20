From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at host driver.
Date: Fri, 21 Mar 2008 00:54:42 +0200
Message-ID: <20080320225441.GA4373@kedavra.cpe.vivax.com.br>
References: <47E2C7FE.9020908@indt.org.br>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59062 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbYCTWwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 18:52:35 -0400
Content-Disposition: inline
In-Reply-To: <47E2C7FE.9020908@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 04:24:30PM -0400, Carlos Aguiar wrote:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This patch fixes the HSMMC driver name at host driver.
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 047c64d..0e7ee20 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -92,7 +92,7 @@
>  #define OMAP_MMC_DATADIR_WRITE	2
>  #define MMC_TIMEOUT_MS		20
>  #define OMAP_MMC_MASTER_CLOCK	96000000
> -#define DRIVER_NAME		"mmci-omap"
> +#define DRIVER_NAME		"hsmmc-omap"

stupid question :-p
what does the 'i' means?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
