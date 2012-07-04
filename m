From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Wed, 4 Jul 2012 14:25:30 +0100
Message-ID: <20120704132530.GA20496@n2100.arm.linux.org.uk>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com> <20120704094140.GB16639@n2100.arm.linux.org.uk> <EB1619762EAF8B4E97A227FB77B7E0293E9C1B55@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37864 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab2GDNZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 09:25:40 -0400
Content-Disposition: inline
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9C1B55@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 04, 2012 at 11:47:35AM +0000, N, Mugunthan V wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Wednesday, July 04, 2012 3:12 PM
> > To: N, Mugunthan V
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
> > 
> > On Thu, Jun 07, 2012 at 04:22:17PM +0000, N, Mugunthan V wrote:
> > > While converting platform device registry to Hwmod for CPSW Ethernet
> > > driver which is present in AM335X (OMAP2+), I am not finding a way
> > > to specify dma_mask and coherent_dma_mask.
> > > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
> > 
> > Just remember that we're moving stuff to DMA engine, and that means
> > the sDMA device has DMA masks, but none of the peripherals which make
> > use of sDMA should have DMA masks set.
> > 
> > The reason for this is because the device responsible for accessing
> > memory is sDMA, not the peripheral device, and therefore any memory
> > properties for DMA should come from the sDMA device, not the peripheral
> > device.
> 
> I agree that properties of DMA should come from sDMA device. In my case 
> (CPSW Ethernet) has a peripheral DMA (davinci_cpdma) which takes care of 
> transferring packet from memory to Ethernet IP and vice versa.

Right, so you have two devices here.

You have the Ethernet device, and you have the cpdma device.  The cpdma
device is the device actually performing the memory accesses on behalf
of the Ethernet device.

> For allocating DMA memory space for davinci_cpdma, dma_alloc_coherent is 
> used which requires dma_masks to be specified for the device.

So, memory which you allocate for DMA purposes should use the struct
device associated with the cpdma device, not the struct device associated
with the Ethernet device.

That becomes possible when DMA implementations are converted to use the
DMA engine API, and with proper channel virtualization, device drivers
can retain their virtual channel handle (and therefore access to the
DMA engine struct device) indefinitely.
