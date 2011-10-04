From: Orjan Friberg <of@flatfrog.com>
Subject: USB gadget unreliable on software reboot (BeagleBoard xM)
Date: Tue, 4 Oct 2011 09:39:15 +0200
Message-ID: <4E8AB823.3030705@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:15787
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754972Ab1JDHoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 03:44:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi,

On my BeagleBoard xM, configuring the MUSB controller in Linux to 
peripheral mode (i.e. not OTG mode) and using a built-in gadget driver, 
the gadget device sometimes does not appear after a software reboot.

I've seen this with both 2.6.32 and 2.6.39 (Angstrom 2008.1 and 2010.x 
distros, respectively).

Our own board exhibits the same behaviour.  However: configuring the 
MUSB controller in u-boot as a device and only booting as far as u-boot 
before a software reset, the device always appears.  To me this suggests 
a MUSB driver issue in Linux (as opposed to, say, PHY initialization).


I checked with a USB analyzer what happens on the bus: when it doesn't 
show up there is a reset on the bus when we reboot, but it doesn't 
re-enter full speed mode.  No SOFs are sent either.

I did a rudimentary check of the OTG registers in the TPS chip (over 
i2c) but saw nothing out of the ordinary.

I set musb_debug = 5 in musb_core.c, but no errors are reported.

I haven't looked at the MUSB controller registers yet; that's next.


Any ideas?


Thanks,
Orjan

-- 
Orjan Friberg
FlatFrog Laboratories AB
