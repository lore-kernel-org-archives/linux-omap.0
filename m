From: Tony Lindgren <tony@atomide.com>
Subject: Re: beginner questions on being added to the linux tree
Date: Tue, 10 Aug 2010 09:50:47 +0300
Message-ID: <20100810065046.GF32480@atomide.com>
References: <77A0A4DB5BF2A44283E5522C27234AC6021A5F78@EDPRSRV011.logicpd.com>
 <20100810110915.9e2ddc27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55087 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0HJGvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 02:51:03 -0400
Content-Disposition: inline
In-Reply-To: <20100810110915.9e2ddc27.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>, Russell King <rmk@arm.linux.org.uk>, linux-omap@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [100810 04:02]:
> Hi Jacob,
> 
> On Mon, 9 Aug 2010 19:36:01 -0500 "Jacob Tanenbaum" <Jacob.Tanenbaum@logicpd.com> wrote:
> >
> >             I work for LogicPD and am trying to add new support for
> > there OMAP3 development boards to the kernel, I have a working version
> > of some of the base support and was wondering how to get that ready to
> > be merged in during this merge window. We have tested the code against
> > the most recent version of linux-next I can get to build and was
> > wondering where to go. Do I send merge requests to the linux-next list
> > or a series of patches. I have sent patches to the omap and arm lists
> > and got some minor syntax errors reported by them (spaces instead of
> > tabs and the like) and was wondering where to go from here.
> 
> I only merge other people's trees, so you need to set up a git tree
> somewhere and tell me (cc'ing linux-next and all other appropriate
> lists/people) where it is and which branch to fetch.  I then fetch that
> branch each day and merge it with everything else.
> 
> Getting your code merged by Linus during this merge window is up to Linus
> and Russell or Tony, I guess.  But I cannot take new trees now until
> after -rc1 is out.  So if you really want your code merged during this
> merge window, your best bet is to convince Russell and/or Tony.

Yeah, it's too late for this merge window. But after -rc1 I'll start
queuing things up for the next merge window. That way your patches will
go to Stephen's for-next tree and then get pulled into the mainline
tree during the next merge window.

> Having your tree in linux-next may be useful for ongoing development
> unless Tony thinks it may be better for you to just submit your code
> through his omap tree.

If you have patches coming on continuous basis, then maintaining
a git branch makes sense. For occasional sets of patches, it's probably
easier to just email them to the list.

Regards,

Tony
