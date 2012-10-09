From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap DSS cmdline resolution not working for HDMI?
Date: Tue, 9 Oct 2012 14:54:16 -0700
Message-ID: <20121009215415.GI12552@atomide.com>
References: <20121004175604.GE3874@atomide.com>
 <1349435094.2401.17.camel@deskari>
 <20121005164308.GM3874@atomide.com>
 <1349788010.2409.38.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37178 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757081Ab2JIVyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 17:54:18 -0400
Content-Disposition: inline
In-Reply-To: <1349788010.2409.38.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121009 06:08]:
> On Fri, 2012-10-05 at 09:43 -0700, Tony Lindgren wrote:
> 
> > Looks like somehow also output_size won't change when changing
> > display output from DVI to HDMI.
> > 
> > If I boot with DVI panel at 1600x1200, then try to switch to the
> > HDMI monitor with the following script:
> > 
> > #!/bin/sh
> > 
> > export dvi=display0
> > export hdmi=display1
> > export overlay=overlay0
> > 
> > echo 0 > /sys/devices/platform/omapdss/$dvi/enabled
> > echo 1 > /sys/devices/platform/omapdss/$hdmi/enabled
> > echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/$hdmi/timings
> > echo 0 > /sys/devices/platform/omapdss/$overlay/enabled
> > echo tv > /sys/devices/platform/omapdss/$overlay/manager
> > #echo "1366,768" > /sys/devices/platform/omapdss/$overlay/output_size
> > echo 1 > /sys/devices/platform/omapdss/$overlay/enabled
> > cat /sys/devices/platform/omapdss/$hdmi/timings
> > cat /sys/devices/platform/omapdss/$overlay/output_size
> > 
> > I get the following which may provide more clues:
> > 
> > [64370.820312] omapdss DISPC error: SYNC_LOST on channel tv, restarting the output with video overlays dd
> > [64370.831024] omapdss OVERLAY error: overlay 0 horizontally not inside the display area (0 + 1600 >= 13)
> > [64370.840972] omapdss APPLY error: failed to enable manager 1: check_settings failed
> > [64370.849670] omapdss HDMI error: failed to power on device
> > [64370.855407] omapdss error: failed to power on
> > [64370.862487] omapdss OVERLAY error: overlay 0 horizontally not inside the display area (0 + 1600 >= 13)
> > [64370.872436] omapdss APPLY error: failed to enable manager 1: check_settings failed
> > [64370.880798] omapdss HDMI error: failed to power on device
> > [64370.886505] omapdss error: failed to power on
> > 85500,1366/70/213/143,768/3/24/3
> > 1600,1200
> 
> Well, it's not that simple =). There are three things to consider:
> 
> - Framebuffer in the sdram. It has xres and yres parameters.
> - Overlay, and it's input size (from fb) and output sizes (must fit into
> the display).
> - Display, which has certain size depending on video mode.
> 
> Only VID overlays can have different input and output sizes, GFX overlay
> does not support scaling.
> 
> In the script above you don't change the fb at all. You can do that with
> when the overlay is disabled, for example:
> 
> fbset -xres 1366 -vxres 1366 -yres 768 -vyres 768
> 
> But that only works if there's enough memory allocated for the
> framebuffer, but that is the case for you if the fb was bigger
> initially. Otherwise you need to set the new size
> with /sys/class/graphics/fb0/size before resizing the fb.
> 
> And, of course, the framebuffer cannot be in use at that time by, for
> example, X.

Thanks for the explanation, I'll give that a try at some point.
 
> Yes, it's complex! I hope omapdrm will make all things simple, and we
> can forget omapfb. In hindsight, I should've designed omapfb to be much
> simpler, and only use gfx overlay. Making it support all overlays is a
> never ending source for problems and complexity.

Heh oh well it works reasonably for most cases I guess.
 
> > FYI, I'm also seeing the DVI monitor blank out on it's own for
> > about a second or so on regular basis every 10 minutes or so.
> > No idea what's causing that, maybe it's a reminder to take
> > a short break :)
> 
> Well that's something different. I've recently done some testing with
> using DSI PLL for generating pixel clock, and I've seen unstabilities
> with that. But perhaps there's something else wrong also, even when
> using the PRCM for pix clock as in your case.
> 
> Does your monitor ever report something like bad signal or such?

Yes I've seen that too, but that seems to be different issue and
I may have passed wrong timings in that case.

I guess the random blanking for a second or so could also be
an occastional bad timing. No warnings in that case on the monitor
though.

Regards,

Tony
