From: Tony Lindgren <tony@atomide.com>
Subject: Re: RFD: OMAP PRCM register access holding up PM branch submissions
Date: Thu, 12 Mar 2009 10:26:46 -0700
Message-ID: <20090312172646.GL19229@atomide.com>
References: <87hc1y930c.fsf@deeprootsystems.com> <20090312162804.GA7179@n2100.arm.linux.org.uk> <87bps67kby.fsf@deeprootsystems.com> <20090312170151.GB7854@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49742 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbZCLR0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 13:26:51 -0400
Content-Disposition: inline
In-Reply-To: <20090312170151.GB7854@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090312 10:03]:
> On Thu, Mar 12, 2009 at 09:54:41AM -0700, Kevin Hilman wrote:
> > If you can share your opinions on the two register access approaches I
> > described, I will work on coordinating development in that direction.
> 
> If I had a path forwards, then I would say so.  At the moment, I have
> a vague idea about what I'd like to see, but it isn't in a workable
> state at the present time.
> 
> I need to put further thought and time into coming up with a solution.
> For the time being, I am not going to apply the outstanding patches to
> put in place a solution which is totally confused about iomem and u32
> types with lots of casts to make it work.  Even one which passes u32
> types to the IO accessors (which don't produce a warning but shouldn't
> be allowed in any case.)

Well let's get the current omap clock patches in omap-clks3 merged.
It is already way closer to what we need than the current mainline code.

Paul, maybe you can post that series to linux-omap for final review
and testing because of the mail/OOM issues Russell is having?

Then we'll come up with a proper solution for the remaining patches
after this merge window.
 
> I'm sorry, but I have no further time that I can spend on this, not even
> proposing solutions, not even commenting back on the patches.  That's
> the way it is.  I'm _WAY_ over time on OMAP stuff this cycle and that's
> just going to have to be accepted by the community.
> 
> Sorry.

Sure you have tons of other things to take care of, and the remaining
omap clock patches can be sorted out over time.

Regards,

Tony

