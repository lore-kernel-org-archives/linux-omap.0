From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
Date: Thu, 8 Nov 2012 17:59:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211081759000.20703@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com> <20121106220833.GQ6801@atomide.com> <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com> <20121107015841.GC6801@atomide.com> <alpine.DEB.2.00.1211070227500.8758@utopia.booyaka.com>
 <alpine.DEB.2.00.1211071655000.20704@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53863 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497Ab2KHR74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 12:59:56 -0500
In-Reply-To: <alpine.DEB.2.00.1211071655000.20704@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 7 Nov 2012, Paul Walmsley wrote:

> On Wed, 7 Nov 2012, Paul Walmsley wrote:
> 
> > On Tue, 6 Nov 2012, Tony Lindgren wrote:
> > 
> > > I'm getting errors with the allnoconfig ones, there are total four
> > > omap defconfigs there not counting the randconfigs.
> > 
> > That might indeed explain the discrepancy; so far only have been building 
> > his oldconfig seeds here.  Will add his allnoconfig seeds and test again.
> 
> Can reproduce this here.  Thanks for catching this.  Will fix and send a 
> new pull request today and ensure that the two allnoconfigs are added to 
> the build tests from now on.

Just a quick followup on this one: I observed a couple of minor 
regressions during the retest, so, will deal with those before sending out 
a new pull request.


- Paul
