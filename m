From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] twl4030: move twl4030-pwrbutton to
	drivers/input/misc
Date: Fri, 27 Feb 2009 10:44:45 -0800
Message-ID: <20090227184445.GJ11594@atomide.com>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com> <1235050197-26818-2-git-send-email-me@felipebalbi.com> <1235050197-26818-3-git-send-email-me@felipebalbi.com> <200902191208.45851.david-b@pacbell.net> <20090219203030.GF20723@frodo> <20090225210546.GC4639@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61110 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbZB0Sov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 13:44:51 -0500
Content-Disposition: inline
In-Reply-To: <20090225210546.GC4639@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@openedhand.com>

* Felipe Balbi <me@felipebalbi.com> [090225 13:07]:
> On Thu, Feb 19, 2009 at 10:30:30PM +0200, Felipe Balbi wrote:
> > On Thu, Feb 19, 2009 at 12:08:45PM -0800, David Brownell wrote:
> > > On Thursday 19 February 2009, Felipe Balbi wrote:
> > > > Take it out of drivers/i2c/chips as requested by Jean Delvare
> > > > that all drivers move out of there.
> > > > 
> > > > Cc: David Brownell <dbrownell@users.sourceforge.net>
> > > > Cc: Samuel Ortiz <sameo@openedhand.com>
> > > > Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> > > 
> > > You're cc'ing Sam on these patches to the OMAP tree ... are you
> > > suggesting this code merge to mainline?
> > 
> > Just so he knows I'm willing to add a few more changes to
> > twl4030-core.c, If you're ok with these patches, I'll send the final
> > version to Sam, mainline and linux-input.
> > 
> > > If so, you'll need to send the input driver to the input list
> > > as a patch against mainline, for review.  The snippet from
> > > your patch 1/2 affecting the twl4030 MFD core might reasonably
> > > be merged with that, assuming Sam's OK with that going though
> > > the input tree.
> > 
> > I could also make them separate. Send the final
> > drivers/input/misc/twl4030-pwrbutton.c to linux-input and the
> > twl4030-core.c to be merged via Sam.
> 
> Does anyone have anything against this patch ? If not, I guess it should
> be applied and I'll generate the patch against mainline for input + mfd
> maintainers.

OK, pushed. These are currently also scheduled for getting reset to
mainline twl code after v2.6.29-omap1 is tagged.

Regards,

Tony
