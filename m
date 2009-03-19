From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [APPLIED] [PATCH omap-fixes v2] OMAP2/3: GPIO: do not attempt
	to wake-enable
Date: Thu, 19 Mar 2009 18:48:46 +0200
Message-ID: <20090319164846.GA30655@scadufax.research.nokia.com>
References: <notify-1237414046@atomide.com> <87skl9mpio.fsf@deeprootsystems.com> <20090319165334.GK29546@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47282 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbZCSRGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 13:06:06 -0400
Content-Disposition: inline
In-Reply-To: <20090319165334.GK29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 19, 2009 at 05:53:35PM +0100, Tony Lindgren wrote:
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

why do you even try to parse the html ?? patchworks hold it in mbox
format:

http://patchwork.kernel.org/patch/10719/mbox/

-- 
balbi
