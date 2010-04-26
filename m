From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: CLK: FIX: warning SR fclk clk domain not found
Date: Mon, 26 Apr 2010 11:25:17 -0700
Message-ID: <87y6gat6k2.fsf@deeprootsystems.com>
References: <1272001288-6981-1-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:44035 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0DZSZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 14:25:22 -0400
Received: by pzk42 with SMTP id 42so8168999pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 11:25:21 -0700 (PDT)
In-Reply-To: <1272001288-6981-1-git-send-email-ambresh@ti.com> (Ambresh K.'s message of "Fri\, 23 Apr 2010 11\:11\:28 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ambresh K <ambresh@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Ambresh K <ambresh@ti.com> writes:

> Added clock domain name to sr[1,2] clk structure to fix warning
> while initialising sr hwmod during boot-up.
>
> Signed-off-by: Ambresh K <ambresh@ti.com>

Please add a better subject and changelog.  Something that would be
more useful when looking at this in git history down the road.
Something like "add SR clocks to WKUP clockdomain" for the suject is
more helpful.

Also, for the changelog, explain more about SmartReflex having its own
powerdomain but no clockdomain, thus why it's clocks are in the WKUP
clockdomain.

Kevin


> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index d5153b6..8a49d8a 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3100,6 +3100,7 @@ static struct clk sr1_fck = {
>  	.parent		= &sys_ck,
>  	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
>  	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
> +	.clkdm_name	= "wkup_clkdm",
>  	.recalc		= &followparent_recalc,
>  };
>  
> @@ -3110,6 +3111,7 @@ static struct clk sr2_fck = {
>  	.parent		= &sys_ck,
>  	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
>  	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
> +	.clkdm_name	= "wkup_clkdm",
>  	.recalc		= &followparent_recalc,
>  };
>  
> -- 
> 1.6.0.4
