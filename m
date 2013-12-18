From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP display subsystem - does it work?
Date: Wed, 18 Dec 2013 12:00:23 +0000
Message-ID: <20131218120023.GG4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55367 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3LRMBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 07:01:12 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

In my continuing woes with having the OMAP boards I have produce output,
where things used to work on the LDP, they now do not.  And on the SDP4430
board, where things were detected, they're no longer detected.

I thought this was just a matter of adjusting the configuration, but it
seems there's much more wrong than just that - so I wasn't too worried.
Last night, I updated the configuration to ensure that the appropriate
connector configuration symbols were enabled (see the changelog in the
configuration seeds.)

All the time that stuff on OMAP gets broken and/or doesn't work (inspite
of repeated attempts at reporting problems - I've never seen the displays
on the SDP4430 board ever work with a mainline kernel in all the years
I've had the platform - but they have worked with the originally supplied
TI kernels) I really find myself not really caring very much about OMAP
and whether it works or not.

Quite honestly, I regard OMAP as nothing more than an overly complex toy
implementation rather than a serious architecture because of this kind
of stuff - unlike every other ARM platform where stuff like this "just
works", OMAP stuff is always seems to be much harder to make work, and
more prone to stuff breaking.

So, here goes.  LDP3430:

OMAP DSS rev 2.0
omapdss DPI error: can't get VDDS_DSI regulator
omapfb omapfb: failed to connect default display
omapfb omapfb: failed to init overlay connections
omapfb omapfb: failed to setup omapfb
platform omapfb: Driver omapfb requests probe deferral

I don't see evidence of it being re-probed, but I do see this during boot
which implies that there's nothing there:

XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
      after 0 requests (0 known processed) with 0 events remaining.



For the SDP4430, it used to detect the displays, even though nothing has
ever been displayed on them.  Now it just spits out this:

OMAP DSS rev 4.0
omapdss DSI error: can't get VDDS_DSI regulator
panel-dsi-cm panel-dsi-cm.0: Failed to connect to video source
omapfb omapfb: failed to connect default display
omapfb omapfb: failed to init overlay connections
omapfb omapfb: failed to setup omapfb
platform omapfb: Driver omapfb requests probe deferral
...
omapdss DSI error: failed to set complexio power state to 1
panel-dsi-cm panel-dsi-cm.0: failed to enable DSI
omapfb omapfb: Failed to enable display 'lcd'
omapfb omapfb: failed to initialize default display
omapfb omapfb: failed to setup omapfb

Configurations, build and boot logs are all on
http://www.arm.linux.org.uk/developer/build/
