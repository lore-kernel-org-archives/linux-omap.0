From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap DSS cmdline resolution not working for HDMI?
Date: Fri, 5 Oct 2012 09:43:09 -0700
Message-ID: <20121005164308.GM3874@atomide.com>
References: <20121004175604.GE3874@atomide.com>
 <1349435094.2401.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65531 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752255Ab2JEQnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 12:43:11 -0400
Content-Disposition: inline
In-Reply-To: <1349435094.2401.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121005 04:06]:
> On Thu, 2012-10-04 at 10:56 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > FYI, looks like for some reason DSS command line is not
> > working for HDMI while it works for DSS. On my panda es
> > I'm trying to set my motorola lapdock resolution from
> > cmdline with:
> > 
> > omapdss.def_disp=hdmi omapfb.mode=hdmi:1366x768@60
> > 
> > But it does not seem to do anything and resolution is
> > VGA. If I change the cable to DVI port this works:
> > 
> > omapdss.def_disp=dvi omapfb.mode=dvi:1366x768@60
> > 
> > Any ideas? This is with current linux next.
> 
> That's because our HDMI only supports certain timings. To be honest, I
> don't really understand this restriction, as I believe the hardware
> should be able to use more or less any timings just like DVI.
> 
> The 1366x768@60 mode is parsed with fbdev functions, which returns a
> video timings. These timings are then given to the HDMI driver, which
> tries to find matching timings from its timing table. And when it
> doesn't find a match, it fails.
> 
> This is a known problem, and the hdmi driver would really need some love
> in other aspects also. I'm not sure what would be the best way to
> improve this without doing major rewrites. Perhaps the check in the hdmi
> driver could be more relaxed, but that needs some careful thought.

OK, I'll take a look when I have a chance.
 
> > I can change the HDMI resolution OK from userspace with:
> > 
> > echo "1" > /sys/devices/platform/omapdss/display1/enabled
> > echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
> > echo "tv" > /sys/devices/platform/omapdss/overlay0/manager
> > echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
> > echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/display1/timings
> 
> That's because the above line has timings that are in the hdmi driver's
> table. They are somewhat different than what fbdev gives for
> "1366x768@60".

OK
 
> > The reason to use HDMI instead of DVI here is that HDMI
> > also has the speakers on the lapdock ;)
> > 
> > Then I'm able to switch between HDMI panel and DVI panel
> > just fine using overlay0. I don't know if getting both
> > HDMI and DVI to work the same time using overlay1 is
> > supposed to work, but trying use overlay1 produces the
> > following:
> 
> HDMI and DVI cannot be used reliably at the same time, due to a HW issue
> we've had unresolved for a long time. Luckily, it was solved this week
> and we'll have a patch for next merge window to get this working.

That's nice, I'll give that a try at some point.
 
> > echo "1" > /sys/devices/platform/omapdss/display0/enabled
> > echo "0" > /sys/devices/platform/omapdss/overlay1/enabled
> > echo "lcd2" > /sys/devices/platform/omapdss/overlay1/manager
> > echo "1" > /sys/devices/platform/omapdss/overlay1/enabled
> > echo "170666,1920/336/128/208,1200/38/1/3" > /sys/devices/platform/omapdss/display0/timings
> > 
> > [  816.446044] omapdss DPI: Could not find exact pixel clock. Requested 23500 kHz, got 23630 kHz
> > [  881.639221] omapdss APPLY: timeout in wait_pending_extra_info_updates
> > [  958.946594] ------------[ cut here ]------------
> > [  958.953277] WARNING: at drivers/bus/omap_l3_noc.c:97 l3_interrupt_handler+0xc0/0x184()
> > [  958.965576] L3 standard error: TARGET:DMM2 at address 0x0
> > ...
> 
> Having said the above, I don't quite know where this error comes from...
> Tiler (DMM) is not even used by omapfb.

Looks like somehow also output_size won't change when changing
display output from DVI to HDMI.

If I boot with DVI panel at 1600x1200, then try to switch to the
HDMI monitor with the following script:

#!/bin/sh

export dvi=display0
export hdmi=display1
export overlay=overlay0

echo 0 > /sys/devices/platform/omapdss/$dvi/enabled
echo 1 > /sys/devices/platform/omapdss/$hdmi/enabled
echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/$hdmi/timings
echo 0 > /sys/devices/platform/omapdss/$overlay/enabled
echo tv > /sys/devices/platform/omapdss/$overlay/manager
#echo "1366,768" > /sys/devices/platform/omapdss/$overlay/output_size
echo 1 > /sys/devices/platform/omapdss/$overlay/enabled
cat /sys/devices/platform/omapdss/$hdmi/timings
cat /sys/devices/platform/omapdss/$overlay/output_size

I get the following which may provide more clues:

[64370.820312] omapdss DISPC error: SYNC_LOST on channel tv, restarting the output with video overlays dd
[64370.831024] omapdss OVERLAY error: overlay 0 horizontally not inside the display area (0 + 1600 >= 13)
[64370.840972] omapdss APPLY error: failed to enable manager 1: check_settings failed
[64370.849670] omapdss HDMI error: failed to power on device
[64370.855407] omapdss error: failed to power on
[64370.862487] omapdss OVERLAY error: overlay 0 horizontally not inside the display area (0 + 1600 >= 13)
[64370.872436] omapdss APPLY error: failed to enable manager 1: check_settings failed
[64370.880798] omapdss HDMI error: failed to power on device
[64370.886505] omapdss error: failed to power on
85500,1366/70/213/143,768/3/24/3
1600,1200

FYI, I'm also seeing the DVI monitor blank out on it's own for
about a second or so on regular basis every 10 minutes or so.
No idea what's causing that, maybe it's a reminder to take
a short break :)

Regards,

Tony
