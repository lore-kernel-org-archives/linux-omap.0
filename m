From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Tue, 5 Oct 2010 10:07:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA07@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3C6@dbde02.ent.ti.com>
 <20101004065624.GD2559@legolas.emea.dhcp.ti.com>
 <20101004070040.GE2559@legolas.emea.dhcp.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE4D9@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010041327040.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46651 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab0JEEiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 00:38:03 -0400
In-Reply-To: <alpine.DEB.2.00.1010041327040.13816@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, October 05, 2010 1:02 AM
> To: Shilimkar, Santosh
> Cc: Balbi, Felipe; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
> 
> On Mon, 4 Oct 2010, Shilimkar, Santosh wrote:
> 
> > > -----Original Message-----
> > > From: Balbi, Felipe
> > > Sent: Monday, October 04, 2010 12:31 PM
> > >
> > > On Mon, Oct 04, 2010 at 01:56:24AM -0500, Balbi, Felipe wrote:
> > > >
> > > >I still have that sitting on my gitorious tree. The patch is attached
> > > >to this mail. I compile tested (only) for omap3_defconfig, it
> probably
> > > >needs to start using pm_runtime functions at some point and probably
> > > >move to drivers/clocksource instead of arch/arm/plat-omap.
> > > >
> > > >patch is also available at [1]
> > > >
> > > >[1] git://gitorious.org/usb/usb.git clksource
> > >
> > > I made a few changes to make checkpatch.pl --strict happy. Attached
> > >
> > Good !!
> > This patch addresses splitting as well as multi-omap builds and probably
> > also a better candidate in case we need to convert sync timer to hwmod
> > driver.
> >
> > Paul, what's your take?
> 
> It's great that this is getting cleaned up but it's too late for 2.6.37.
> We stop taking new code after -rc6 comes out so we can try to get all of
> the changes integrated with each other and fix any bugs.
>
The patch was lying on the list for quite some time but didn't get much
attention before.
 
> The best thing for you and Felipe to do is to convert the driver to use
> hwmod data and pm_runtime and test on more platforms, then post it to the
> list after 2.6.37 comes out.
Probably this make sense.  

Regards,
Santosh
