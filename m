From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] OMAP24xx/25xx clock: init osc_ck, sys_ck internal
	lists early
Date: Fri, 24 Apr 2009 10:51:47 -0700
Message-ID: <20090424175146.GR22457@atomide.com>
References: <20090421195421.GB29943@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0904222000240.24299@utopia.booyaka.com> <20090423075337.GA20250@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0904230221190.6400@utopia.booyaka.com> <20090423180031.GD22457@atomide.com> <20090423222612.GA6095@n2100.arm.linux.org.uk> <20090423235527.GM22457@atomide.com> <alpine.DEB.2.00.0904232111290.29285@utopia.booyaka.com> <20090424052306.GN22457@atomide.com> <alpine.DEB.2.00.0904240029060.11729@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52082 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761023AbZDXRv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 13:51:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0904240029060.11729@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090423 23:29]:
> On Thu, 23 Apr 2009, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [090423 20:13]:
> > > On Thu, 23 Apr 2009, Tony Lindgren wrote:
> > > 
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090423 15:26]:
> > > > > On Thu, Apr 23, 2009 at 11:00:31AM -0700, Tony Lindgren wrote:
> > > > > > * Paul Walmsley <paul@pwsan.com> [090423 01:35]:
> > > > > > > Hello Russell,
> > > > > > > 
> > > > > > > On Thu, 23 Apr 2009, Russell King - ARM Linux wrote:
> > > > > > > 
> > > > > > > > On Wed, Apr 22, 2009 at 08:01:29PM -0600, Paul Walmsley wrote:
> > > > > > > > > The patch also renames clk_init_one() to clk_preinit() to
> > > > > > > > > distinguish its function from clk_init() and the individual struct clk
> > > > > > > > > init functions.
> > > > > > > > 
> > > > > > > > That's rather unnecessary.  'clk_init_one' is already unique.  In the
> > > > > > > > long run, it's clk_init that needs to go.
> > > > > > > 
> > > > > > > Even if clk_init() were to disappear, the struct clk .init function 
> > > > > > > pointer would still be present.  clk->init() performs a very different 
> > > > > > > kind of initialization than clk_init_one().
> > > > > > 
> > > > > > I'm OK doing the rename in this fix. The original naming can cause
> > > > > > confusion while reading the code.
> > > > > 
> > > > > Well I'm not, and I want to discuss it some more.  And I'm sending Linus
> > > > > a pull request tonight, so I'm dropping the OMAP stuff from that.
> > > > 
> > > > OK. Paul, can you please separate out the rename part into a separate
> > > > patch so we only have a minimal fix & then repost it here?
> > > > 
> > > > That way we'll get the necessary fixes in and you guys can schedule
> > > > other changes for next merge window.
> > > 
> > > The omap-clock-fixes branch has been updated to remove the rename.
> > > 
> > > Not that this should stop the discussion, but at least this should no 
> > > longer prevent these needed fixes from going upstream.
> > 
> > Care to post the updated patch here too? Temporay git branches are 
> > not too readable by most people..
> 
> Here you go:

Thanks, I've updated omap-fixes again and will post a new pull request.

Tony

> 
> - Paul
> 
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 22 Apr 2009 19:48:53 -0600
> Subject: [PATCH] OMAP2xxx clock: pre-initialize struct clks early
> 
> Commit 3f0a820c4c0b4670fb5f164baa5582e23c2ef118 breaks OMAP2xxx boot
> during initial propagate_rate() on osc_ck and sys_ck.  Fix by
> pre-initializing all struct clks before running any other clock init
> code.  Incorporates review comments from Russell King
> <rmk+kernel@arm.linux.org.uk>.
> 
> Resolves
> 
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> <1>pgd = c0004000
> <1>[00000000] *pgd=00000000
> Internal error: Oops: 5 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (2.6.29-omap1 #37)
> PC is at propagate_rate+0x10/0x60
> LR is at omap2_clk_init+0x30/0x218
> ...
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap2/clock24xx.c |    6 +++---
>  arch/arm/plat-omap/clock.c      |    7 +++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
> index 1e839c5..984fb86 100644
> --- a/arch/arm/mach-omap2/clock24xx.c
> +++ b/arch/arm/mach-omap2/clock24xx.c
> @@ -720,14 +720,14 @@ int __init omap2_clk_init(void)
>  
>  	clk_init(&omap2_clk_functions);
>  
> +	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
> +		clk_init_one(c->lk.clk);
> +
>  	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
>  	propagate_rate(&osc_ck);
>  	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
>  	propagate_rate(&sys_ck);
>  
> -	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
> -		clk_init_one(c->lk.clk);
> -
>  	cpu_mask = 0;
>  	if (cpu_is_omap2420())
>  		cpu_mask |= CK_242X;
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 2e06145..29efc27 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -239,6 +239,13 @@ void recalculate_root_clocks(void)
>  	}
>  }
>  
> +/**
> + * clk_init_one - initialize any fields in the struct clk before clk init
> + * @clk: struct clk * to initialize
> + *
> + * Initialize any struct clk fields needed before normal clk initialization
> + * can run.  No return value.
> + */
>  void clk_init_one(struct clk *clk)
>  {
>  	INIT_LIST_HEAD(&clk->children);
> -- 
> 1.6.3.rc1.51.gea0b7
> 
