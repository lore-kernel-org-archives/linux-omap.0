From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 19:06:13 +0000
Message-ID: <201205041906.13959.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205041556.38918.arnd@arndb.de> <4FA40F8E.5010204@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51162 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab2EDTGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:06:21 -0400
In-Reply-To: <4FA40F8E.5010204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>

On Friday 04 May 2012, Jon Hunter wrote:

> > 
> > I believe this is not entirely correct: sometimes the filter_fn is provided
> > by the slave driver, sometimes by the master driver.
> 
> Ok, but in the master case I assume they still use the same API?

The all use dma_request_channel, but the format of the data that gets
passed depends only on whoever provides the filter function, which
is not necessarily the slave or the master, but could be either one.

FWIW, I believe that for each dma engine implementation we only do
one or the other, i.e. if the dmaengine driver provides a filter function,
it is always used with these devices.

> >>
> >>   Next we need to think about how the DMA controller and channels are described
> >>   in the device tree itself. The following device tree node example describes
> >>   the properties of the DMA controller that includes, the register address
> >>   range, number of interrupt supported, number of channels and number of request
> >>   signals. This has been enhanced from the previous versions by adding number of
> >>   channels and number of request signals.
> > 
> > I think you can actually use strings, too, as long as you use a fixed number
> > of cells.
> > 
> > Wouldn't something like this work:?
> > 
> > 	dma-controller1: dma1 {
> > 		compatible = "something-using-strings";
> > 		#dma-cells = <1>;
> > 	};
> > 
> > 	dma-controller2: dma2 {
> > 		compatible = "something-using-integers";
> > 		#dma-cells = <3>
> > 	};
> > 
> > 	some-device {
> > 		compatible = "something";
> > 		dmas = <&dma-controller1>, "some-dma",
> > 			<&dma-controller2 1 2 3>;
> > 	}
> > 
> > The only hard requirement is that the format of the attributes is
> > what the binding specific to that controller understands.
> 
> Yes it could. My point was why do this, if at the end of the day you
> need to resolve the string into a number at some point in the driver?
> However, this may make the migration easier for those using strings.

Well, actually Stephen just clarified that we should not use strings
here :(
We will always have to use numbers then.

> > I think a better interface for the device driver would be something that combines
> > your of_get_dma_channel_info() function with the dma_request_channel() function,
> > like
> > 
> > 	struct dma_chan *of_dma_request_channel(struct device_node *dn, int index);
> > 
> > When we have the device tree, the driver using that channel doesn't actually have
> > to care about the specific of how the channel is defined any more, it just needs
> > to say which one it's interested in, out of the list of channels defined for that
> > device node.
> 
> Yes true. I was trying to avoid any changes to DMA engine itself. Plus
> in the feedback from Stephen his preference was to isolate the binding
> from DMA engine.
> 
> So in your example, is index passed via dma_request_channel()? I assume
> that of_dma_request_channel() get called in the context of
> dma_request_channel somewhere???

What I meant what that you should still provide the existing
dma_request_channel interface without changes, and also provide
of_dma_request_channel as a wrapper around it that does a lookup
in the way that your of_get_dma_channel_info does, passing the
data it gets back from the device tree into the filter function
that was provided by the dma engine driver.

> By the way, have you looked at the pl330_filter() function
> (drivers/dma/pl330.c)? They parse the device-tree in the filter function
> itself. The index could be passed as the filter_param. In this type of
> implementation there would be no need for a generic dma binding.
> However, would only work for devices supporting DMA engine.

IMHO this will have to change, we should not have allowed a nonstandard
binding for pl330 to be used for the samsung platforms and should migrate
to the new binding as soon as possible.

	Arnd
