From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest additional build warnings
Date: Sat, 9 Feb 2013 19:47:31 -0800
Message-ID: <20130210034731.GF4801@atomide.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130209114918.GJ17852@n2100.arm.linux.org.uk>
 <20130210030032.GC4801@atomide.com>
 <CAOesGMgvEVsB7OWs43EWjgsR8af2_RZS9Dod3PURu6Tvdi4QJw@mail.gmail.com>
 <20130210032234.GE4801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54757 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761033Ab3BJDrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 22:47:35 -0500
Content-Disposition: inline
In-Reply-To: <20130210032234.GE4801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130209 19:29]:
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Sat, 9 Feb 2013 19:20:57 -0800
> Subject: [PATCH] ARCH: OMAP2+: Make sure files with omap initcalls include soc.h

Oops, will fix up the subject to say ARM: OMAP2+ instead of ARCH..
 
> Looks like there are few more places that I missed that can cause
> compiler warnings. After grepping for omap initcall, all files
> needing soc.h should now have it.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  
>  #include <linux/platform_data/iommu-omap.h>
> +#include "soc.h"
>  #include "omap_hwmod.h"
>  #include "omap_device.h"
>  
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/power/smartreflex.h>
> +#include "soc.h"
>  #include "voltage.h"
>  
>  static int sr_class3_enable(struct omap_sr *sr)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
