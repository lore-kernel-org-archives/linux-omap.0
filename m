From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Fri, 8 Jun 2012 07:28:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206080722040.14977@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk> <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com> <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com> <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com> <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com> <4FD09EFA.20304@ti.com> <alpine.DEB.2.00.1206071657160.14977@utopia.booyaka.com> <4FD1FA8C.1080600@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42644 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2FHN2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 09:28:52 -0400
In-Reply-To: <4FD1FA8C.1080600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Fri, 8 Jun 2012, Cousson, Benoit wrote:

> On 6/8/2012 3:11 AM, Paul Walmsley wrote:
> > On Thu, 7 Jun 2012, Cousson, Benoit wrote:
> > 
> > > Indeed, what I did not mention is that potentially the whole device 
> > > init should be done ondemand as well. Meaning the whole hwmod setup 
> > > phase should be done only when the driver will probe the device.
> > 
> > That means if no driver exists for an IP block, or if the driver isn't
> > using PM runtime, the IP block won't be reset.  And somehow we still are
> > missing drivers in mainline.  We also still have drivers that aren't yet
> > PM runtime converted.
> 
> No the point is still the same as before. You let the drivers do the job if
> they are there, and then do a pass at very late time during the boot process
> to handle the ones that were not probed by any driver.

Ah, I see what you mean.  Above you wrote that the the hwmod setup phase 
would be done only when the driver will probe the device.  But you also 
mean that it should also be done for the remaining devices before starting 
userspace.

> At least you will avoid the enable -> reset -> idle -> enable sequence 
> we are doing right now for most of the active drivers when it is not 
> necessary.

It must not be widely known, but early reset was implemented 
intentionally.  The goal was to keep any configuration damage from 
out-of-date or broken bootloaders or previous OSes to a minimum length of 
time during the boot process.

I don't really have a huge problem with switching to a late reset, 
but there are disadvantages to it.


- Paul
