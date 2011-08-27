From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Sat, 27 Aug 2011 15:47:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108271444240.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box> <201108261258.32880.arnd@arndb.de> <20110826130644.GN2308@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1H0Vr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 17:47:56 -0400
In-Reply-To: <20110826130644.GN2308@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 26 Aug 2011, David Gibson wrote:

> static struct of_device_id foodevice_of_match[] __devinitdata = {
> 	{ .compatible = "foocorp,foodevice1234",
> 	  .resource_names = {"base_regs", "extra_regs", }, },
> 	{ .compatible = "foocorp,foodevice1239",
> 	  .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
> 	{ },
> };

This preserves platform_device_get_byname(), which is good.  It also 
facilitates debugging: like naming resources in the device tree data, it 
provides something human-readable to output to /proc/iomem and similar 
mechanisms.

But it doesn't resolve the problem on the DT generation side.

When someone at a hardware vendor writes the DT generator code, they'll 
have to implement a similar table to yours for each IP block with multiple 
resources of the same type.

IP blocks with multiple resources of the same type are not isolated cases.  
For example, of the 82 IP block instances on the OMAP4 that have hwmod 
data currently upstream (a subset of what's actually on the chip), at 
least 68 of them (83%) have multiple resources of the same type[1][2].

Certainly, from a kernel development perspective, one can decide to just 
dump this kind of DT generation problem back on the hardware vendors.  
But it seems more efficient and less error-prone to simply remove both 
mapping tables, and to export names directly from the IP block data into 
the device data format.


- Paul

1. The number is actually higher than this.  This count doesn't
   include IP blocks with multiple address ranges on different 
   interconnects.

2. Data from arch/arm/mach-omap2/omap_hwmod_44xx_data.c, as of Linux 
   v3.1-rc3.
   Available from http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod_44xx_data.c;h=6201422c0606b5103c01e563f67060134658774d;hb=HEAD
