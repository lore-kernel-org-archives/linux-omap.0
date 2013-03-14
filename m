From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: return -ENODEV if GPMC child device
 creation fails
Date: Thu, 14 Mar 2013 13:50:28 -0500
Message-ID: <51421BF4.3050703@ti.com>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk> <1363273762-17441-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60549 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab3CNSu4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 14:50:56 -0400
In-Reply-To: <1363273762-17441-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org



On 03/14/2013 10:09 AM, Javier Martinez Canillas wrote:
> gpmc_probe_nor_child() calls of_platform_device_create() to create a
> platform device for the NOR child. If this function fails the value
> of ret is returned to the caller but this value is zero since it was
> assigned the return of a previous call to gpmc_cs_program_settings()
> that had to succeed or otherwise gpmc_probe_nor_child() would have
> returned before.
> 
> This means that if of_platform_device_create() fails, 0 will be returned
> to the caller instead of an appropriate error code.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/gpmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index d594e1d..8799aed 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1505,6 +1505,7 @@ static int gpmc_probe_nor_child(struct platform_device *pdev,
>  		return 0;
>  
>  	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
> +	ret = -ENODEV;
>  
>  err:
>  	gpmc_cs_free(cs);

Good catch! Thanks for the fix, I will pick this up.

Cheers
Jon
