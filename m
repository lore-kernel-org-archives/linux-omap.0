From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Wed, 4 Jul 2012 11:47:35 +0000
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9C1B55@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
 <20120704094140.GB16639@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49132 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2GDLrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 07:47:49 -0400
In-Reply-To: <20120704094140.GB16639@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Wednesday, July 04, 2012 3:12 PM
> To: N, Mugunthan V
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
> 
> On Thu, Jun 07, 2012 at 04:22:17PM +0000, N, Mugunthan V wrote:
> > While converting platform device registry to Hwmod for CPSW Ethernet
> > driver which is present in AM335X (OMAP2+), I am not finding a way
> > to specify dma_mask and coherent_dma_mask.
> > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
> 
> Just remember that we're moving stuff to DMA engine, and that means
> the sDMA device has DMA masks, but none of the peripherals which make
> use of sDMA should have DMA masks set.
> 
> The reason for this is because the device responsible for accessing
> memory is sDMA, not the peripheral device, and therefore any memory
> properties for DMA should come from the sDMA device, not the peripheral
> device.

I agree that properties of DMA should come from sDMA device. In my case 
(CPSW Ethernet) has a peripheral DMA (davinci_cpdma) which takes care of 
transferring packet from memory to Ethernet IP and vice versa.

For allocating DMA memory space for davinci_cpdma, dma_alloc_coherent is 
used which requires dma_masks to be specified for the device.

To pass the dma_masks to the device following ways can be followed.
1. Extend omap_device_build arguments to hold dma_mask and coherent_dma_mask
   which will affect all other devices which uses omap_device_build api.
2. Hardcode the dma_mask and coherent_dma_mask in omap_device_build with 
   0xffffffff which can harm other devices
3. Specify the dma_mask and coherent_dma_mask after creating the device as
   done in musb device.
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/a
rm/mach-omap2/usb-musb.c;h=c4a576856661014ea3bec9acc70f80e32d62c33b;hb=HEAD

Regards,
Mugunthan V N
