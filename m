From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: USB lockup on OMAP3530
Date: Wed, 10 Feb 2010 18:10:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D1A1@dbde02.ent.ti.com>
References: <f3642e6b1001261430n32d55can502931fc93271f67@mail.gmail.com>
 <4551feaf1001261513vf8ba655ua1c050a28f1d57eb@mail.gmail.com>
 <201001272046.42946.ahartmetz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37367 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914Ab0BJMky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 07:40:54 -0500
In-Reply-To: <201001272046.42946.ahartmetz@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>

> > > 
> > > So far I have tried many versions of the linux-omap and linux-omap-pm
> > > kernel, from about 2.6.30 to the latest git version. They all exhibit
> > > the USB OTG death bug.
> > > I've used kernels with openembedded patches and without, currently
> > > without. Yesterday I discovered the musb_hdrc.fifo_mode parameter and
> > > played around with it. I also modified the given configurations. Result:
> > > - FIFO configurations including .mode = BUF_DOUBLE don't work at all - no
> > >  devices work.
> > > - the USB death bug is not fixed by:
> > >  - using only one endpoint
> > >  - using no TXRX entries but only separate RX and TX
> > >    (every endpoint gets a TX and an RX entry though)
> > >  - using a large number of endpoints with same maxpacket value
> > > ... still no solution.
> > > 
> > > Enabling debug output of the musb_hdrc driver (yes I've also compiled in
> > > debug messages) is not very practical due to the high volume of
> > > messages; also, when the bug occurs nothing special is printed. The
> > > first error usually comes from the memory manager / filesystem
> > > complaining that it can't do "IO to offline device", i.e. the
> > > disappeared external harddisk (which contains the swapfile).
> > > 
> > > I would *really* appreciate somebody looking into this because this
> > > currently makes the hardware as useful as a brick for me. I can supply
> > > debug output and test patches.

Would you care to try these two patches please?

http://marc.info/?l=linux-usb&m=125957336716915&w=2

And

The dependency patch:
http://marc.info/?l=linux-usb&m=125879861004131&w=2


Let me know if these fix the bug for you.

- Anand
