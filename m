From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: SmartReflex: soc.h is needed for omap
 initcalls
Date: Tue, 12 Feb 2013 17:12:33 -0800
Message-ID: <20130213011233.GC11362@atomide.com>
References: <1360707836-2545-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752252Ab3BMBMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 20:12:35 -0500
Content-Disposition: inline
In-Reply-To: <1360707836-2545-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130212 14:27]:
> commit aa4f99638b (ARM: OMAP2+: Use omap initcalls) converted
> the initcalls here, but did not #include "soc.h" where the omap
> inicalls are defined.
> 
> To fix, #include <soc.h>

Thanks, this should be already fixed in arm-soc/for-next. I might
have forgotten to merge these into omap-for-v3.9/tmp-merge though.

Regards,

Tony

 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> Tony, the patch that broke this was introduced in your
> omap-for-v3.9/multiplatform-enable-signed branch, and this problem was
> found only when compiling with PM (specifically, SmartReflex) enabled.
> 
>  arch/arm/mach-omap2/smartreflex-class3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
> index 80f3acb..b2dcbd3 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/power/smartreflex.h>
>  #include "voltage.h"
> +#include "soc.h"
>  
>  static int sr_class3_enable(struct omap_sr *sr)
>  {
> -- 
> 1.8.1.2
> 
