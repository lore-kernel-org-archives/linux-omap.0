From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] misc. OMAP PM updates for v3.1
Date: Mon, 27 Jun 2011 12:22:12 -0700
Message-ID: <20110627192211.GX23145@atomide.com>
References: <87vcvw5akk.fsf@ti.com>
 <20110627112843.GN23145@atomide.com>
 <87oc1jcj7c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47041 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753897Ab1F0TWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 15:22:13 -0400
Content-Disposition: inline
In-Reply-To: <87oc1jcj7c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110627 09:45]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@ti.com> [110623 17:32]:
> >> Tony,
> >> 
> >> Please pull the following misc. OMAP PM updates targetted for v3.1.
> >> 
> >> This branch is based on your 'fixes' branch due to some dependencies.
> >>       OMAP2: PM debug: move wakeup timer into clockevent code
> >
> > This won't work with the devel-timer branch. I think we should just
> > drop it for now based on what I mentioned in the other thread.
> 
> Hmm, so it's not just the wakeup timer that conflicts between
> devel-timer and my pm-misc branch.
> 
> My branch also removes a bunch of other stuff from pm-debug.c and pm.h
> so it has overlapping changes with your devel-timer branch.
> 
> The conflicts are easy enough to resolve since both branches are just
> removing code.

OK thanks for checking.
 
> Is your devel-timer branch stable now?  Should I rebase my branch on top
> of devel-timer?  or can you just handle the conflicts?

Just pushed what hopefully is the last version. But since there may
still be some comments, it's probably best that I resolve the
conflicts when merging.

Tony
