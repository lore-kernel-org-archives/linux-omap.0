From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: LDP support
Date: Tue, 5 May 2009 20:52:31 +0100
Message-ID: <20090505195231.GB8004@n2100.arm.linux.org.uk>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40702 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbZEETwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 15:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20090428224237.GT22457@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Tue, Apr 28, 2009 at 03:42:37PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090428 15:07]:
> > Tony, et.al.,
> > 
> > Any ideas when more LDP support will be pushed into mainline (such as
> > the framebuffer support)?
> 
> I'll be looking at the board-*.c patches for the next merge window
> hopefully this week or next week.
> 
> Looks like LDP keyboard, touchscreen & RTC are pretty much ready
> to go. Then the MMC has some regulator updates, but AFAIK the MMC
> should work OK already.
> 
> For the framebuffer, Imre and Tomi know the status the best, so
> I've added them to Cc.
> 
> Imre has been meaning to send a bunch of drivers/video/omap changes
> to the fbdev list for a while now and LDP framebuffer may depend on
> those. Imre, any news on the status of sending the fb patches
> upstream?
> 
> Then there are the upcoming DSS patches from Tomi, but those still
> need some work before they're ready to go.

Is there any news on this?  Will we see more functional OMAP3 / LDP
support queued for the next merge window?
