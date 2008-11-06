From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] beagle to build again
Date: Thu, 6 Nov 2008 09:11:12 -0800
Message-ID: <20081106171111.GV21736@atomide.com>
References: <20081106140235.GD7467@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51279 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbYKFRLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 12:11:14 -0500
Content-Disposition: inline
In-Reply-To: <20081106140235.GD7467@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [081106 06:03]:
> Add missing include and make beagle build again.

Looks like this is covered by Dave's patch already.

Tony

> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 0f1c841..fb64845 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -43,6 +43,7 @@
>  #include <mach/nand.h>
>  #include <mach/mux.h>
>  
> +#include "mmc-twl4030.h"
>  #include "twl4030-generic-scripts.h"
>  
>  #define GPMC_CS0_BASE  0x60
> 
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
