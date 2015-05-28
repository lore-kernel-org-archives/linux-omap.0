From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Thu, 28 May 2015 18:31:04 +0100
Message-ID: <20150528173103.GF3657@e103592.cambridge.arm.com>
References: <20150527215545.GA30984@atomide.com>
 <7h7frtmzoh.fsf@deeprootsystems.com>
 <20150527225553.GC30984@atomide.com>
 <CANOLnOMYBFAr_t_tOs8ifo=ngtCrpyogtf_7hBDc4rmbC_-BQQ@mail.gmail.com>
 <20150528142125.GE30984@atomide.com>
 <20150528161730.GE3657@e103592.cambridge.arm.com>
 <20150528163605.GI30984@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:38596 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184AbbE1RbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2015 13:31:07 -0400
In-Reply-To: <20150528163605.GI30984@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, tyler.baker@linaro.org, Stephen Boyd <sboyd@codeaurora.org>, Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 28, 2015 at 09:36:05AM -0700, Tony Lindgren wrote:
> * Dave Martin <Dave.Martin@arm.com> [150528 09:19]:
> > On Thu, May 28, 2015 at 07:21:25AM -0700, Tony Lindgren wrote:
> > > --- a/arch/arm/mach-omap2/sleep34xx.S
> > > +++ b/arch/arm/mach-omap2/sleep34xx.S
> > > @@ -203,23 +203,8 @@ save_context_wfi:
> > >  	 */
> > >  	ldr	r1, kernel_flush
> > >  	blx	r1
> > > -	/*
> > > -	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
> > > -	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
> > > -	 * This sequence switches back to ARM.  Note that .align may insert a
> > > -	 * nop: bx pc needs to be word-aligned in order to work.
> > > -	 */
> > > - THUMB(	.thumb		)
> > > - THUMB(	.align		)
> > > - THUMB(	bx	pc	)
> > > - THUMB(	nop		)
> > > -	.arm
> > > -
> > 
> > ^ This looks unrelated to the issue?  This code is simply unnecessary
> > after Russell introduced the "ret" macro in commit 6ebbf2ce43.  That
> > made v7_flush_dcache_all do a proper interworking return.
> > 
> > It should probably be in a separate commit, or at least mentioned
> > explicitly in the commit log.
> 
> Thanks, I've updated the description with the commit info above.
> 
> I'll keep the removal of the duplicate code in this patch, as it's
> all related to the mode switching and we don't want to do it twice.
>  
> > >  	b	omap3_do_wfi
> > > -
> > > -/*
> > > - * Local variables
> > > - */
> > 
> > ^ Likewise this is just tidyup, not bug fixing.
> 
> Will keep that too, the local variables comments are now just too
> confusing while reading the code after adding the ENDPROC. And that
> too is just removal.

I have no objection to tidyups ;)

So long as the commit message is clear about which parts are bugfix and
which parts are tidyup, I'm fine with that.

Cheers
---Dave

