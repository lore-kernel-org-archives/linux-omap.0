From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] OMAP2/3: mmc-twl4030: Free up MMC regulators while cleaning
 up
Date: Wed, 05 Aug 2009 18:25:19 +0300
Message-ID: <4A79A45F.2090509@nokia.com>
References: <1245762070-13302-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55528 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbZHEPZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:25:45 -0400
In-Reply-To: <1245762070-13302-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Roger Quadros <ext-roger.quadros@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Tony,

any comments on this?

regards,
-roger

ext Roger Quadros wrote:
> twl_mmc_cleanup() must free up the regulators that were
> allocated by twl_mmc_late_init().
> This eliminates the below error when 'omap_hsmmc' module is
> repeatedly loaded and unloaded.
> 
> "sysfs: cannot create duplicate filename '/devices/platform
>  /mmci-omap-hs.0/microamps_requested_vmmc'"
> 
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 06b252f..0007115 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -119,6 +119,7 @@ static int twl_mmc_late_init(struct device *dev)
>  				if (i != 0)
>  					break;
>  				ret = PTR_ERR(reg);
> +				hsmmc[i].vcc = NULL;
>  				goto err;
>  			}
>  			hsmmc[i].vcc = reg;
> @@ -165,8 +166,13 @@ done:
>  static void twl_mmc_cleanup(struct device *dev)
>  {
>  	struct omap_mmc_platform_data *mmc = dev->platform_data;
> +	int i;
>  
>  	gpio_free(mmc->slots[0].switch_pin);
> +	for(i = 0; i < ARRAY_SIZE(hsmmc); i++) {
> +		regulator_put(hsmmc[i].vcc);
> +		regulator_put(hsmmc[i].vcc_aux);
> +	}
>  }
>  
>  #ifdef CONFIG_PM

