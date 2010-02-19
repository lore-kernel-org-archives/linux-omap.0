From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
 inside each ARCH Kconfig
Date: Fri, 19 Feb 2010 15:17:21 -0800
Message-ID: <20100219231721.GG21755@atomide.com>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
 <20100129102955.GA8919@n2100.arm.linux.org.uk>
 <20100129204845.GM23505@atomide.com>
 <00a201cab1b7$6ff6feb0$4fe4fc10$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55593 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0BSXQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:16:40 -0500
Content-Disposition: inline
In-Reply-To: <00a201cab1b7$6ff6feb0$4fe4fc10$%kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

* Kukjin Kim <kgene.kim@samsung.com> [100219 14:56]:
> 
> Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100129 02:27]:
> > > On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> > > > Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> > > > L1 cache lines which are 64bytes to indicate this without having to
> > > > alter the arch/arm/mm/Kconfig entry each time.
> > > >
> > > > Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> > > > uses this and change OMAP3 and S5PC1XX to select
> > ARM_L1_CACHE_SHIFT_6.
> > >
> > > This looks fine, thanks.
> > >
> > > Who's going to handle this patch?
> > 
> > I recommend RMK handle this.
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> 
> Hi Tony and Russell,
> 
> I wonder this patch who does/did handle.
> Please let me know.

Please send your patch to Russell's patch tracking system if you have
not yet done so and then Russell will pick it up from there:

http://www.arm.linux.org.uk/developer/patches/

Regards,

Tony
