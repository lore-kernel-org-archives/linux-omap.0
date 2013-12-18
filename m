From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Wed, 18 Dec 2013 10:23:54 -0800
Message-ID: <20131218180240.GG27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11253 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab3LRSYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 13:24:04 -0500
Content-Disposition: inline
In-Reply-To: <52B1A922.6020901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131218 05:56]:
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
> I don't have an LDP board at hand, and I wasn't able to find out anything from
> the logs.
> 
> I think I should change omapfb to print something if it's probed succesfully,
> as the deferred probing makes finding out if something is probed fine or not
> quite murky. Without deferred probing, it was simpler: no errors -> the driver
> must be (most likely) ok.
> 
> Although... In an earlier log, where there was no panel driver, the log has
> these errors:
> 
> Error opening /dev/fb0: No such device
> 
> There are none in the latest log, which makes me guess the omapfb has been
> probed, and fb0 is actually there. But the X is still dying for some reason...
> 
> I'll look at this more. Maybe someone in our team can find a board to test.

Hmm I had the framebuffer working with DT on LDP after fixing the twl4030
gpio regression with 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl
gpio output) using this pdata quirks patch:

[PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make omap3 LDP to use it

AFAIK the pdata hack above should not be needed now, but I have not tried
with Tomi's DSS DT patches yet.

Tomi do you have some sample panel dpi .dts entry somewhere for the LDP I
could try at some point?

Russell, maybe all you're missing is just omapfb.vram=0:2M,1:5M or similar
from your kernel cmdline?

> > For the SDP4430, it used to detect the displays, even though nothing has
> > ever been displayed on them.  Now it just spits out this:
> 
> Those particular LCDs are supposed to be updated manually using custom ioctl,
> so normal software using fb won't put anything on the display. For testing
> purposes, a SW based automatic update (~20 fps) can be enabled by kernel
> cmdline parameter "omapfb.auto_update" or via sysfs:
> 
> echo 1 > /sys/class/graphics/fb0/update_mode
> 
> > OMAP DSS rev 4.0
> > omapdss DSI error: can't get VDDS_DSI regulator
> > panel-dsi-cm panel-dsi-cm.0: Failed to connect to video source
> > omapfb omapfb: failed to connect default display
> > omapfb omapfb: failed to init overlay connections
> > omapfb omapfb: failed to setup omapfb
> > platform omapfb: Driver omapfb requests probe deferral
> > ...
> > omapdss DSI error: failed to set complexio power state to 1
> > panel-dsi-cm panel-dsi-cm.0: failed to enable DSI
> > omapfb omapfb: Failed to enable display 'lcd'
> > omapfb omapfb: failed to initialize default display
> > omapfb omapfb: failed to setup omapfb
> 
> Commit e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 (ARM: OMAP2+: Remove legacy mux
> code for display.c) was overly enthusiastic in removing legacy code which was
> already in use. Tony has a partial revert for that queued up. It can also be
> reverted fully for testing. After that, the panel wakes up.

Yes sorry for accidentally removing some extra code there, I just sent a
pull request for the fix. My 4430 SDP is face down in the rack because of
the way the Ethernet connector plugs in..

Regards,

Tony
