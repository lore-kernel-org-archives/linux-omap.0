From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: omap2: gpmc: Remove unneeded of_node_put()
Date: Fri, 25 Jan 2013 08:18:11 -0600
Message-ID: <51029423.2040106@ti.com>
References: <1359116387-32613-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41067 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347Ab3AYOSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 09:18:20 -0500
In-Reply-To: <1359116387-32613-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, tony@atomide.com, matthias.bgg@googlemail.com


On 01/25/2013 06:19 AM, Ezequiel Garcia wrote:
> for_each_node_by_name() automatically calls of_node_put() on each
> node passed; so don't do it explicitly unless there's an error.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 01ce462..c6255f7 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1271,9 +1271,10 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  
>  	for_each_node_by_name(child, "nand") {
>  		ret = gpmc_probe_nand_child(pdev, child);
> -		of_node_put(child);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(child);
>  			return ret;
> +		}
>  	}
>  
>  	return 0;
> 

Acked-by: Jon Hunter <jon-hunter@ti.com>

Thanks!
Jon
