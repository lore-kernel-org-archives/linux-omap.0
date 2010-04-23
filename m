From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/5] OMAP: Add support for setting the divider for
 sys_clkout2 using clk_set_rate
Date: Thu, 22 Apr 2010 18:55:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004221851130.24256@utopia.booyaka.com>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org> <1270572668-2336-2-git-send-email-lwalkera@ieee.org> <1270572668-2336-3-git-send-email-lwalkera@ieee.org> <1270572668-2336-4-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-5-git-send-email-lwalkera@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0DWAz1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 20:55:27 -0400
In-Reply-To: <1270572668-2336-5-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: linux-omap@vger.kernel.org

Hello Laine,

two minor comments:

On Tue, 6 Apr 2010, Laine Walker-Avina wrote:

> 
> Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>

Please add a brief changelog.  Nothing fancy needed...

> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index d5153b6..2a62779 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -1111,6 +1111,7 @@ static struct clk sys_clkout2 = {
>  	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
>  	.clksel		= sys_clkout2_clksel,
>  	.recalc		= &omap2_clksel_recalc,

Please add a .round_rate function pointer here also, pointing to 
omap2_clksel_round_rate.

> +	.set_rate	= &omap2_clksel_set_rate,
>  };
>  
>  /* CM OUTPUT CLOCKS */
> -- 
> 1.6.3.3


- Paul
