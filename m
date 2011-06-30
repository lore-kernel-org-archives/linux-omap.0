From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap clean-up for v3.1 merge window
Date: Thu, 30 Jun 2011 05:33:38 -0700
Message-ID: <20110630123338.GL23145@atomide.com>
References: <20110630091019.GJ23145@atomide.com>
 <201106301325.02204.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37562 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499Ab1F3Mdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 08:33:45 -0400
Content-Disposition: inline
In-Reply-To: <201106301325.02204.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [110630 04:20]:
> On Thursday 30 June 2011, Tony Lindgren wrote:
> 
> The cleanups all look great, with one exception (see below). In the
> future, I'd prefer to get separate pull requests for cleanups and
> bug fixes, but no need to worry about it this time.

Sure no problem.
 
> > I have not added this into linux next assuming that you will
> > do it. If not, please let me know and I will add it.
> 
> Right, I'll ask Stephen to add the master branch of the arm-soc
> tree to linux-next soon, after I've made sure that there are no
> conflicts with existing branches that get merged there.

Thanks. It merged fine into yesterday's linux-next when I tried.
 
> For our upstream submission, my preference would be to send them
> piecemeal to Linus and group them across the branches as
> appropriate.

Sure. We need to base omap board-*.c related changes on top of
this branch though to avoid build failures with merges.

> >       omap: Set separate timer init functions to avoid cpu_is_omap tests
> 
> This commit causes a build regression for me in some configurations.
> If you agree, I'd apply this patch on top:
> 
> 8<-------
> omap2+: fix build regression
> 
> board-generic.c now contains a reference to omap3_timer, but depends only
> on ARCH_OMAP2, not on ARCH_OMAP3, which controls that symbol.
> omap2_timer seems to be more appropriate anyway, so use that instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing that, here's my ack:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -72,5 +72,5 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
>         .init_early     = omap_generic_init_early,
>         .init_irq       = omap2_init_irq,
>         .init_machine   = omap_generic_init,
> -       .timer          = &omap3_timer,
> +       .timer          = &omap2_timer,
>  MACHINE_END
