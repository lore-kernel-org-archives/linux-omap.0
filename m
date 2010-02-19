From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
 inside each ARCH Kconfig
Date: Fri, 19 Feb 2010 15:44:44 -0800
Message-ID: <20100219234444.GI21755@atomide.com>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
 <20100129102955.GA8919@n2100.arm.linux.org.uk>
 <20100129204845.GM23505@atomide.com>
 <00a201cab1b7$6ff6feb0$4fe4fc10$%kim@samsung.com>
 <20100219231721.GG21755@atomide.com>
 <00a301cab1bc$b57126a0$205373e0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61084 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab0BSXn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:43:56 -0500
Content-Disposition: inline
In-Reply-To: <00a301cab1bc$b57126a0$205373e0$%kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-omap@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

* Kukjin Kim <kgene.kim@samsung.com> [100219 15:34]:
> Tony Lindgren wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces@lists.infradead.org
> [mailto:linux-arm-kernel-
> > bounces@lists.infradead.org] On Behalf Of Tony Lindgren
> > Sent: Saturday, February 20, 2010 8:17 AM
> > To: Kukjin Kim
> > Cc: linux-omap@vger.kernel.org; 'Russell King - ARM Linux'; linux-arm-
> > kernel@lists.infradead.org; ben-linux@fluff.org
> > Subject: Re: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for
> > handle inside each ARCH Kconfig
> > 
> > * Kukjin Kim <kgene.kim@samsung.com> [100219 14:56]:
> > >
> > > Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100129 02:27]:
> > > > > On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> > > > > > Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> > > > > > L1 cache lines which are 64bytes to indicate this without having to
> > > > > > alter the arch/arm/mm/Kconfig entry each time.
> > > > > >
> > > > > > Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> > > > > > uses this and change OMAP3 and S5PC1XX to select
> > > > ARM_L1_CACHE_SHIFT_6.
> > > > >
> > > > > This looks fine, thanks.
> > > > >
> > > > > Who's going to handle this patch?
> > > >
> > > > I recommend RMK handle this.
> > > >
> > > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > >
> > >
> > > Hi Tony and Russell,
> > >
> > > I wonder this patch who does/did handle.
> > > Please let me know.
> > 
> > Please send your patch to Russell's patch tracking system if you have
> > not yet done so and then Russell will pick it up from there:
> 
> Hi Tony,
> 
> Thanks for your reply.
> I'm sending my patch to Russell's patch tracking system.
> 
> May I add 'Acked-by: Tony Lindgren <tony@atomide.com>' in my patch?

Yes thanks.

Tony
