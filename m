From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Fri, 29 May 2015 09:28:49 -0700
Message-ID: <20150529162849.GP30984@atomide.com>
References: <20150527215545.GA30984@atomide.com>
 <20150528161730.GE3657@e103592.cambridge.arm.com>
 <20150528163605.GI30984@atomide.com>
 <6381487.LvuhvmaVk1@wuerfel>
 <20150529110624.GD3648@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54658 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbE2Q2w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 12:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20150529110624.GD3648@e103592.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grazvydas Ignotas <notasas@gmail.com>, Kevin Hilman <khilman@kernel.org>, "tyler.baker@linaro.org" <tyler.baker@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Dave P Martin <Dave.Martin@arm.com> [150529 04:08]:
> On Thu, May 28, 2015 at 07:55:16PM +0100, Arnd Bergmann wrote:
> > On Thursday 28 May 2015 09:36:05 Tony Lindgren wrote:
> > > * Dave Martin <Dave.Martin@arm.com> [150528 09:19]:
> > > > On Thu, May 28, 2015 at 07:21:25AM -0700, Tony Lindgren wrote:
> > > > > --- a/arch/arm/mach-omap2/sleep34xx.S
> > > > > +++ b/arch/arm/mach-omap2/sleep34xx.S
> > > > > @@ -203,23 +203,8 @@ save_context_wfi:
> > > > >      */
> > > > >     ldr     r1, kernel_flush
> > > > >     blx     r1
> > > > > -   /*
> > > > > -    * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
> > > > > -    * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
> > > > > -    * This sequence switches back to ARM.  Note that .align may insert a
> > > > > -    * nop: bx pc needs to be word-aligned in order to work.
> > > > > -    */
> > > > > - THUMB(    .thumb          )
> > > > > - THUMB(    .align          )
> > > > > - THUMB(    bx      pc      )
> > > > > - THUMB(    nop             )
> > > > > -   .arm
> > > > > -
> > > > 
> > > > ^ This looks unrelated to the issue?  This code is simply unnecessary
> > > > after Russell introduced the "ret" macro in commit 6ebbf2ce43.  That
> > > > made v7_flush_dcache_all do a proper interworking return.
> > > > 
> > > > It should probably be in a separate commit, or at least mentioned
> > > > explicitly in the commit log.
> > > 
> > > Thanks, I've updated the description with the commit info above.
> > > 
> > > I'll keep the removal of the duplicate code in this patch, as it's
> > > all related to the mode switching and we don't want to do it twice.
> > 
> > I would have thought that the change is actually necessary after
> > 6ebbf2ce43, because it now returns in ARM mode, which will cause the
> > "bx pc; nop" thumb instruction sequence be misinterpreted as an 
> > ARM instruction.
> > 
> > 	Arnd
> 
> You're right.  The THUMB2_KERNEL indeed won't work without deleting this
> code.

OK thanks for checking.

Regards,

Tony
