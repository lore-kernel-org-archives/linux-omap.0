From: Tony Lindgren <tony@atomide.com>
Subject: Re: git-pull-request for omap2-upstream branch for next merge
	window (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 2 Sep 2008 15:21:31 -0700
Message-ID: <20080902222130.GF23085@atomide.com>
References: <20080819212300.GF17034@flint.arm.linux.org.uk> <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com> <20080826080616.GC24147@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808261154200.1624@xanadu.home> <20080826162630.GA17304@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808261306310.1624@xanadu.home> <alpine.LFD.1.10.0808261425370.1624@xanadu.home> <20080826184953.GB17304@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63602 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbYIBWVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:21:42 -0400
Content-Disposition: inline
In-Reply-To: <20080826184953.GB17304@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080826 11:50]:
> On Tue, Aug 26, 2008 at 02:28:14PM -0400, Nicolas Pitre wrote:
> > On Tue, 26 Aug 2008, Nicolas Pitre wrote:
> > 
> > > That's not all black or white.  Many people have branches which are 
> > > rebased all the time, especially when those branches are made up of 
> > > other evolving branches.  I Think this is the case of your devel branch 
> > > which sounds pretty fine to me.  As long as the volatile nature of such 
> > > branch is clearly advertised and people are told not to base their own 
> > > work on of course, and I think you did so many times now.
> > 
> > And I've just seen the commit message of the top commit in the devel 
> > branch.  :-)  If that is not effective then I don't know what might be.
> 
> Well, the theory is that it'll appear in any pull requests generated
> by git-request-pull, and of course everyone reads the output of that
> command before they mail it, don't they?  ;)

Heh, I'll rebase on top of the earlier pull.

Tony
