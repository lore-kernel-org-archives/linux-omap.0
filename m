From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3]: OMAP3:PM: Add power state parameter for omap_uart_prepare_idle
Date: Tue, 29 Jun 2010 08:33:18 -0700
Message-ID: <87fx05ua4h.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0323763485@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60763 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab0F2PdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 11:33:25 -0400
Received: by pzk3 with SMTP id 3so833585pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 08:33:24 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323763485@dbde02.ent.ti.com>
	(Teerth Reddy's message of "Tue, 29 Jun 2010 12:29:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> This patch has the changes which adds power state parameter
> for the omap_uart_prepare_idle idle function.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/mach-omap2/pm24xx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Subject says  OMAP3, but this is for OMAP2.

Kevin

>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index e321281..7046e74 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -119,9 +119,9 @@ static void omap2_enter_full_retention(void)
>  	if (omap_irq_pending())
>  		goto no_sleep;
>  
> -	omap_uart_prepare_idle(0);
> -	omap_uart_prepare_idle(1);
> -	omap_uart_prepare_idle(2);
> +	omap_uart_prepare_idle(0, PWRDM_POWER_RET);
> +	omap_uart_prepare_idle(1, PWRDM_POWER_RET);
> +	omap_uart_prepare_idle(2, PWRDM_POWER_RET);
>  
>  	/* Jump to SRAM suspend code */
>  	omap2_sram_suspend(sdrc_read_reg(SDRC_DLLA_CTRL),
