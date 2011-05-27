From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap updates for 2.6.40
Date: Fri, 27 May 2011 14:04:19 +0300
Message-ID: <20110527110416.GG27962@atomide.com>
References: <20110526113905.GG27250@atomide.com>
 <9741DC43-3197-4ECE-A377-FA865A3F6710@dominion.thruhere.net>
 <20110527063304.GA27962@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14764 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751511Ab1E0LEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 07:04:25 -0400
Content-Disposition: inline
In-Reply-To: <20110527063304.GA27962@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110527 09:29]:
> * Koen Kooi <koen@dominion.thruhere.net> [110526 19:02]:
> > 
> > Op 26 mei 2011, om 13:39 heeft Tony Lindgren het volgende geschreven:
> > 
> > > Hi Linus,
> > > 
> > > Please pull omap updates for this merge window from:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus
> > > 
> > > This contains clean-up to shrink down omap specific code a bit. Also included
> > > are some fixes. But basically no new code at this point.
> > 
> > What about updates to board files? Like adding support for the xM rev C to board-omap3beagle.c.
> 
> Sorry we're doing only code coalescing and fixes for this merge window as
> discussed on LAKML. Otherwise it's hard to see the code coalescing in the
> diffstats, so new code will need to wait a bit.
> 
> I'll take a look and see if we can justify some fix like trivial patches
> like the revision detection patches during the -rc cycle.

Koen, the patch above needs to be refreshed to apply to current mainline
kernel. It also seems to contain some whitespace errors.

Care to refresh it and repost?

Thanks,

Tony
