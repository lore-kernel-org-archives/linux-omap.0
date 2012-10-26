From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
Date: Fri, 26 Oct 2012 09:39:00 -0700
Message-ID: <20121026163900.GC11908@atomide.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220456.26676.31050.stgit@muffinssi.local>
 <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44360 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965301Ab2JZQjC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 12:39:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121025 18:28]:
> Hi Tony
> 
> On Thu, 4 Oct 2012, Tony Lindgren wrote:
> 
> > Let's make omap_device local to mach-omap2 for
> > ARM common zImage support.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This one breaks a 5912-only build:
> 
> arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_init':
> arch/arm/mach-omap1/pm_bus.c:69:2: error: implicit declaration of function 
> 'cpu_class_is_omap1'
> make[1]: *** [arch/arm/mach-omap1/pm_bus.o] Error 1
> 
> Fixed by the usual change; it's below.

Thanks. I've ran randonfigs on the omap-for-v3.8/cleanup-headers,
but have not seen these.

Can you do a branch on top of omap-for-v3.8/cleanup-headers
with all these fixes that I can pull in?

Regards,

Tony
 
>  arch/arm/mach-omap1/pm_bus.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
> index 16bf2f9..3f2d396 100644
> --- a/arch/arm/mach-omap1/pm_bus.c
> +++ b/arch/arm/mach-omap1/pm_bus.c
> @@ -19,6 +19,8 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  
> +#include "soc.h"
> +
>  #ifdef CONFIG_PM_RUNTIME
>  static int omap1_pm_runtime_suspend(struct device *dev)
>  {
> -- 
> 1.7.10.4
> 
