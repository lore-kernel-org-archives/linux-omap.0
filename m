From: Tony Lindgren <tony@atomide.com>
Subject: omap DSS cmdline resolution not working for HDMI?
Date: Thu, 4 Oct 2012 10:56:04 -0700
Message-ID: <20121004175604.GE3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:25753 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751Ab2JDR4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 13:56:06 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

FYI, looks like for some reason DSS command line is not
working for HDMI while it works for DSS. On my panda es
I'm trying to set my motorola lapdock resolution from
cmdline with:

omapdss.def_disp=hdmi omapfb.mode=hdmi:1366x768@60

But it does not seem to do anything and resolution is
VGA. If I change the cable to DVI port this works:

omapdss.def_disp=dvi omapfb.mode=dvi:1366x768@60

Any ideas? This is with current linux next.

I can change the HDMI resolution OK from userspace with:

echo "1" > /sys/devices/platform/omapdss/display1/enabled
echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
echo "tv" > /sys/devices/platform/omapdss/overlay0/manager
echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
echo "85500,1366/70/213/143,768/3/24/3" > /sys/devices/platform/omapdss/display1/timings

The reason to use HDMI instead of DVI here is that HDMI
also has the speakers on the lapdock ;)

Then I'm able to switch between HDMI panel and DVI panel
just fine using overlay0. I don't know if getting both
HDMI and DVI to work the same time using overlay1 is
supposed to work, but trying use overlay1 produces the
following:

echo "1" > /sys/devices/platform/omapdss/display0/enabled
echo "0" > /sys/devices/platform/omapdss/overlay1/enabled
echo "lcd2" > /sys/devices/platform/omapdss/overlay1/manager
echo "1" > /sys/devices/platform/omapdss/overlay1/enabled
echo "170666,1920/336/128/208,1200/38/1/3" > /sys/devices/platform/omapdss/display0/timings

[  816.446044] omapdss DPI: Could not find exact pixel clock. Requested 23500 kHz, got 23630 kHz
[  881.639221] omapdss APPLY: timeout in wait_pending_extra_info_updates
[  958.946594] ------------[ cut here ]------------
[  958.953277] WARNING: at drivers/bus/omap_l3_noc.c:97 l3_interrupt_handler+0xc0/0x184()
[  958.965576] L3 standard error: TARGET:DMM2 at address 0x0
...

Regards,

Tony
