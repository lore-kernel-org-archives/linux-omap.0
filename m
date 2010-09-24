From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Fri, 24 Sep 2010 09:34:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009240920370.10678@utopia.booyaka.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59413 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0IXPeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:34:06 -0400
In-Reply-To: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Omar, Kevin,

On Thu, 23 Sep 2010, Omar Ramirez Luna wrote:

> From: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Since omap3_features is a global variable, only code
> built-in the kernel can make use of it and thus use
> omap_has ##feat functions; exporting this as a kernel
> symbol makes modules able to use feature detection
> framework too.
> 
> Thread: http://marc.info/?l=linux-omap&m=128528822902211&w=2
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Nishanth Menon <nm@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> CC: Sanjeev Premi <premi@ti.com>
> CC: linux-omap@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/mach-omap2/id.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 9a879f9..a8c6d19 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -31,6 +31,7 @@ static struct omap_chip_id omap_chip;
>  static unsigned int omap_revision;
>  
>  u32 omap3_features;
> +EXPORT_SYMBOL(omap3_features);
>  
>  unsigned int omap_rev(void)
>  {
> -- 
> 1.7.1
> 

This omap3_features variable should not be used directly by any device 
drivers since it is an OMAP-ism.  This type of feature info should be 
passed through struct platform_data.  Looks like this would be quite easy 
to add by editing mach-omap2/devices.c and adding platform_data?

...

In the medium-term, definitely all of those 

    #if defined(CONFIG_ARCH_OMAP*)

and 

    if (cpu_is_omap*()) {

in this driver need to be removed.  The integration code (currently in 
mach-omap2/devices.c) is what should handle this, or better yet, struct 
dev_attr from hwmod.

Also the entire mailboxes driver at some point should be moved into 
drivers/* ...


- Paul
