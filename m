From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/4] ARM: l2x0: Optmise the range based operations
Date: Tue, 7 Sep 2010 12:48:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE81D6@dbde02.ent.ti.com>
References: <1280598372-4830-1-git-send-email-santosh.shilimkar@ti.com>
 <1283768790.1926.10.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0IGHTG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 03:19:06 -0400
In-Reply-To: <1283768790.1926.10.camel@e102109-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> Sent: Monday, September 06, 2010 3:57 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 4/4] ARM: l2x0: Optmise the range based operations
> 
> On Sat, 2010-07-31 at 23:16 +0530, Santosh Shilimkar wrote:
> > For the big buffers which are in excess of cache size, the maintaince
> > operations by PA are very slow. For such buffers the maintainace
> > operations can be speeded up by using the WAY based method.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm/mm/cache-l2x0.c |   95 ++++++++++++++++++++++++++++-----------
> -------
> >  1 files changed, 58 insertions(+), 37 deletions(-)
> >
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index b2938d4..c0d6108 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -116,6 +116,18 @@ static void l2x0_flush_all(void)
> >  	spin_unlock_irqrestore(&l2x0_lock, flags);
> >  }
> >
> > +static void l2x0_clean_all(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	/* clean all ways */
> > +	spin_lock_irqsave(&l2x0_lock, flags);
> > +	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
> > +	cache_wait(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
> 
> In case you'll base this on top of my PL310 optimisation, you should use
> cache_wait_way() as the cache_wait() becomes a no-op.
> 
Yep. Will fix that while rebasing.

Will post the full series with Thomas's two patches included
on top of your "[PATCH 0/9] Various patches for 2.6.37-rc1" which
is already in the linux-next

Regards,
Santosh
