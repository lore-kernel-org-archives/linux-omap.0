From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in
 GPMC driver
Date: Thu, 6 Nov 2014 10:52:36 -0800
Message-ID: <20141106185235.GD31454@atomide.com>
References: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
 <1395209295-24399-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22611 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbaKFSxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 13:53:38 -0500
Content-Disposition: inline
In-Reply-To: <1395209295-24399-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Russell King <linux@arm.linux.org.uk>, Beno??t Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [140318 23:12]:
> The GPMC driver includes arch/arm/mach-omap2/common.h but
> does not use anything on that header so it can be removed.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Probably meant Cc here? :) I'll apply this into omap-for-v3.19/gpmc,
the rest will need to wait until omap3 is DT only.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/gpmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index ab43755..b637c96 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -37,7 +37,6 @@
>  #include <asm/mach-types.h>
>  
>  #include "soc.h"
> -#include "common.h"
>  #include "omap_device.h"
>  #include "gpmc.h"
>  #include "gpmc-nand.h"
> -- 
> 1.9.0
> 
