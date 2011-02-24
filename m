From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: State of LDP3430 platform
Date: Thu, 24 Feb 2011 13:51:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033CCEB86A@dbde02.ent.ti.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20110212160216.GA22694@n2100.arm.linux.org.uk>
 <20110212161053.GA23481@n2100.arm.linux.org.uk>
 <20110223225022.GC30316@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab1BXIWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 03:22:02 -0500
In-Reply-To: <20110223225022.GC30316@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, February 24, 2011 4:20 AM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Shilimkar, Santosh;
> Woodruff, Richard
> Subject: Re: State of LDP3430 platform
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110212 08:09]:
> > On Sat, Feb 12, 2011 at 04:02:16PM +0000, Russell King - ARM Linux
> wrote:
> > > Another LDP3430 report...
> > >
> > > The LDP3430 seems to be getting there, but:
> > >
> > > 1. LCD screen seems wrong.  The X display looks rather large, and
> > >    flickery - looks like the LCD timing parameters are wrong.  Some
> > >    text disappears off the RHS.
> > >
> > >    fbset reports:
> > > 	mode "240x320-510"
> > > 		# D: 48.001 MHz, H: 168.424 kHz, V: 510.375 Hz
> > > 		geometry 240 320 240 320 16
> > > 		timings 20833 3 39 2 7 3 1
> > > 		accel false
> > > 		rgba 5/11,6/5,5/0,0/0
> > >
> > >    kernel config:
> > > 	CONFIG_FB_OMAP=y
> > > 	CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> > >
> > >    with the supplied kernel:
> > > 	mode "640x480-64"
> > > 		# D: 21.601 MHz, H: 31.396 kHz, V: 63.813 Hz
> > > 		geometry 640 480 640 640 16
> > > 		timings 46295 40 4 8 2 4 2
> > > 		accel false
> > > 		rgba 5/11,6/5,5/0,0/0
> > >    so the LCD timings in the kernel appear to be wrong for the panel
> > >    on the LDP.  What is 'CONFIG_FB_OMAP_LCD_VGA'?  There's *no* help

I would send a patch for this to Tomi.

> > >    for this configuration option so god only knows what it's right
> > >    setting should be.  Please give it some help text to explain what
> > >    it is and what it does.
I think it is because x_res and y_res of panel are set to QVGA (320 X 240)
and the content sent is VGA (640 X 480)


With CONFIG_FB_OMAP_LCD_VGA=y the resolution taken is VGA (640 X 480)
You can check drivers/video/omap/lcd_ldp.c
http://lxr.linux.no/#linux+v2.6.37/drivers/video/omap/lcd_ldp.c#L185

> >
> > LCD works better with FB_OMAP_LCD_VGA set, but why is this necessary?

This would set the resolution to VGA (640 X 480)

3430 SDP has a switch to toggle between VGA (640 X 480) and QQVGA (320 X 240). So this switch must also be toggled along with the when we are booting a kernel with CONFIG_FB_OMAP_LCD_VGA=y

In LDP it is controlled by a GPIO:
#define LCD_PANEL_QVGA_GPIO             56
Depending on value of this the resolution is selected.
If LCD_PANEL_QVGA_GPIO is 1 then resolution is 320 X 240

Also, could you please share other CONFIG options which you are enabling over omap2plus_defconfig? (Otherwise please share .config)

-Thanks,
Mayuresh

> >
> > > 2. Keyboard - numeric keys produce wrong ascii for their labelled
> > >    function.  This is from /dev/tty1 with X running:
> > >
> > > 	1 gives nothing	2 gives 4	3 gives 7
> > > 	4 gives 2	5 gives 5	6 gives 8
> > > 	7 gives 3	8 gives nothing	9 gives 9
> > > 	* gives nothing	0 gives E	# gives nothing
> > >
> > >    off-hook (green phone) gives 0
> > >    on-hook (red phone) gives <1b><5b><31><39><7e>
> > >
> > >    Killing X and then running evtest on /dev/input/event1 doesn't
> > >    return any events, neither does reading /dev/tty1 for the twl4030
> > >    keypad - the numeric keys are completely dead.  /proc/interrupts
> > >    shows no new interrupt counts when pressing the key for
> > >    'twl4030_keypad'.  Unbinding/rebinding the twl4030 driver doesn't
> > >    sort it out, neither does restarting X.
> >
> > 3. Touchscreen is dead, presumably because no devices are bound to
> >    ads7846 SPI driver.
> >
> > ls -al /sys/bus/spi/devices/
> > total 0
> > drwxr-xr-x  2 root root 0 Jan  1 01:02 .
> > drwxr-xr-x  4 root root 0 Jan  1 01:02 ..
> > lrwxrwxrwx  1 root root 0 Jan  1 01:02 spi1.0 ->
> ../../../devices/platform/omap2_mcspi.1/spi1.0
> >
> > is the only SPI device which appears, but is unbound.  I'm sure this
> used
> > to work at some point.
> 
> Anybody from TI looking into these?
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
