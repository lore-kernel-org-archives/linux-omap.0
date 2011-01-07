From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 18:39:06 +0530
Message-ID: <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com>
 <20110106195225.GX7771@atomide.com> <20110106203431.GZ7771@atomide.com>
 <20110106205107.GI1198@n2100.arm.linux.org.uk> <20110106235203.GA14425@n2100.arm.linux.org.uk>
 <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com> <20110107092800.GJ1198@n2100.arm.linux.org.uk>
 <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
 <20110107125132.GM1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:54981 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751534Ab1AGNJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:09:07 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so16716439fxm.35
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:09:07 -0800 (PST)
In-Reply-To: <20110107125132.GM1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, January 07, 2011 6:22 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure
>
> On Fri, Jan 07, 2011 at 05:48:41PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > > Sent: Friday, January 07, 2011 3:23 PM
> > Ruessell,
> >
> >
> > > To: Russell King - ARM Linux
> > > Cc: linux-omap@vger.kernel.org; Tony Lindgren
> > > Subject: RE: 4430SDP boot failure
> > >
> >
> > [....]
> >
> > > > BTW, if it makes any difference to the boot loader, please
> note
> > > that
> > > > I'm
> > > > still waiting for the upgrade for the SDP board.
> > > That means your board is with ES1.0. I shall try 2.6.37 on
> > > ES1.0
> >
> > ES1.0 boot nicely on 2.6.37 and I guess I know why you are seeing
> an
> > issue. The console is changed to OMAP serial driver from 8250
> > driver.
> >
> > Can you try "console=ttyO2" instead of existing ""console=ttyS2"
> ??
>
> This is the command line I've been giving it:
>
> setenv bootargs 'root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G
> console=ttyO2,115200n8 rootdelay=2'
>
> and in my .config, I have:
>
> CONFIG_SERIAL_OMAP=y
> CONFIG_SERIAL_OMAP_CONSOLE=y
>
Yep. Noticed that after the post.

> so the driver is also enabled.  I found this on the 3430LDP, and so
> switched both OMAP3 and OMAP4 stuff over to the new driver.
>
> That wouldn't explain why I'm getting the "X-loader hangs" message
> which brings everything to a halt, and why the low level debug stuff
> doesn't work.

Have sent you latest bootloaders and full bootlog on my ES1.0
OMAP4430SDP. 2.6.37 just boots fine for me.

Low level debug as you reported seems to be broken though.

Regards,
Santosh
