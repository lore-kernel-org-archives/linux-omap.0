From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Sun, 10 Jun 2012 23:15:47 -0700
Message-ID: <20120611061546.GQ12766@atomide.com>
References: <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com>
 <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com>
 <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
 <4FD09EFA.20304@ti.com>
 <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com>
 <4FD1FA8C.1080600@ti.com>
 <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46752 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab2FKGPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 02:15:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

* Paul Walmsley <paul@pwsan.com> [120608 06:33]:
> On Fri, 8 Jun 2012, Cousson, Benoit wrote:
> 
> > On 6/8/2012 3:11 AM, Paul Walmsley wrote:
> > > On Thu, 7 Jun 2012, Cousson, Benoit wrote:
> > > 
> > > > Indeed, what I did not mention is that potentially the whole device 
> > > > init should be done ondemand as well. Meaning the whole hwmod setup 
> > > > phase should be done only when the driver will probe the device.
> > > 
> > > That means if no driver exists for an IP block, or if the driver isn't
> > > using PM runtime, the IP block won't be reset.  And somehow we still are
> > > missing drivers in mainline.  We also still have drivers that aren't yet
> > > PM runtime converted.
> > 
> > No the point is still the same as before. You let the drivers do the job if
> > they are there, and then do a pass at very late time during the boot process
> > to handle the ones that were not probed by any driver.
> 
> Ah, I see what you mean.  Above you wrote that the the hwmod setup phase 
> would be done only when the driver will probe the device.  But you also 
> mean that it should also be done for the remaining devices before starting 
> userspace.
> 
> > At least you will avoid the enable -> reset -> idle -> enable sequence 
> > we are doing right now for most of the active drivers when it is not 
> > necessary.
> 
> It must not be widely known, but early reset was implemented 
> intentionally.  The goal was to keep any configuration damage from 
> out-of-date or broken bootloaders or previous OSes to a minimum length of 
> time during the boot process.

These devices should get reset as the device drivers initialize. Some parts
of course need to be initialized properly early like caches and DMA controller.
 
> I don't really have a huge problem with switching to a late reset, 
> but there are disadvantages to it.

I think the early reset actually has more disadvantages to it compared
to driver reset. We don't see any errors when things go wrong, and we
may even kill the only debug console in the reset process.

We are already doing what Benoit describes with clocks where we only
reset the unclaimed ones at late_initcall level, and that has proven
to work well.

Regards,

Tony
