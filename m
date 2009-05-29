From: Peter Barada <peterb@logicpd.com>
Subject: Trying to get OMAP3530 twl4030-usb interrupt to trigger
Date: Fri, 29 May 2009 14:38:03 -0400
Message-ID: <1243622283.24506.19.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:58456 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752505AbZE2SiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 14:38:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>


On the Logic LV SOM board, if I have a device plugged into the OTG port
on boot (with Vbus supplied by an external MIC2076),  everything works,
I see enumeration, can pull the device and it disconnects, and on
reinsertion, its found and enumerated.  However, if I powerup w/o a
device plugged in, the OTG acts like a brick, no interrupt/discovery of
a device when its plugged in.

The circuitry is very similar to the Beagle except that the beagle can
use Vbus to provide power to the board.

I'm using 2.6.30-rc5 pulled from Tony's tree with commit: 

commit f6ea2bbc8d4346c3a263ed86a92435d67f652809
Author: Roger Quadros <ext-roger.quadros@nokia.com>
Date:   Thu May 14 13:48:27 2009 -0700

    RX51: Remove multiple definition of MACH_NOKIA_RX51 in Kconfig

At this point I've been pulling my hair out as this code runs on Beagle
(with the 5V external power supplied), and Beagle properly discovers
devices plugged in after startup.

What I'd like to do is to turn on USB interrupts through INT1 (sys_nIRQ)
to signal a USB interrupt for IDGND/IDFLOAT, but even after hacking up
registers in the twl4030-usb and seeing USB_INT transition to indicate
IDGND, I don't get an interrupt.

1) Should the twl4030-usb interrupt fire in the code on
insertion/removal?

2) If not, then any ideas on how to plumb the USB interrupt out of the
twl4030?

3) Which actual interrupt does IRQ378 (the one twl4030-usb request)
correspond to?

Thanks in advance!
-- 
Peter Barada <peterb@logicpd.com>
