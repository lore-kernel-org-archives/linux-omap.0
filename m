From: Imre Deak <imre.deak@nokia.com>
Subject: Re: LDP support
Date: Thu, 14 May 2009 12:07:31 +0300
Message-ID: <20090514090731.GB29164@localhost>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23465 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZENJJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 05:09:47 -0400
Content-Disposition: inline
In-Reply-To: <20090506040015.GM5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>

On Wed, May 06, 2009 at 06:00:16AM +0200, ext Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090505 12:52]:
> > On Tue, Apr 28, 2009 at 03:42:37PM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
> > > > Tony, et.al.,
> > > > 
> > > > Any ideas when more LDP support will be pushed into mainline (such as
> > > > the framebuffer support)?
> > > 
> > > I'll be looking at the board-*.c patches for the next merge window
> > > hopefully this week or next week.
> > > 
> > > Looks like LDP keyboard, touchscreen & RTC are pretty much ready
> > > to go. Then the MMC has some regulator updates, but AFAIK the MMC
> > > should work OK already.
> > > 
> > > For the framebuffer, Imre and Tomi know the status the best, so
> > > I've added them to Cc.
> > > 
> > > Imre has been meaning to send a bunch of drivers/video/omap changes
> > > to the fbdev list for a while now and LDP framebuffer may depend on
> > > those. Imre, any news on the status of sending the fb patches
> > > upstream?
> > > 
> > > Then there are the upcoming DSS patches from Tomi, but those still
> > > need some work before they're ready to go.
> > 
> > Is there any news on this?  Will we see more functional OMAP3 / LDP
> > support queued for the next merge window?
> 
> Yes fro the stuff listed above, but still no news on the framebuffer
> patches. Imre?

There is a mainline based tree with the missing DSS1 FB stuff that I'm
planning to submit to fb-devel:

git clone git://koowaldah.org/people/imre/linux-2.6-fb

I could only compile test it for OMAP2/3 targets, it would be nice
if someone could check if it works too. Also if some DSS1 FB related things
are still missing from that tree, I could add them / submit them with
the rest of the things.

Sorry for the big delay.

--Imre

