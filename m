From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: only search for GPMC DT child nodes on probe
Date: Wed, 17 Apr 2013 13:59:13 -0500
Message-ID: <516EF101.4030604@ti.com>
References: <1366216651-11164-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966246Ab3DQS7Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 14:59:25 -0400
In-Reply-To: <1366216651-11164-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Lars Poeschel <poeschel@lemonage.de>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>


On 04/17/2013 11:37 AM, Javier Martinez Canillas wrote:
> The GPMC DT probe function use for_each_node_by_name() to search
> child device nodes of the GPMC controller. But this function does
> not use the GPMC device node as the root of the search and instead
> search across the complete Device Tree.
> 
> This means that any device node on the DT that is using any of the
> GPMC child nodes names searched for will be returned even if they
> are not connected to the GPMC, making the gpmc_probe_xxx_child()
> function to fail.
> 
> Fix this by using the GPMC device node as the search root so the
> search will be restricted to its children.
> 
> Also, if any of the GPMC child nodes fails, this shouldn't make
> the whole gpmc_probe_dt() function to fail. It is better to just
> WARN and allow other devices probe function to succeed.
> 
> Reported-by: Lars Poeschel <poeschel@lemonage.de>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/gpmc.c |   41 +++++++++++++++++------------------------
>  1 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index ed946df..f10d735 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1520,35 +1520,28 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	for_each_node_by_name(child, "nand") {
> -		ret = gpmc_probe_nand_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> -		}
> -	}
> +	for_each_child_of_node(pdev->dev.of_node, child) {
> +
> +		if (!child->name)
> +			continue;
>  
> -	for_each_node_by_name(child, "onenand") {
> -		ret = gpmc_probe_onenand_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> +		if (of_node_cmp(child->name, "nand") == 0) {
> +			ret = gpmc_probe_nand_child(pdev, child);
> +			if (WARN_ON(ret < 0))

I am wondering if we should use "WARN" here and say "probing gpmc child
%s failed\n" and print the fullname. Otherwise it may be unclear which
device failed.

> +				of_node_put(child);
>  		}
> -	}
>  
> -	for_each_node_by_name(child, "nor") {
> -		ret = gpmc_probe_generic_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> +		if (of_node_cmp(child->name, "onenand") == 0) {

This could also be an "else if" to save comparing each child
unnecessarily if it previously matched. That way you could just have a
single WARN statement at the end of the loop and condense this code.

> +			ret = gpmc_probe_onenand_child(pdev, child);
> +			if (WARN_ON(ret < 0))
> +				of_node_put(child);
>  		}
> -	}
>  
> -	for_each_node_by_name(child, "ethernet") {
> -		ret = gpmc_probe_generic_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> +		if (of_node_cmp(child->name, "ethernet") == 0 ||
> +		    of_node_cmp(child->name, "nor") == 0) {
> +			ret = gpmc_probe_generic_child(pdev, child);
> +			if (WARN_ON(ret < 0))
> +				of_node_put(child);
>  		}
>  	}

Otherwise looks good.

Cheers
Jon
