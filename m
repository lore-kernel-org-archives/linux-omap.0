From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2 04/11] OMAP2+: use control module mfd driver in
 omap_type
Date: Wed, 20 Jun 2012 03:24:11 -0700
Message-ID: <20120620102410.GA12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11C6.6000400@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12223 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab2FTKYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 06:24:16 -0400
Content-Disposition: inline
In-Reply-To: <4FDF11C6.6000400@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120618 04:36]:
> OMAP system control module can be probed early, then
> omap_type is safe to use its APIs.
> 
> TODO: add support for other omap versions
> 
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> 
> ---
>  arch/arm/mach-omap2/id.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/arm/mach-omap2/id.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/id.c
> +++ linux-2.6/arch/arm/mach-omap2/id.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/mfd/omap_control.h>
>  
>  #include <asm/cputype.h>
>  
> @@ -38,6 +39,8 @@ unsigned int omap_rev(void)
>  }
>  EXPORT_SYMBOL(omap_rev);
>  
> +u32 omap_control_readl(u16 offset);
> +
>  int omap_type(void)
>  {
>  	u32 val = 0;
> @@ -49,7 +52,7 @@ int omap_type(void)
>  	} else if (cpu_is_omap34xx()) {
>  		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>  	} else if (cpu_is_omap44xx()) {
> -		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +		val = omap_control_readl(OMAP4_CTRL_MODULE_CORE_STATUS);

Please just set up a function in the ctrl module core to return the
status so you can get rid of omap_control_readl here.

Tony
