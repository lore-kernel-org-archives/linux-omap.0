From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Implement powerdomain off on state counters
Date: Tue, 5 Aug 2008 18:30:20 +0300
Message-ID: <20080805153018.GT7193@atomide.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com> <20080805142017.GR7193@atomide.com> <1217946503.16579.205.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56736 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502AbYHEPag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 11:30:36 -0400
Content-Disposition: inline
In-Reply-To: <1217946503.16579.205.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

* Igor Stoppa <igor.stoppa@nokia.com> [080805 17:38]:
> Hi Tony,
> On Tue, 2008-08-05 at 17:20 +0300, ext Tony Lindgren wrote:
> > * Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080724 16:00]:
> > > This patchset implement counters to count the number of off to on state transitions in a powerdomain. These counters will be made available to
> > > drivers in a later patchset to allow them to make a better informed decision wether to restore the hardware registers or not.
> > > 
> > > Peter 'p2' De Schrijver (3):
> > >   Power off on state counter debugging
> > >   Power off on state counter infrastructure
> > >   Add hooks for counting off on power transitions
> > 
> > We should merge these into Paul's powerdomain patches against mainline
> > tree and post them again for more comments to LKML, linux-arm-kernel
> > and linux-pm.
> 
> Dave Brownell commented already that this stuff, albeit apparently
> generic enough to be interesting to other archs, would probably be
> better off being merged in the omap tree, since in the end other SOCs
> tend to be far simpler than OMAP.

Yeah.

> Considering that we are not 100% sure about the usefulness of certain sw
> features - example: the granularity for the bandwidth requirements might
> be too fine - I'd rather avoid bringing in whishlists from other
> architectures, unless they are proven to be really needed.
> 
> And AFAIK so far nobody has come forward with such claim.
> 
> Can't we first get it working in a reliable way on OMAP?

We should first get ack (even if it means no comments) from other
mailing lists before we go ahead implementing this as it affects the
drivers too.

> Whatever survives this process has probably better chances to result
> interesting to other people.

Yeh, but we need to keep them informed throughout the process. Many of
the people that could be commenting the code are not reading linux-omap
list.

Also, we want to get these patches integrated to mainline tree, and
Russell wants to have more review before integrating.

Regards,

Tony
