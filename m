From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: rename gpmc_probe_nor_child() to gpmc_probe_generic_child()
Date: Thu, 14 Mar 2013 13:51:23 -0500
Message-ID: <51421C2B.10700@ti.com>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk> <1363273762-17441-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab3CNSvi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 14:51:38 -0400
In-Reply-To: <1363273762-17441-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org


On 03/14/2013 10:09 AM, Javier Martinez Canillas wrote:
> The gpmc_probe_nor_child() function is used in the GPMC driver to
> configure the GPMC for a NOR child device node.
> 
> But this function is quite generic and all the NOR specific configuration
> is made by the driver of the actual NOR flash memory used.
> 
> Other Pseudo-SRAM devices such as ethernet controllers need a similar
> setup so by making this function generic it can be used for those too.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/gpmc.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 8799aed..898b44d 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1439,14 +1439,14 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
>  #endif
>  
>  /**
> - * gpmc_probe_nor_child - configures the gpmc for a nor device
> + * gpmc_probe_generic_child - configures the gpmc for a child device
>   * @pdev:	pointer to gpmc platform device
> - * @child:	pointer to device-tree node for nor device
> + * @child:	pointer to device-tree node for child device
>   *
> - * Allocates and configures a GPMC chip-select for a NOR flash device.
> + * Allocates and configures a GPMC chip-select for a child device.
>   * Returns 0 on success and appropriate negative error code on failure.
>   */
> -static int gpmc_probe_nor_child(struct platform_device *pdev,
> +static int gpmc_probe_generic_child(struct platform_device *pdev,
>  				struct device_node *child)
>  {
>  	struct gpmc_settings gpmc_s;
> @@ -1552,7 +1552,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  	}
>  
>  	for_each_node_by_name(child, "nor") {
> -		ret = gpmc_probe_nor_child(pdev, child);
> +		ret = gpmc_probe_generic_child(pdev, child);
>  		if (ret < 0) {
>  			of_node_put(child);
>  			return ret;
> 

Thanks, looks good. I will pick this up too.

Cheers
Jon
