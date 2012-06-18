From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 5/7] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Mon, 18 Jun 2012 09:45:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206180937500.9031@utopia.booyaka.com>
References: <20120618061037.30632.28539.stgit@dusk> <20120618061608.30632.62660.stgit@dusk> <4FDEF668.6050108@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43897 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2FRPpz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 11:45:55 -0400
In-Reply-To: <4FDEF668.6050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi

On Mon, 18 Jun 2012, Cousson, Benoit wrote:

> I guess that patch need to be revisited based on discussion we had and 
> the patch you proposed in [1]. Assuming Tony is OK, it should be 
> probably part of the -rc, because this domain should not have been 
> introduced in 3.5-rc1 at all for OMAP4.

Well as mentioned already on the lists, these clockdomains clearly exist; 
they are documented in the TRM and functional specification, and make 
sense from a chip perspective.

For 3.6, I've already agreed to remove those clockdomains, even though it 
doesn't really match what's there on the chip.  But I think 3.6 is the 
right time to do that.

> So it will be better to revert the patch that introduced that first 
> before adding any new fix that will rely on a code that will disappear.
>
> In fact, I think the proper way to fix that while maintaining the 
> OMAP2&3 way of dealing with clkdm is to ensure that at least one clkdm 
> is there in either hwmod or the main_clk. That will fix these issues and 
> the one that will append when the fake main_clk will be removed.
> 
> Here is a patch that is doing that.

Please document what systems this has been tested on.

> Thanks,
> Benoit
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70177.html
> 
> 
> --- 
> >From e5ffe6533236125c3c0b5eff883bfc1cf3cbe9f4 Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Fri, 15 Jun 2012 11:26:49 +0200
> Subject: [PATCH] ARM: OMAP2+: hwmod: Do not check clkdm for main_clk if oh does have one
> 
> When a clkdm is handled directly at the hwmod level, there is no need to handle
> it with the main_clk as well. It is thus useless to complain about the missing clkdm for the main_clk in that case.
> 
> Warn only if the clkdm is missing in both main_clk and hwmod.
> 
> Init hwmod clkdm first to ensure it will be there when the main_clk
> will be initialized.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 162f9c7..f33f4e2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -609,7 +609,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
>  		return -EINVAL;
>  	}
>  
> -	if (!oh->_clk->clkdm)
> +	if (!oh->_clk->clkdm && !oh->clkdm)
>  		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
>  			   oh->main_clk, oh->_clk->name);
>  
> @@ -1339,10 +1339,10 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
>  
>  	pr_debug("omap_hwmod: %s: looking up clocks\n", oh->name);
>  
> +	ret |= _init_clkdm(oh);
>  	ret |= _init_main_clk(oh);
>  	ret |= _init_interface_clks(oh);
>  	ret |= _init_opt_clks(oh);
> -	ret |= _init_clkdm(oh);
>  
>  	if (!ret)
>  		oh->_state = _HWMOD_STATE_CLKS_INITED;
> -- 
> 1.7.0.4
> 
> 
> 


- Paul
