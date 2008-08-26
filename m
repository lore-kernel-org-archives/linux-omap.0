From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull-request for omap2-upstream branch for next merge window (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 26 Aug 2008 19:49:53 +0100
Message-ID: <20080826184953.GB17304@flint.arm.linux.org.uk>
References: <20080819212300.GF17034@flint.arm.linux.org.uk> <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com> <20080826080616.GC24147@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808261154200.1624@xanadu.home> <20080826162630.GA17304@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808261306310.1624@xanadu.home> <alpine.LFD.1.10.0808261425370.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40398 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbYHZSuJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 14:50:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261425370.1624@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Aug 26, 2008 at 02:28:14PM -0400, Nicolas Pitre wrote:
> On Tue, 26 Aug 2008, Nicolas Pitre wrote:
> 
> > That's not all black or white.  Many people have branches which are 
> > rebased all the time, especially when those branches are made up of 
> > other evolving branches.  I Think this is the case of your devel branch 
> > which sounds pretty fine to me.  As long as the volatile nature of such 
> > branch is clearly advertised and people are told not to base their own 
> > work on of course, and I think you did so many times now.
> 
> And I've just seen the commit message of the top commit in the devel 
> branch.  :-)  If that is not effective then I don't know what might be.

Well, the theory is that it'll appear in any pull requests generated
by git-request-pull, and of course everyone reads the output of that
command before they mail it, don't they?  ;)
