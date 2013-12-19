From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Thu, 19 Dec 2013 17:53:36 +0000
Message-ID: <20131219175336.GD32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55412 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3LSRy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 12:54:27 -0500
Content-Disposition: inline
In-Reply-To: <52B1A922.6020901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Dec 18, 2013 at 03:54:42PM +0200, Tomi Valkeinen wrote:
> On 2013-12-18 14:00, Russell King - ARM Linux wrote:
> 
> > So, here goes.  LDP3430:
> > 
> > OMAP DSS rev 2.0
> > omapdss DPI error: can't get VDDS_DSI regulator
> > omapfb omapfb: failed to connect default display
> > omapfb omapfb: failed to init overlay connections
> > omapfb omapfb: failed to setup omapfb
> > platform omapfb: Driver omapfb requests probe deferral
> > 
> > I don't see evidence of it being re-probed, but I do see this during boot
> > which implies that there's nothing there:
> > 
> > XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
> >       after 0 requests (0 known processed) with 0 events remaining.
> 
> I don't have an LDP board at hand, and I wasn't able to find out anything
> from the logs.

Well, the X server dies because of some issue with tslib.  No idea
about that.  However, disabling touschreen stuff, the X server comes
up, but the LCD remains blank.

Since the LDP has openembedded stuff on it, it normally would boot
with a progress splash - that also is never displayed.  Maybe there's
something up with the backlight support?  This used to work with
mainline kernels I don't know how long ago.
