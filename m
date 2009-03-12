From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
 reloading dspbridge several times due to a memory leak.)
Date: Thu, 12 Mar 2009 11:58:14 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51DF75@dlee02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287CA6EC4@dlee06.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0CFF51DF41@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52033 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbZCLQ61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 12:58:27 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Ameya Palande <ameya.palande@nokia.com>

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Thursday, March 12, 2009 6:53 PM
> To: Menon, Nishanth; Guzman Lugo, Fernando; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Woodruff, Richard; Lakhani, Amish; Gupta, Ramesh;
> Ameya Palande
> Subject: RE: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
> reloading dspbridge several times due to a memory leak.)
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> > Sent: Thursday, March 12, 2009 6:40 PM
> > To: Guzman Lugo, Fernando; linux-omap@vger.kernel.org
> > Cc: Kanigeri, Hari; Woodruff, Richard; Lakhani, Amish; Gupta, Ramesh;
> > Ameya Palande
> > Subject: ioremap bug? (was RE: DSPBRIDGE: segmentation fault after
> > reloading dspbridge several times due to a memory leak.)
> > > console output where you can see the address increasing.
> >
> > I duplicated this with the following dummy driver which ioremaps as per
> > the same allocations that the bridge driver would have done:
> >
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> > #include <linux/slab.h>
> > #include <linux/mm.h>
> > #include <linux/dma-mapping.h>
> >
> > #define BASE 0x87000000
> > #define SIZE 0x600000
> >
> Just an update (thanks to Fernando in pointing this out)
> 0x87000000, 0x600000, fails with same error
> 0x88000000, 0x600000, fails with same error
Wrong attempt!!
Should have tried:
0x87100000, 0x600000 - this worked
> 0x87000000, 0x700000 - went thru 300 odd iterations without error!!
This means that if I keep end address constant, it is fine.. with this hypothesis, I tried
0x87200000, 0x500000 - this also worked

Implying the start address and size of the first allocation in my dummy driver did not have a factor in the test failure, but just the end address of the ioremap!

Regards,
Nishanth Menon
