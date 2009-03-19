From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH omap-fixes v2] OMAP2/3: GPIO: do not attempt
	to wake-enable
Date: Thu, 19 Mar 2009 10:16:33 -0700
Message-ID: <20090319171632.GL29546@atomide.com>
References: <notify-1237414046@atomide.com> <87skl9mpio.fsf@deeprootsystems.com> <20090319165334.GK29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52234 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZCSRQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 13:16:30 -0400
Content-Disposition: inline
In-Reply-To: <20090319165334.GK29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090319 09:54]:
> * Kevin Hilman <khilman@deeprootsystems.com> [090319 09:44]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > This patch has been applied to the linux-omap
> > > by youw fwiendly patch wobot.
> > >
> > > Commit: 2ac496a208895c925aec1774a873b5b096b2d3f0
> > >
> > > PatchWorks
> > > http://patchwork.kernel.org/patch/10719/
> > >
> > > Git
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=2ac496a208895c925aec1774a873b5b096b2d3f0
> > 
> > Tony, 
> > 
> > $SUBJECT on this commit seems to have been a bit mangled leaving
> > a not very clear commit log/history.
> 
> Heh looks like bad html parsing :) I'll revert and re-apply.

Seems like a bug in pwclient..

$ pwclient get 10719

Shows the subject in the patch as:

Subject: [omap-fixes,
        v2] OMAP2/3: GPIO: do not attempt to wake-enable GPIO bank IRQ

Tony
