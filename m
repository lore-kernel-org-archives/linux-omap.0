From: Michael Welling <mwelling@emacinc.com>
Subject: Re: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Mon, 21 Jul 2014 11:38:38 -0500
Message-ID: <20140721163838.GB14362@sysresccd>
References: <20140717234037.GA9660@sysresccd>
 <20140718063806.GK18374@atomide.com>
 <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
 <20140721070913.GN18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61297 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412AbaGUQim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 12:38:42 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so6788171ieb.7
        for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2014 09:38:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140721070913.GN18374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com

On Mon, Jul 21, 2014 at 12:09:13AM -0700, Tony Lindgren wrote:
> * Michael Welling <mwelling@emacinc.com> [140718 07:42]:
> > On Fri, Jul 18, 2014 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hmm maybe double check your're booting device tree based kernel
> > > instead of legacy machine ID based kernel? The legacy booting should
> > > still work just fine and no changes has been made to it, but it will
> > > get removed shortly.
> >
> > I downloaded the version from the test results and it did boot.
> 
> OK that's good to hear.
> 
> > These are combining the uImage and dtb. How do you accomplish this?
> 
> You need to make sure you have the appended DTB support enabled like
> we do in omap2plus_defconfig:
> 
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> 
> Then just cat zImage board.dtb > /tmp/zImage-dtba and run
> mkimage to convert it to a uImage:
> 
> $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 \
> 	-n "Linux" -d /tmp/zImage-dtba /tmp/uImage
> 

I actually discovered this and got LCD video working. Now USB host is
not working. The only thing that registers is the OHCI/EHCI hosts.

root@som3517:~# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Not sure what the problem is. The USB devices that are plugged in are
powered but never detected.

Any hints?

> Regards,
> 
> Tony
