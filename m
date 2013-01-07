From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] staging: tidspbridge: fix breakages due to CM
 reorganization
Date: Mon, 7 Jan 2013 15:03:31 -0800
Message-ID: <20130107230331.GA29943@kroah.com>
References: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34182 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab3AGXDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jan 2013 18:03:35 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so11008631pad.37
        for <linux-omap@vger.kernel.org>; Mon, 07 Jan 2013 15:03:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1356358225-25557-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: Tony Lindgren <tony@atomide.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

On Mon, Dec 24, 2012 at 08:10:24AM -0600, Omar Ramirez Luna wrote:
> 3.8-rc1 introduced changes in the clock management header files,
> this resulted in compilation breakages for this driver.
> 
> Define this locally while APIs are made available, given that driver
> code shouldn't include mach header files.
> 
> This fixes:
> drivers/staging/tidspbridge/core/tiomap3430.c:550:13: error:
> 'OMAP3430_CM_AUTOIDLE_PLL' undeclared (first use in this function)
> drivers/staging/tidspbridge/core/tiomap_io.c:416:13: error:
> 'OMAP3430_CM_CLKEN_PLL' undeclared (first use in this function)
> 
> Reported-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>

Enric sent me a patch that just includes the proper .h file, which
should be better than doing this:

> --- a/drivers/staging/tidspbridge/core/_tiomap.h
> +++ b/drivers/staging/tidspbridge/core/_tiomap.h
> @@ -40,6 +40,14 @@
>  #include <dspbridge/sync.h>
>  #include <dspbridge/clk.h>
>  
> +/*
> + * XXX These mach-omap2/ defines are wrong and should be removed.  No
> + * driver should read or write to PRM/CM registers directly; they
> + * should rely on OMAP core code to do this.
> + */
> +#define OMAP3430_CM_AUTOIDLE_PLL	0x0034
> +#define OMAP3430_CM_CLKEN_PLL		0x0004

Don't define things that are already defined elsewhere...

I'll not apply this.

thanks,

greg k-h
