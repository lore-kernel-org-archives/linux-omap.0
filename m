From: Neil Johnson <neilj@procerusuav.com>
Subject: DSS2 DVI output: red screen
Date: Mon, 7 May 2012 17:11:35 -0600
Message-ID: <CAEULaV+_Ch7T0yA==XC8_xORhN2rcre=W4nbKYq+vxQkdKAeCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45821 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622Ab2EGXLh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 19:11:37 -0400
Received: by werb10 with SMTP id b10so1559254wer.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 16:11:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Linux OMAP list:

We are proving out the DVI output on a DM3730 board that we've
designed, and we're seeing something strange: Our output to the video
window is always red.  We see the penguin show up in the corner, and
text/graphics show up, but the red channel is always on for all pixels
on the screen.

Studying our schematic and comparing with the Beagleboard-xm
schematic, it appears that we're hooking everything up the same way,
with just some subtle differences:

We desire to output 1280x720 resolution (720p), and that means we need
to use the alternate configuration for the DSS output pins, as
mentioned in the DM3730 TRM:

On Page 1564, it states:

The DISPC_DATA_LCD[5:0] data multiplexed with the DSI signals on
dss_data[5:0] pads is limited to up to 60 MHz pixel clock frequency.
If the parallel 18/24-bit interface in bypass mode with a pixel clock
above 60 MHz is required, the DISPC_DATA_LCD[5:0] multiplexed on
dss_data[23:18] pads, and DISPC_DATA_LCD[23:18] multiplexed on
sys_boot pads must be used.

So, we've mapped DISPC_DATA_LCD[5:0] to dss_data[23:18] pads and
routed DISPC_DATA_LCD[23:18] to be multiplexed with the sys_boot pads.

Our sys_boot pads are all pulled up to 1.8 V through 4.7 K-ohm
resistors.  I'm suspicious that this is causing the red lines to be
pulled high, generating red pixels all the time.  Am I off-base here?
Is there something I'm missing, like the U-boot mux configuration or
something?  What can I check from a software level to verify that all
is correct?  According to the Beagle-board-xm manual, the board
auto-detects which way things are hooked up, but maybe I haven't
grabbed that code from the beagleboard board file?  Thanks,

Neil Johnson
