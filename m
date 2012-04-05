From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc
Date: Thu, 5 Apr 2012 09:42:24 -0700
Message-ID: <20120405164223.GA3785@atomide.com>
References: <alpine.DEB.2.00.1204041658200.7161@utopia.booyaka.com>
 <20120405004139.GA10780@atomide.com>
 <alpine.DEB.2.00.1204042007140.10302@utopia.booyaka.com>
 <alpine.DEB.2.00.1204050246410.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39282 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2DEQm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 12:42:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204050246410.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120405 01:53]:
> On Wed, 4 Apr 2012, Paul Walmsley wrote:
> 
> > On Wed, 4 Apr 2012, Tony Lindgren wrote:
> > 
> > > Thanks, looks like two of these patches I already merged into
> > > fixes yesterday from your earlier pull request. So merging this
> > > in would cause duplicate commits. Can you please update your
> > > branch to remove those two commits?
> > 
> > Do you happen to recall which ones they are?
> 
> Anyway, am guessing that you are planning to pull these into your 
> 'fixes' branch?  If so then probably the conflicts are with the 
> misc_devel_3.4 branch patches.  Will post another pull request for you 
> with those two patches dropped.  But if you're pulling these into a 
> different branch, please let me know...

Yes it's the fixes branch I was talking about, thanks for updating it.

Tony
