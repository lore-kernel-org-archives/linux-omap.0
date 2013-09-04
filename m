From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 3/4] Misc: SRAM: Hack for allowing executable code in
 SRAM.
Date: Wed, 4 Sep 2013 11:06:39 -0700
Message-ID: <20130904180638.GC31541@atomide.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
 <1378226665-27090-4-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52208 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759716Ab3IDSGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 14:06:45 -0400
Content-Disposition: inline
In-Reply-To: <1378226665-27090-4-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, mans@mansr.com

* Russ Dill <Russ.Dill@ti.com> [130903 09:52]:
> The generic SRAM mechanism does not ioremap memory in a
> manner that allows code to be executed from SRAM. There is
> currently no generic way to request ioremap to return a
> memory area with execution allowed.
> 
> Insert a temporary hack for proof of concept on ARM.
> 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
> ---
>  drivers/misc/sram.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 08baaab..e059a23 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -31,6 +31,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/sram.h>
>  #include <asm-generic/cacheflush.h>
> +#include <asm/io.h>
>  
>  #define SRAM_GRANULARITY	32
>  
> @@ -138,7 +139,7 @@ static int sram_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	virt_base = devm_ioremap_resource(&pdev->dev, res);
> +	virt_base = __arm_ioremap_exec(res->start, resource_size(res), false);
>  	if (IS_ERR(virt_base))
>  		return PTR_ERR(virt_base);

You can get rid of this hack by defining ioremap_exec in
include/asm-generic/io.h the same way as ioremap_nocache
is done:

#ifndef ioremap_exec
#define ioremap_exec ioremap
#endif

Then the arch that need ioremap_exec can define and
implement it. Needs to be reviewed on LKML naturally :)

Regards,

Tony
