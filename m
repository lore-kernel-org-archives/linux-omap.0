From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: git-pull-request for omap2-upstream branch for next merge window (Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Tue, 26 Aug 2008 17:26:30 +0100
Message-ID: <20080826162630.GA17304@flint.arm.linux.org.uk>
References: <20080819212300.GF17034@flint.arm.linux.org.uk> <20080820072310.GA28862@atomide.com> <20080823233711.GM4713@atomide.com> <20080826080616.GC24147@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808261154200.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40972 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYHZQ0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 12:26:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261154200.1624@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Aug 26, 2008 at 12:01:33PM -0400, Nicolas Pitre wrote:
> On Tue, 26 Aug 2008, Russell King - ARM Linux wrote:
> 
> > The devel branch is _constantly_ remerged.  Basing your tree on it will
> > mean I can't merge it.  Please don't.  Base it either on something in
> > Linus' tree _or_ something you've already asked me to pull.
> > 
> > If this continues, I'll go back to only publishing my git tree in diff
> > and mbox form.
> 
> What's the advantage of screwing everybody only because few individuals 
> don't get it right?
> 
> It is easy enough to back out a bad pull with git.  If you're tired of 
> flaming people, simply ask that any git pull request message also 
> contains the information about the commit it is based on so that you can 
> ignore bad pulls up front.

Like I just have done.

The point is that my git usage does _not_ match with the requirements
brought on by publishing the git tree, and therefore it should _not_
be published in the first place.  The only reason it is published is
because people like you vocally demand it to be so.  It's not my
choice.

That requirement is that once a commit has been published, it becomes
immutable.  That requirement is there so that people _can_ work off
your published tree.  If you're not sure of the work you have in your
git tree, you shouldn't be publishing those commits.

However, that's just not true of the way I manage my tree.

It's only going to be a matter of time before there's another chorus of
people demanding that I yet again change the way I work, demanding that
I conform...
