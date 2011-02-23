From: Tony Lindgren <tony@atomide.com>
Subject: Re: State of LDP3430 platform
Date: Wed, 23 Feb 2011 14:50:22 -0800
Message-ID: <20110223225022.GC30316@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20110212160216.GA22694@n2100.arm.linux.org.uk>
 <20110212161053.GA23481@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38876 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab1BWWu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 17:50:26 -0500
Content-Disposition: inline
In-Reply-To: <20110212161053.GA23481@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110212 08:09]:
> On Sat, Feb 12, 2011 at 04:02:16PM +0000, Russell King - ARM Linux wrote:
> > Another LDP3430 report...
> > 
> > The LDP3430 seems to be getting there, but:
> > 
> > 1. LCD screen seems wrong.  The X display looks rather large, and
> >    flickery - looks like the LCD timing parameters are wrong.  Some
> >    text disappears off the RHS.
> > 
> >    fbset reports:
> > 	mode "240x320-510"
> > 		# D: 48.001 MHz, H: 168.424 kHz, V: 510.375 Hz
> > 		geometry 240 320 240 320 16
> > 		timings 20833 3 39 2 7 3 1
> > 		accel false
> > 		rgba 5/11,6/5,5/0,0/0
> > 
> >    kernel config:
> > 	CONFIG_FB_OMAP=y
> > 	CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> > 
> >    with the supplied kernel:
> > 	mode "640x480-64"
> > 		# D: 21.601 MHz, H: 31.396 kHz, V: 63.813 Hz
> > 		geometry 640 480 640 640 16
> > 		timings 46295 40 4 8 2 4 2
> > 		accel false
> > 		rgba 5/11,6/5,5/0,0/0
> >    so the LCD timings in the kernel appear to be wrong for the panel
> >    on the LDP.  What is 'CONFIG_FB_OMAP_LCD_VGA'?  There's *no* help
> >    for this configuration option so god only knows what it's right
> >    setting should be.  Please give it some help text to explain what
> >    it is and what it does.
> 
> LCD works better with FB_OMAP_LCD_VGA set, but why is this necessary?
> 
> > 2. Keyboard - numeric keys produce wrong ascii for their labelled
> >    function.  This is from /dev/tty1 with X running:
> > 
> > 	1 gives nothing	2 gives 4	3 gives 7
> > 	4 gives 2	5 gives 5	6 gives 8
> > 	7 gives 3	8 gives nothing	9 gives 9
> > 	* gives nothing	0 gives E	# gives nothing
> > 
> >    off-hook (green phone) gives 0
> >    on-hook (red phone) gives <1b><5b><31><39><7e>
> > 
> >    Killing X and then running evtest on /dev/input/event1 doesn't
> >    return any events, neither does reading /dev/tty1 for the twl4030
> >    keypad - the numeric keys are completely dead.  /proc/interrupts
> >    shows no new interrupt counts when pressing the key for
> >    'twl4030_keypad'.  Unbinding/rebinding the twl4030 driver doesn't
> >    sort it out, neither does restarting X.
> 
> 3. Touchscreen is dead, presumably because no devices are bound to
>    ads7846 SPI driver.
> 
> ls -al /sys/bus/spi/devices/
> total 0
> drwxr-xr-x  2 root root 0 Jan  1 01:02 .
> drwxr-xr-x  4 root root 0 Jan  1 01:02 ..
> lrwxrwxrwx  1 root root 0 Jan  1 01:02 spi1.0 -> ../../../devices/platform/omap2_mcspi.1/spi1.0
> 
> is the only SPI device which appears, but is unbound.  I'm sure this used
> to work at some point.

Anybody from TI looking into these?

Regards,

Tony
