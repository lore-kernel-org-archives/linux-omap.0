From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Mon, 11 Jan 2010 14:45:05 +0000
Message-ID: <20100111144505.GA4109@n2100.arm.linux.org.uk>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com> <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60275 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0AKOph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 09:45:37 -0500
Content-Disposition: inline
In-Reply-To: <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, Woodruff Richard <r-woodruff2@ti.com>

On Mon, Jan 11, 2010 at 02:37:08PM +0000, Catalin Marinas wrote:
> On Mon, 2009-12-21 at 10:09 +0000, Santosh Shilimkar wrote:
> > @@ -139,7 +184,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
> >                         spin_lock_irqsave(&l2x0_lock, flags);
> >                 }
> >         }
> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +       cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> > +       cache_wait(base + L2X0_INV_LINE_PA, 1);
> > +#else
> >         cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> > +#endif
> 
> I don't think we need to way on two separate registers here. AFAICT, bit
> 1 of those registers is shared for all the operations.
> 
> As a general comment, maybe an inline function called something like
> wait_writel(before/after) would be better than a lot of ifdefs in the
> code, especially if one has a different workaround other than using TI's
> secure monitor.

Since the bit is shared between all 'R7' registers, the ifdef above makes
no sense.  We can just wait on any R7 register - I suggest that bit of
code is left as-is.
