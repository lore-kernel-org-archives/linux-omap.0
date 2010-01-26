From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: USB lockup on OMAP3530
Date: Tue, 26 Jan 2010 23:30:54 +0100
Message-ID: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:41715 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab0AZWa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 17:30:56 -0500
Received: by fxm20 with SMTP id 20so946531fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 26 Jan 2010 14:30:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have a problem with the USB OTG port on my Beagle Board revision B6 - the OTG
port is the only USB port on that device so it's critical that it works.
Everybody on this list probably knows this hardware, I'll just say that it has
an ARM Cortex-A8 CPU (OMAP3530) with a built-in USB interface. The driver is
musb_hdrc.
I'm using this interface in host mode (no gadget mode support compiled in,
though this doesn't seem to make a difference) to attach necessary peripherals
via a powered USB hub. The make and model of hub do not play a role, I've tried
several.

The problem:
Whenever the following conditions are met all hardware on the port "disappears"
after a few minutes, cutting off the board from network and storage:
- Network traffic over USB (doesn't matter if it's regular 100 Mbps Ethernet
  or a WLAN stick)
- Disk "traffic" over USB - I use a 2,5" disk in a USB enclosure
- CPU load - not sure if this is necessary
The only fix seems to be a reboot.

This happens to me when compiling something on the board (easier than
cross-compiling) with the help of Icecream, which is a kind of distcc on
steroids. On #beagle on Freenode IRC I've found somebody with the same problem
when scp-ing a large file (several hundred megabytes) off or onto the USB disk.
I can reproduce that as well.
I have spent a lot of time trying to find fixes and/or workarounds but nothing
worked so far except using the "validation kernel" recommended to test the
hardware e.g. after receipt:
http://code.google.com/p/beagleboard/wiki/BeagleBoardDiagnostics.
Fittingly, the link to the kernel image is currently broken. The board usually
locked itself up after about a day when using that ancient kernel, so it's not
an option either, and probably quite unmaintained and buggy in many other areas.

So far I have tried many versions of the linux-omap and linux-omap-pm kernel,
from about 2.6.30 to the latest git version. They all exhibit the USB OTG death
bug.
I've used kernels with openembedded patches and without, currently without.
Yesterday I discovered the musb_hdrc.fifo_mode parameter and played around
with it. I also modified the given configurations. Result:
- FIFO configurations including .mode = BUF_DOUBLE don't work at all - no
  devices work.
- the USB death bug is not fixed by:
  - using only one endpoint
  - using no TXRX entries but only separate RX and TX
    (every endpoint gets a TX and an RX entry though)
  - using a large number of endpoints with same maxpacket value
... still no solution.

Enabling debug output of the musb_hdrc driver (yes I've also compiled in debug
messages) is not very practical due to the high volume of messages; also, when
the bug occurs nothing special is printed. The first error usually comes from
the memory manager / filesystem complaining that it can't do "IO to offline
device", i.e. the disappeared external harddisk (which contains the swapfile).

I would *really* appreciate somebody looking into this because this currently
makes the hardware as useful as a brick for me. I can supply debug output and
test patches.

Cheers,
Andreas
