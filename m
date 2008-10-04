From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Sat, 4 Oct 2008 23:37:03 +0300
Message-ID: <20081004203700.GK10743@frodo>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <dbdb2ea60810040542n377bafc9sabec371c294e4151@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35380 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYJDUh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 16:37:28 -0400
Content-Disposition: inline
In-Reply-To: <dbdb2ea60810040542n377bafc9sabec371c294e4151@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, david-b@pacbell.net

On Sat, Oct 04, 2008 at 08:42:18AM -0400, twebb wrote:
> >
> > Yeah there is active development going on in linux-omap mailing list
> > for the EVMs too. And Mistral's older 5912OSK is probably the best
> > supported omap board in the mainline kernel.
> >
> > Basically adding new boards is just a question of adding the board-*.c
> > file, and .config for the drivers to include. Some board of course
> > have custom devices too.
> >
> > Anyways, we'll add more boards to the mainline kernel later on, but
> > first we have to get the the minimal omap3 support working with
> > mainline kernel.
> >
> 
> I'm not really looking for OMAP35x EVM support in mainline, but in l-o
> git.  And it seems like that's where it's not often mentioned/tested
> against - but beagle, zoom, overo are.  In looking for 35x support, is
> it wrong to focus on l-o git instead of mainline?  Won't support
> always be in l-o first?

beagle and overo runs with 35x processors. And evm development is going
just fine. git log arch/arm/mach-omap2/board-omap?evm.c will give you
only the board-file changes (not counting drivers).

-- 
balbi
