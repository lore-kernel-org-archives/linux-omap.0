From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch twl 1/2] remove <linux/i2c/twl4030-rtc.h>
Date: Fri, 3 Oct 2008 07:21:56 -0700
Message-ID: <200810030721.57494.david-b@pacbell.net>
References: <200810012342.50866.david-b@pacbell.net> <20081002090517.GH7412@gandalf.research.nokia.com> <20081003132857.GM25482@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:48081 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751118AbYJCOV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 10:21:59 -0400
In-Reply-To: <20081003132857.GM25482@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Friday 03 October 2008, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [081002 12:08]:
> > On Wed, Oct 01, 2008 at 11:42:50PM -0700, David Brownell wrote:
> > > From: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > > Remove <linux/i2c/twl4030-rtc.h> by moving all the relevant contents
> > > into the driver itself, and removing the rest.  Stuff removed included
> > > many useless bitmasks, and remnants of the platform data hook.
> > > 
> > > ....
> > > 
> > > No functional changes, just shrinkage.
> > > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > I was willing to get rid of all of them and just keep twl4030.h
> > Nice job Dave :-)
> 
> This one does not apply, maybe some other patch is missing?

Yes; one in addition to the two you merged with the RC8 sync.
I'll repost all the as-yet-unmerged TWL related patches on
top of RC8.

- Dave


> patching file drivers/rtc/rtc-twl4030.c
> Hunk #1 FAILED at 28.
> Hunk #2 succeeded at 375 (offset 8 lines).
> Hunk #3 succeeded at 407 (offset 8 lines).
> Hunk #4 succeeded at 419 (offset 8 lines).
> Hunk #5 succeeded at 467 (offset 8 lines).
> Hunk #6 succeeded at 496 (offset 8 lines).
> Hunk #7 succeeded at 506 (offset 8 lines).
> Hunk #8 succeeded at 514 (offset 8 lines).
> 1 out of 8 hunks FAILED -- saving rejects to file
> drivers/rtc/rtc-twl4030.c.rej
> patching file include/linux/i2c/twl4030-pwrirq.h
> patching file include/linux/i2c/twl4030-rtc.h
> 
> Tony
> 


