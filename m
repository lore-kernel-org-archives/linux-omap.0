From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix path for omap-sha1-md5 import of irqs.h
Date: Thu, 14 May 2009 09:56:28 -0700
Message-ID: <20090514165627.GJ5593@atomide.com>
References: <49D7D3BB.30500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63182 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZENQ43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 12:56:29 -0400
Content-Disposition: inline
In-Reply-To: <49D7D3BB.30500@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Auty <mike.auty@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Mike Auty <mike.auty@gmail.com> [090404 14:40]:
> Hi there,
> 
> This is my first kernel-type patch, so please go easy on me if I've made
> any mistakes.  I recently tried building the master kernel from master
> (commit e75343a207ef24490176abe3503743d7a006e299) and it failed at
> omap-sha1-md5.c with a file not found issue (asm/arch-omap/irqs.h).    I
> looked for a similar file, and figured that it meant
> asm/plat-omap/include/mach/irqs.h, so I produced the patch below.
> Hopefully that's the correct solution, but I'd appreciate it if someone
> else could look it over too.  Thanks very much,

Sorry for the delay.. I'll apply this to linux-omap tree. Do you want
to take this driver and prepare a patch to the associated driver mailing
list so we can get it integrated?

Regards,

Tony

 
> Mike  5:)
> 
> ---
>  drivers/crypto/omap-sha1-md5.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/crypto/omap-sha1-md5.c b/drivers/crypto/omap-sha1-md5.c
> index 6d77703..90ad56f 100644
> --- a/drivers/crypto/omap-sha1-md5.c
> +++ b/drivers/crypto/omap-sha1-md5.c
> @@ -13,7 +13,7 @@
>   * This driver is based on padlock-sha.c driver.
>   */
> 
> -#include <asm/arch-omap/irqs.h>
> +#include <mach/irqs.h>
>  #include <crypto/algapi.h>
>  #include <crypto/sha.h>
>  #include <linux/err.h>
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
