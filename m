From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM restore observability settings after off mode
Date: Tue, 13 Oct 2009 14:08:39 -0700
Message-ID: <877huzhui0.fsf@deeprootsystems.com>
References: <1255359790-10407-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:53138 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760528AbZJMVJR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 17:09:17 -0400
Received: by pxi10 with SMTP id 10so243877pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 14:08:41 -0700 (PDT)
In-Reply-To: <1255359790-10407-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 12 Oct 2009 18\:03\:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch restores the observability settings after resuming from off mode.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

I decided not to pull this one into PM branch, because...

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 553fe02..20c7ea2 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -42,6 +42,7 @@
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
>  #include <mach/dma.h>
> +#include <mach/debobs.h>
>  #include <asm/tlbflush.h>
>  
>  #include "cm.h"
> @@ -124,6 +125,9 @@ static void omap3_core_restore_context(void)
>  	/* Restore the interrupt controller context */
>  	omap3_intc_restore_context();
>  	omap_dma_global_context_restore();
> +	/* restore debobs context */
> +	debobs_restore();
> +

of compile failure when CONFIG_PM_DEBOBS is not enabled.

And, debobs should now go upstream indepenent of PM branch.

When I posted my PM debug series for the last merge window, I
originally included the debobs series.  It recieved some comments on
the list that need to be addressed before this can go upstream.

Now that the main PM debug stuff is in mainline, this series has no
more dependencies on the PM branch.  I think you should address the
the comments/questions raised on the list[1,2] and resubmit as a
series against mainline.

A quick test shows that the current set of 3 debobs patches currently
in the PM branch rebase easily against omap/master so should be easy
to rework for upstream acceptance.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=125049645823777&w=2
[2] http://marc.info/?l=linux-omap&m=125049651623911&w=2
