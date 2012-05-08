From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DSS2 DVI output: red screen
Date: Tue, 8 May 2012 05:21:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA18990@DBDE01.ent.ti.com>
References: <CAEULaV+_Ch7T0yA==XC8_xORhN2rcre=W4nbKYq+vxQkdKAeCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56499 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667Ab2EHFVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 01:21:40 -0400
In-Reply-To: <CAEULaV+_Ch7T0yA==XC8_xORhN2rcre=W4nbKYq+vxQkdKAeCw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Neil Johnson <neilj@procerusuav.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 08, 2012 at 04:41:35, Neil Johnson wrote:
> Linux OMAP list:
> 
> We are proving out the DVI output on a DM3730 board that we've
> designed, and we're seeing something strange: Our output to the video
> window is always red.  We see the penguin show up in the corner, and
> text/graphics show up, but the red channel is always on for all pixels
> on the screen.
> 
> Studying our schematic and comparing with the Beagleboard-xm
> schematic, it appears that we're hooking everything up the same way,
> with just some subtle differences:
> 
> We desire to output 1280x720 resolution (720p), and that means we need
> to use the alternate configuration for the DSS output pins, as
> mentioned in the DM3730 TRM:
> 
> On Page 1564, it states:
> 
> The DISPC_DATA_LCD[5:0] data multiplexed with the DSI signals on
> dss_data[5:0] pads is limited to up to 60 MHz pixel clock frequency.
> If the parallel 18/24-bit interface in bypass mode with a pixel clock
> above 60 MHz is required, the DISPC_DATA_LCD[5:0] multiplexed on
> dss_data[23:18] pads, and DISPC_DATA_LCD[23:18] multiplexed on
> sys_boot pads must be used.
> 
> So, we've mapped DISPC_DATA_LCD[5:0] to dss_data[23:18] pads and
> routed DISPC_DATA_LCD[23:18] to be multiplexed with the sys_boot pads.
> 
> Our sys_boot pads are all pulled up to 1.8 V through 4.7 K-ohm
> resistors.  I'm suspicious that this is causing the red lines to be
> pulled high, generating red pixels all the time.  Am I off-base here?
> Is there something I'm missing, like the U-boot mux configuration or
> something?  What can I check from a software level to verify that all
> is correct?  According to the Beagle-board-xm manual, the board
> auto-detects which way things are hooked up, but maybe I haven't
> grabbed that code from the beagleboard board file?  Thanks,
> 


Make sure that you have configured the pin mux settings accordingly,
We have similar interface done on OMAP3EVM, so you can refer to the
Omap3evm code,

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=blob;f=arch/arm/mach-omap2/board-omap3evm.c;h=fd1b481c762c97576f1c9cb5503e9bd470a4a528;hb=5e136da4f5d9aa5388097afad1f6a0e6fd8572c6#l556

Thanks,
Vaibhav
