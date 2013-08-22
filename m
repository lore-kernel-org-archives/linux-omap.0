From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: add type cast from 'unsigned' to 'signed'
Date: Thu, 22 Aug 2013 00:14:02 -0700
Message-ID: <20130822071402.GQ7656@atomide.com>
References: <521479B4.8030604@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46887 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3HVHOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 03:14:08 -0400
Content-Disposition: inline
In-Reply-To: <521479B4.8030604@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Chen Gang <gang.chen@asianux.com> [130821 01:34]:
> Need add type cast, or can not notice the failure. The related warning
> (allmodconfig, "EXTRA_CFLAGS=-W"):
> 
>   arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index f3fdd6a..62377b5 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -725,7 +725,7 @@ static int gpmc_setup_irq(void)
>  		return -EINVAL;
>  
>  	gpmc_irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
> -	if (gpmc_irq_start < 0) {
> +	if ((signed)gpmc_irq_start < 0) {
>  		pr_err("irq_alloc_descs failed\n");
>  		return gpmc_irq_start;
>  	}

Hmm shouldn't we just have int gpmc_irq_start instead
of unsigned gpmc_irq_start?

Regards,

Tony
