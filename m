From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 3/3] OMAP: cs should be positive in gpmc_cs_free()
Date: Wed, 18 Nov 2009 10:37:18 -0800
Message-ID: <20091118183718.GO29266@atomide.com>
References: <200911172239.nAHMd6Js018329@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58693 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbZKRShk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 13:37:40 -0500
Content-Disposition: inline
In-Reply-To: <200911172239.nAHMd6Js018329@imap1.linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: akpm@linux-foundation.org
Cc: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, roel.kluin@gmail.com, linux-omap@vger.kernel.org

* akpm@linux-foundation.org <akpm@linux-foundation.org> [091117 14:39]:
> From: Roel Kluin <roel.kluin@gmail.com>
> 
> The index `cs' is signed, test whether it is negative before we release
> gpmc_cs_mem[cs].

I've added this too to omap-fixes and will send to Linus.

Regards,

Tony
 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm/mach-omap2/gpmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN arch/arm/mach-omap2/gpmc.c~omap-cs-should-be-positive-in-gpmc_cs_free arch/arm/mach-omap2/gpmc.c
> --- a/arch/arm/mach-omap2/gpmc.c~omap-cs-should-be-positive-in-gpmc_cs_free
> +++ a/arch/arm/mach-omap2/gpmc.c
> @@ -405,7 +405,7 @@ EXPORT_SYMBOL(gpmc_cs_request);
>  void gpmc_cs_free(int cs)
>  {
>  	spin_lock(&gpmc_mem_lock);
> -	if (cs >= GPMC_CS_NUM || !gpmc_cs_reserved(cs)) {
> +	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
>  		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
>  		BUG();
>  		spin_unlock(&gpmc_mem_lock);
> _
