From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 17 Jul 2012 19:24:33 +0000
Message-ID: <201207171924.33756.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64925 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab2GQTZH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 15:25:07 -0400
In-Reply-To: <1342161907.1726.26.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Friday 13 July 2012, Vinod Koul wrote:
> > Do you mean there must be a global table, or are you ok with putting
> > the information about a channel into the device that uses the channel,
> > as we do for most other subsystems (IRQ, GPIO, pinctrl, ...).
> > If not, what is the problem with that approach?
> 
> Today, we simple ask, "give me dma channel with DMA_SLAVE capability".
> 
> If we change it to "give me dma channel which suits my need" and have
> additional information in dmaengine to handle this request effectively.
> 
> What that would mean is
> a) DMA channel either knows which channel to provide, Or
> b) Additional arguments provided to dmaengine API to help it find out
> which channel to provide.
> 
> It would be good to have client ask for a specific channel. But in order
> to build generic clients, we face a problem that clients may not know
> how they mapped to dmac by SoC designer. Or the mux maybe entirely
> flexible on which channel.
> 
> If we add this as DT property (which I assume should be platform
> specific), then client will know which channel to request.
> It can have two levels, dmac and channel. In case mux is flexible enough
> then client gets a channel and program the mux for this mapping.
> 
> I think this is the most simplistic solution I have for this, thoughts?

I think we're basically on the same page. Let's see if I have covered
all the cases we discussed so far. I've tried to update the binding that
Jon sent out initially with everything we've discussed, so please review
this to see if I understood you correctly.

	Arnd


* Generic DMA Controller and DMA request bindings

Generic binding to provide a way for a driver using DMA Engine to retrieve the
DMA request or channel information that goes from a hardware device to a DMA
controller.

* DMA controller

Required property:
    - #dma-cells: Number elements to describe DMA channel information. Must be
                  at least 2, allowing a phandle and a flags cell, but usually
		  is larger so a client can also specify a request or channel
                  number and/or some configuration.

Optional properties:
    - #dma-channels: Number of DMA channels supported by the controller.
    - #dma-requests: Number of DMA requests signals supported by the controller.

Example:

       sdma: dmaengine@48000000 {
               compatible = "ti,omap4-sdma"
               reg = <0x48000000 0x1000>;
               interrupts = <4>;
               #dma-cells = <3>;
               #dma-channels = <32>;
               #dma-requests = <127>;
       };


* DMA client

Client drivers should specify the DMA property using a phandle to the controller
followed by the number of DMA request/channel and the transfer type of the
channel (eg. device-to-memory, memory-to-device, memory-to-memory, etc).

Required property:
    dmas: list of one or more dma specifiers, each consisting of
     - phandle pointing to dma controller node
     - flags word, a bit map that can hold these flags
       * 0x00000001 channel can be used for transfer from device
       * 0x00000002 channel can be user for transfer to device
     - zero or more cells in a format specific to the the dma controller
       node listed in the phandle. This typically contains a dma request
       line number or a channel number, but can contain any data that
       is used required for configuring a channel.

Optional property:
    dma-names: when present, this shall contain one identifier string
    for each dma specifier in the dmas property. The specific strings
    that can be used are defined in the binding of the DMA client
    device. When multiple dma specifiers can be used as alternatives,
    the dma-names for those dma specifiers must be identical.

Any dma specifiers that have identical flags and identical dma-names
(if present) shall refer to different dma controllers that can be
used as alternatives, e.g. when a request line is connected to
multiple dma controllers. If multiple dma specifiers are listed that
have the same flags but refer to different functional channels,
the dma-names property must be used to distinguish them.

Examples:

1. One DMA write channel, one DMA read/write channel:

       i2c1: i2c@1 {
               ...
               dmas = <&sdma 2 1 &sdma 3 2>;
               ...
       };

2. A single read-write channel with two alternative dma controllers
   providing it:

	dmas = <&dma0 3 5
		&dma1 3 7
		&dma2 3 2>;

3. A device with three channels, one of which has two alternatives:

	dmas = <&dma0 1 4 /* data read */
		&dma0 2 6 /* data write */
		&dma1 1 0 /* error read */
		&dma2 1 0>; /* alternative error read */
	dma-names = "data", "data", "error", "error";

4. A dma controller requiring complex configuration:

       dma: dmaengine@48000000 {
               compatible = "foo,foo-sdma"
               reg = <0x48000000 0x1000>;
               interrupts = <4>;
               #dma-cells = <6>; /* phandle, flag, request, channel,
					 input-width, output-width */
               #dma-channels = <32>;
               #dma-requests = <127>;
       };

       mmc@49000000 {
		...
		dmas = <&dma 1	/* read */
			2	/* request line */
			5       /* channel */
			16	/* 16 bit bus width on read */
			8>	/* 8 bit bus width on write */
		       <&dma 2	/* write */
			3	/* request line */
			6       /* channel */
			8	/* 8 bit bus width on read */
			16>	/* 16 bit bus width on write */
