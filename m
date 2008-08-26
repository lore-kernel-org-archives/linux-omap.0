From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-pull-request for omap2-upstream branch for next merge window
 (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 26 Aug 2008 13:34:14 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808261306310.1624@xanadu.home>
References: <20080819212300.GF17034@flint.arm.linux.org.uk>
 <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com>
 <20080826080616.GC24147@flint.arm.linux.org.uk>
 <alpine.LFD.1.10.0808261154200.1624@xanadu.home>
 <20080826162630.GA17304@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:13288 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191AbYHZReU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 13:34:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6700L54Y52WGF0@VL-MO-MR004.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 26 Aug 2008 13:34:14 -0400 (EDT)
In-reply-to: <20080826162630.GA17304@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, 26 Aug 2008, Russell King - ARM Linux wrote:

> The point is that my git usage does _not_ match with the requirements
> brought on by publishing the git tree, and therefore it should _not_
> be published in the first place.  The only reason it is published is
> because people like you vocally demand it to be so.  It's not my
> choice.

And I greatly appreciate your doing so.

> That requirement is that once a commit has been published, it becomes
> immutable.  That requirement is there so that people _can_ work off
> your published tree.  If you're not sure of the work you have in your
> git tree, you shouldn't be publishing those commits.

That's not all black or white.  Many people have branches which are 
rebased all the time, especially when those branches are made up of 
other evolving branches.  I Think this is the case of your devel branch 
which sounds pretty fine to me.  As long as the volatile nature of such 
branch is clearly advertised and people are told not to base their own 
work on of course, and I think you did so many times now.

Especially with a git tree containing multiple branches, one must be 
wise enough not to pick one at random and use that to commit stuff on 
top.  This is where the tool, as good as it may be, still isn't a 
replacement for proper communication.  When in doubt, people should just 
ask.

What is discouraged though, is the republishing of stuff that you were 
asked to pull and that you rebased locally.  If other people's stuff 
have to be rebased for whatever reason then it is best to simply drop 
that stuff and ask the originator to rebase it and then repull.

> It's only going to be a matter of time before there's another chorus of
> people demanding that I yet again change the way I work, demanding that
> I conform...

I don't think you have to change the way you work now, and IMHO you 
already conform to the git usage of the majority of Linux maintainers.


Nicolas
