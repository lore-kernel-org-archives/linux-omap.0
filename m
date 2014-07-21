From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/7] ARM: OMAP4+: PRM: register interrupt information
 from DT
Date: Mon, 21 Jul 2014 03:51:49 -0700
Message-ID: <20140721105149.GU18374@atomide.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
 <1402025761-16831-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17790 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754350AbaGUKxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 06:53:15 -0400
Content-Disposition: inline
In-Reply-To: <1402025761-16831-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140605 20:37]:
> Allow the PRM interrupt information to be picked up from device tree.
> the only exception is for OMAP4 which uses values pre-populated and allows
> compatibility with older dtb.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/prm44xx.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index 1ecf244..784b3e1 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -17,6 +17,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/of_irq.h>
>  
>  
>  #include "soc.h"
> @@ -698,11 +699,51 @@ int __init omap44xx_prm_init(void)
>  	return prm_register(&omap44xx_prm_ll_data);
>  }
>  
> +static struct of_device_id omap_prm_dt_match_table[] = {
> +	{ .compatible = "ti,omap4-prm" },
> +	{ .compatible = "ti,omap5-prm" },
> +	{ .compatible = "ti,dra7-prm" },
> +	{ }
> +};
> +

I'd like to avoid adding more driver like stuff to mach-omap2
and parsing compatible flags and dealing with interupts sounds
very driver like.. But maybe just the handling can be moved
out?

Would a simple driver be doable that parses the compatible
flags, takes care of the IRQ chaining, and gets some SoC specific
function pointers as auxdata?

That would allow further work later on to remove the auxdata
dependencies possibly.

Regards,

Tony
