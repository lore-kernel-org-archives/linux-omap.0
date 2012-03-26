From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Suspend broken on 3.3?
Date: Mon, 26 Mar 2012 14:41:15 +0100
Message-ID: <WC20120326134115.9815DF@terrafix.co.uk>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:60939 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932444Ab2CZNld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 09:41:33 -0400
In-Reply-To: <87r4wka6bf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

-----Original Message-----
From: Kevin Hilman <khilman@ti.com>
To: "Joe Woodward" <jw@terrafix.co.uk>
Cc: "linux-omap\@vger.kernel.org" <linux-omap@vger.kernel.org>
Date: Thu, 22 Mar 2012 10:33:56 -0700
Subject: Re: Suspend broken on 3.3?

> "Joe Woodward" <jw@terrafix.co.uk> writes:
> 
> > Is system suspend broken on stock 3.3?
> 
> I hope not. :)
> 
> It *should* work, I'm using it regularily here, and "it works for me"
> (I'm sure that's just what you want to hear.)  :)
> 
> > I have a working stock 3.2 (with patches to fix runtime_pm for DSS2),
> and system suspend works just fine!
> >
> > This is running on a variety of GUMSTIX boards (both OMAP3530 and
> AM3703-based).
> 
> I currently only have a 3530-based Gumstix Overo (although a
> AM3xxx-based one is on the way, thanks Gumstix!), but it's working fine
> for me on my Overo.
> 
> Stock v3.3 won't boot on Overo because of the smsc911x regulator issues
> recently discusssed, so if you're using Overo, you also need the patch
> in Tony's fix-smsc911x-regulator branch.
> 
> After that, suspend/resume is working fine for me using
> omap2plus_defconfig.  I tried both with initramfs and with MMC rootfs.
> 
> Can you try without your board file changes, using vanilla v3.3 +
> smsc911x fix above and using omap2plus_defconfig?
> 
> Also, please share the kernel command-line you're using.

Right, I've stepped back a bit and dug out a GUSMTIX Palo43 carrier board on which to test the Overo OMAP3530 COM and I've found:
 - Running a stock 3.3 (with absolutely no changes) does indeed suspend correctly.
 - Running the 3.3 kernel with my (minor) board modifications (basically defining some buttons) suspends correctly as well.

Then I went back to my original board and the 3.3 still wakes up from suspend immediately. So I had a think, and the only real differences 
between my board the the GUMSTIX Palo43 board is that I am using multiple UARTs.

Up to this point I've only wanted to wake on the console (ttyO2), and not any other UARTs so I've stopped them waking with:
  echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wakeup
  echo disabled > /sys/devices/platform/omap/omap_uart.1/power/wakeup

I wanted to check that this still worked, so tried disabling wakeup on the console (ttyO2):
  echo disabled > /sys/devices/platform/omap/omap_uart.2/power/wakeup

And if I do "echo mem > /sys/power/state" I was expecting to stay in suspend when I typed on my keyboard... However, the kernel still 
woke from suspend, which leads me to believe that the UART wakeup hasn't been disabled?

Could you test if this is also the case your end?

Cheers,
Joe

> Thanks,
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


