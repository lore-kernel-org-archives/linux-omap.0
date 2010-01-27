From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: USB lockup on OMAP3530
Date: Wed, 27 Jan 2010 20:46:42 +0100
Message-ID: <201001272046.42946.ahartmetz@gmail.com>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com> <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41471 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0A0Tqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 14:46:48 -0500
Received: by bwz19 with SMTP id 19so5096518bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 27 Jan 2010 11:46:46 -0800 (PST)
In-Reply-To: <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 27 January 2010 00:13:48 Robert Nelson wrote:
> On Tue, Jan 26, 2010 at 4:30 PM, Andreas Hartmetz <ahartmetz@gmail.com> 
wrote:
> > Hi,
> > 
> > I have a problem with the USB OTG port on my Beagle Board revision B6 -
> > the OTG port is the only USB port on that device so it's critical that
> > it works. Everybody on this list probably knows this hardware, I'll just
> > say that it has an ARM Cortex-A8 CPU (OMAP3530) with a built-in USB
> > interface. The driver is musb_hdrc.
> > I'm using this interface in host mode (no gadget mode support compiled
> > in, though this doesn't seem to make a difference) to attach necessary
> > peripherals via a powered USB hub. The make and model of hub do not play
> > a role, I've tried several.
> > 
> > The problem:
> > Whenever the following conditions are met all hardware on the port
> > "disappears" after a few minutes, cutting off the board from network and
> > storage: - Network traffic over USB (doesn't matter if it's regular 100
> > Mbps Ethernet or a WLAN stick)
> > - Disk "traffic" over USB - I use a 2,5" disk in a USB enclosure
> > - CPU load - not sure if this is necessary
> > The only fix seems to be a reboot.
> > 
> > This happens to me when compiling something on the board (easier than
> > cross-compiling) with the help of Icecream, which is a kind of distcc on
> > steroids. On #beagle on Freenode IRC I've found somebody with the same
> > problem when scp-ing a large file (several hundred megabytes) off or
> > onto the USB disk. I can reproduce that as well.
> > I have spent a lot of time trying to find fixes and/or workarounds but
> > nothing worked so far except using the "validation kernel" recommended
> > to test the hardware e.g. after receipt:
> > http://code.google.com/p/beagleboard/wiki/BeagleBoardDiagnostics.
> > Fittingly, the link to the kernel image is currently broken. The board
> > usually locked itself up after about a day when using that ancient
> > kernel, so it's not an option either, and probably quite unmaintained
> > and buggy in many other areas.
> > 
> > So far I have tried many versions of the linux-omap and linux-omap-pm
> > kernel, from about 2.6.30 to the latest git version. They all exhibit
> > the USB OTG death bug.
> > I've used kernels with openembedded patches and without, currently
> > without. Yesterday I discovered the musb_hdrc.fifo_mode parameter and
> > played around with it. I also modified the given configurations. Result:
> > - FIFO configurations including .mode = BUF_DOUBLE don't work at all - no
> >  devices work.
> > - the USB death bug is not fixed by:
> >  - using only one endpoint
> >  - using no TXRX entries but only separate RX and TX
> >    (every endpoint gets a TX and an RX entry though)
> >  - using a large number of endpoints with same maxpacket value
> > ... still no solution.
> > 
> > Enabling debug output of the musb_hdrc driver (yes I've also compiled in
> > debug messages) is not very practical due to the high volume of
> > messages; also, when the bug occurs nothing special is printed. The
> > first error usually comes from the memory manager / filesystem
> > complaining that it can't do "IO to offline device", i.e. the
> > disappeared external harddisk (which contains the swapfile).
> > 
> > I would *really* appreciate somebody looking into this because this
> > currently makes the hardware as useful as a brick for me. I can supply
> > debug output and test patches.
> > 
> > Cheers,
> > Andreas
> 
> Hi Andreas,
> 
> Give this patch a try:
> http://bazaar.launchpad.net/~beagleboard-kernel/%2Bjunk/2.6-stable/annotate
> /head%3A/patches/musb/fifo-change.patch
> 
> It's in Angstrom's 2.6.29, my 2.6.31/32... And a real fix just went
> into mainline 2.6.33-rc5, with it my otg port is solid as a rock and
> can transfer large amounts of data between shared devices on the
> otg/musb port...
> 
> http://rcn-ee.homeip.net:81/dl/farm/log/2.6.32.6-x6.0_beagle-128mb-0_musb-s
> tress-test.txt
> 
> Regards,

Nice try, but no success.

I've tried the fifo-change patch against the pm branch (with 
musb_hdrc.fifo_mode=4 obviously, otherwise it wouldn't do anything) and also 
the 2.6.32.6-x6.0 kernel from you. Nothing is fixed for me. With your kernel I 
have an additional problem I don't have with pm: it takes several tries to 
bring up the USB WLAN interface to a working state, with the rt73usb driver.
Basically I start and kill wpa_supplicant, unload the module a few times and 
whatnot until it works. DHCP seems to work almost every time but no IP or ICMP 
packets come through. I know it sounds strange.
When it works ping response times range from one to ten seconds (?!) whereas 
they are in the several milliseconds range with pm.
I tried your latest kernel with and without musb_hdrc.fifo_mode=4 to be sure.
Which fix in mainline do you mean btw?
As long as no particular commit fixes the bug I consider it fixed by accident, 
and it may break again by accident.
I suspect that your stress test is not stressful enough. Try scp or anything 
that loads the CPU heavily while network and disk I/O is going on.
Maybe throw in some swapping with swap on the external disk for good measure, 
git gc seems to work well for that.
If all else fails I can publish a filesystem image with a distributed build 
ready to run.

Andreas
