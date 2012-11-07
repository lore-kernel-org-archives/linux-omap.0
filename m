From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
Date: Wed, 7 Nov 2012 02:39:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211070227500.8758@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com> <20121106220833.GQ6801@atomide.com> <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com> <20121107015841.GC6801@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45224 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2KGCjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 21:39:08 -0500
In-Reply-To: <20121107015841.GC6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 6 Nov 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121106 17:54]:
> > On Tue, 6 Nov 2012, Tony Lindgren wrote:
> > 
> > > ..now wondering which configs do not build for you at 7fc54fd3?
> > > 
> > > It builds at least all my test configs. Well at least the ones
> > > I have recovered after accidentally deleting some files yesterday,
> > > did not have a back up copy of two of them.
> 
> The build errors you are talking about are the ones I already pulled
> into one of the cleanup branches, right? If so, that's fine.

The build logs I sent were for the "ARM: OMAP: second set of PRCM 
cleanups for 3.8" branch.  The last commit in that branch is 
f17d60d20eb8e679cdd1e9d507394237e58ce0d8 and it is based on 	
7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33.  That one builds cleanly.

If you're asking for a test build of the base commit, 
7fc54fd3084457c7f11b9e2e1e3fcd19a3badc33, I just kicked off a test build 
of that; will post when done.

> > Maybe the versions of the rmk configs you're using are different than 
> > mine?  The ones here were updated during the v3.6 -> v3.7-rc1 transition.
> > You can find mine at:
> > 
> > http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap3430_ldp_oldconfig/rmk_omap3430_ldp_oldconfig
> > 
> > http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap4430_sdp_oldconfig/rmk_omap4430_sdp_oldconfig
> 
> I'm getting errors with the allnoconfig ones, there are total four
> omap defconfigs there not counting the randconfigs.

That might indeed explain the discrepancy; so far only have been building 
his oldconfig seeds here.  Will add his allnoconfig seeds and test again.


- Paul
