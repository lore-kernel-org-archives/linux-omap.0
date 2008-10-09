From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/0] Add minimal omap34xx support
Date: Thu, 9 Oct 2008 18:17:25 +0300
Message-ID: <20081009151724.GK26230@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59385 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbYJIPRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 11:17:40 -0400
Content-Disposition: inline
In-Reply-To: <20081009145436.GI435@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081009 17:54]:
> On Sat, Oct 04, 2008 at 07:05:35AM +0000, Tony Lindgren wrote:
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
> 
> Note that my only OMAP based board(s) here are the Nokia 770 (which I
> don't classify as a development platform) and the OMAP3430 LDP board.

Yeah 770 has bunch of stuff that should be cleand up first.. It's pretty
much useless without cbus support.

> Having the LDP board queued up in preference to things like the
> Gumstix, Beagle and Overo would be far more useful to me.

Sure, I'll post a minimal LDP patch separately tomorrow. I don't have
an LDP so I can't verify it boots though.

Tony
