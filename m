From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] of: DMA helpers: manage generic requests
	specification
Date: Mon, 5 Mar 2012 19:57:54 +0000
Message-ID: <20120305195754.GA20359@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com> <74CDBE0F657A3D45AFBB94109FB122FF17BDDF217B@HQMAIL01.nvidia.com> <4F54BC2E.3040702@ti.com> <74CDBE0F657A3D45AFBB94109FB122FF17BE861C6E@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41996 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560Ab2CET6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:58:34 -0500
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C6E@HQMAIL01.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>

On Mon, Mar 05, 2012 at 10:30:43AM -0800, Stephen Warren wrote:
> Cousson, Benoit wrote at Monday, March 05, 2012 6:14 AM:
> > Beside u32 and string, do we know what kind of parameters we can expect
> > to retrieve?
> > Because we can potentially reduce the scope to these two types only.
> 
> I wondered whether different drivers would return arbitrary driver-specific
> structs, so that the DT specific would encode not only the DMA request
> number, but perhaps some/all of the DMA parameters like transfer size,
> wrap, even DMA FIFO address, ...

Right.  The thing to consider here is: what information does the driver
already have about the device?

- physical address of the data register
- size of the data register
- it certainly should know the fifo depth (think - if it has to do PIO
  then it needs this information already.)

so, there's no point putting that information into DT because it must be
known by the driver for systems not using DMA.

We have a standardized way to pass this information to DMA engine drivers
from the peripheral device driver: struct dma_slave_config.

What is outside of the scope of the driver is knowing how a peripheral
device is connected to a set of DMA engines.  That's a much harder
problem to solve because there's many varied ways to do that in hardware,
from a static mapping between the peripheral and a DMA engine request
signal, to implementations which have some kind of front end MUX, to
there being several choices of DMA engine for the peripheral (I believe
some Samsung platforms fall into this category.)

Some of those problems can be solved by redesigning the DMA engine
drivers to have a clear way to handle DMA engines with multiple request
inputs shared between multiple channels: you treat the individual request
inputs as separate DMA engine channels, and when there is work to be
done, you allocate the DMA engine channel to a physical DMA engine and
physical channel.

That's not going to be easy to do at the moment, because every DMA
engine driver is custom written from the ground up with no commonality
between them (I've mentioned this in previous email threads.)

I think, before trying to design some kind of DT based representation
of how to bind DMA stuff to peripheral drivers, the very first thing
that needs to happen is the DMA engine drivers need sorting so that
they all work in mostly the same way in terms of how channels are
allocated to peripherals.  Only once we have a consistent way that's
done can we then start looking at what kind of representation is needed
to bind the two together.

Otherwise, we're going to end up with the OMAP way of binding channels,
the PL08x way, the SA11x0 way, etc and its going to become very very
unfunny to sort this out later.
