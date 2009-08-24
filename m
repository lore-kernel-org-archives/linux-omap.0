From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pull request for OMAP PM, clock, SDRC 2.6.32 patches
Date: Mon, 24 Aug 2009 17:29:51 +0300
Message-ID: <20090824142951.GK5165@atomide.com>
References: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com> <20090817170921.GT10764@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0908180621270.7224@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56012 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZHXO37 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 10:29:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0908180621270.7224@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org, hiroshi.doyu@nokia.com

* Paul Walmsley <paul@pwsan.com> [090818 15:35]:
> Hello Russell,
> 
> On Mon, 17 Aug 2009, Russell King - ARM Linux wrote:
> 
> > On Sun, Aug 16, 2009 at 07:45:59AM -0600, Paul Walmsley wrote:
> > > 
> > > Hello Russell,
> > > 
> > > Here's the pull request for the thirteen patches posted earlier, plus 
> > > Hiroshi's clock debugfs error path fix.
> > 
> > I'm afraid to say that I think you've left it far too late to send this.
> > I did set a date of the 16th as being the final date to sort out stuff
> > (which was flexible to a degree) but since these patches were only posted
> > on Saturday, and they're still being discussed, I don't think it would
> > make sense for me to pull it today.
> 
> I've dropped the two patches that are being discussed and reposted the 
> remainder.  The updated series is here (et seq.):
> 
>     http://marc.info/?l=linux-arm-kernel&m=125059872200340&w=2
> 
> and the pull request is here:
> 
>     http://marc.info/?l=linux-arm-kernel&m=125059845132331&w=2

I've added this into omap for-next branch.

Tony

> 
> 
> - Paul
> 
> >
> > And this is likely to be the final day that I merge anything into my
> > kernel tree for the next two weeks.
> > > 
> > > regards,
> > > 
> > > - Paul
> > > 
> > > The following changes since commit 3b3119fc549c93df60316d28bdd77c2de3986588:
> > >   Russell King (1):
> > >         Merge branch 'ixp4xx-fixes' of git://git.kernel.org/.../chris/linux-2.6
> > 
> > That's stupid.  Someone publishing _my_ tree, which I make no guarantees
> > about the life of the commits, for other people to base their work on...
> > That's definitely a big FAIL.
> > 
> > Luckily for you though, that commit still exists in my tree, and I've
> > asked Linus to pull that set; so essentially it became immutable only
> > last night.
> > 
> > Don't base patches on the contents of my tree without talking to me first
> > please.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
