From: Tim Nordell <tim.nordell@logicpd.com>
Subject: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Wed, 06 May 2015 18:17:47 -0500
Message-ID: <554AA11B.9040909@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42273 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbbEFXSR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 19:18:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Yq8a0-0002bM-0c
	for linux-omap@vger.kernel.org; Thu, 07 May 2015 01:18:16 +0200
Received: from 66-162-60-14.static.twtelecom.net ([66.162.60.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2015 01:18:15 +0200
Received: from tim.nordell by 66-162-60-14.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2015 01:18:15 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org

Hi all -

I'm running kernel v3.19 (although I've tried v4.1-rc2's version of the 
MUSB code) on a DM3730 processor.  I'm running into an issue where if I 
enable MUSB Inventra DMA, plug in a USB Ethernet Dongle, and run iperf 
between the dongle and a PC, the MUSB driver stops working.  I get the 
following in my kernel log, twice back-to-back:

     musb_host_rx 1762: Rx interrupt with no errors or packet!

Any ideas?

The test above works in PIO mode, but I'd like to reduce the system CPU 
usage of the driver by using DMA.  I'm using a ASIX AX88772B Ethernet 
dongle, although, this shouldn't impact the error above.  I also tried 
re-reading the RXCSR register immediately after the error printout 
above, and the immediate subsequent time it contains the bit the driver 
is looking for.  I tried nesting the check so that if the bit the driver 
is looking for is set with an immediate subsequent read that it would 
continue past it, but it still keels over (albeit lasting maybe a second 
longer).

Something about this feels race conditiony too.  Depending on the kernel 
configuration options in the kernel debug menu (which slows down other 
parts of the kernel), or if I enable verbose debug message output from 
the MUSB driver, it lasts much, much longer before keeling over as a 
system.  You can restore normal behavior by unplugging/replugging in the 
device.

Thanks,
Tim

