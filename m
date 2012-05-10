From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Thu, 10 May 2012 09:13:27 -0700
Message-ID: <20120510161327.GB21851@atomide.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
 <20120507174657.GF5088@atomide.com>
 <1336550949.3962.2.camel@deskari>
 <20120509154543.GK5088@atomide.com>
 <1336633888.5182.19.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62155 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2EJQNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 12:13:30 -0400
Content-Disposition: inline
In-Reply-To: <1336633888.5182.19.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120510 00:15]:
> On Wed, 2012-05-09 at 08:45 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120509 01:12]:
> > > 
> > > Below is the pull request for board file related changes. Tested on
> > > panda & 4430sdp.
> > 
> > Thanks, I've merged that into clenaup-dss branch and will send it
> > along with other still pending cleanup branches.
> >  
> > > How should I manage my tree related to this... Should I rebase my
> > > original DT preparation series on top of this new branch, or can I just
> > > ignore the new branch for now, as long as I merge it at some point
> > > before sending a pull request to mainline?
> > 
> > Yes you need to rebase on this now. And not touch these commits.
> > 
> > Otherwise we'll end up with duplicate commits in the mainline tree,
> > which is a big no-no. If something shows up that needs fixing in this
> > series, it must now be separate patches on top of this series.
> > 
> > When doing pull requests we both just have to make note that there's
> > a dependency to this branch, and it will find it's way to mainline
> > via arm-soc pull request. Or if no conflicts need sorting out, then
> > it will just get merged with your pull request.
> 
> Hmm, I'm still not totally sure how to proceed. What do you mean with
> "make a note"?

Well let's say I had some conflicting platform data clean up patches,
I would pull in your branch, then when sending a pull request I would
mention that it depends on your branch being pulled in.
 
> I understand that I can't change the commits, but is it ok for me to now
> merge the for-l-o-3.5 branch into my master branch (which is my "stable"
> branch, for which I'll send a pull request)?

Yes. But I suggest you first add add that panda xm gpio fix into your
for-l-o-3.5 and that way it's safer for me to merge too.
 
> If the same commits are both in my tree and in l-o (or arm-soc), doesn't
> it mean that the commits seem to come into Linus's tree from whoever
> happens to send their pull request first? Then again, does it matter..

Yes, that's OK.
 
> And if there are conflicts in the board files between for-l-o-3.5 and
> some other commits, and you or Arnd resolve those for l-o or arm-soc,
> what happens when the same, but unresolved, commits come from my pull
> request? 

Well in that case it makes sense to get the arm-soc changes merged
first, who wants to resolve conflicts multiple times? Of course more
branches can be pulled into both trees as needed too.
 
> Sorry if this should be obvious, but I haven't done such merging before
> and I'd rather not mess it up =).

Yeah np :)

Tony
