From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2 usb-ehci: Add missing dma-mapping.h
Date: Thu, 10 Jun 2010 09:22:54 +0300
Message-ID: <20100610062253.GM32208@atomide.com>
References: <1275930041-17500-1-git-send-email-jic23@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62527 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0FJGWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 02:22:52 -0400
Content-Disposition: inline
In-Reply-To: <1275930041-17500-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-omap@vger.kernel.org, eballetbo@iseebcn.com

* Jonathan Cameron <jic23@cam.ac.uk> [100607 19:55]:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  I'm not a user of this code but was browsing the kautobuild logs
>  and saw the igep0020 build error that has been there since
>  24th of May using the defconfig.  Looks like a trivial
>  missing header to me.  I can not verify the resulting
>  build works, but it does build cleanly with this patch
>  on mainline as of a few minutes ago.  Sorry for the noise
>  if this has already been addressed but I'm not seeing
>  anything in the linux-omap@vger archive.

Thanks, a similar patch from Amit Kucheria is already queued up:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=bfb01197589965663772e6388f2bdf452e25adf2

Regards,

Tony
 
>  arch/arm/mach-omap2/usb-ehci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index c68f799..465699f 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
>  #include <asm/io.h>
>  #include <plat/mux.h>
>  
> -- 
> 1.6.4.4
> 
