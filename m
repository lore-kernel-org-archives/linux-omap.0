From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 15:20:59 +0000
Message-ID: <20120319152059.GE16389@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <20120317094059.7C2333E08E2@localhost> <201203182013.22790.arnd@arndb.de> <4F6736B4.4090509@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab2CSPVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 11:21:34 -0400
Content-Disposition: inline
In-Reply-To: <4F6736B4.4090509@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>

On Mon, Mar 19, 2012 at 02:37:56PM +0100, Nicolas Ferre wrote:
> On 03/18/2012 09:13 PM, Arnd Bergmann :
> > On Saturday 17 March 2012, Grant Likely wrote:
> >>> +static LIST_HEAD(of_dma_list);
> >>> +
> >>> +struct of_dma {
> >>> +     struct list_head of_dma_controllers;
> >>> +     struct device_node *of_node;
> >>> +     int of_dma_n_cells;
> >>> +     int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
> >>> +};
> >>
> >> This _xlate is nearly useless as a generic API.  It solves the problem for
> >> the specific case where the driver is hard-coded to know which DMA engine
> >> to talk to, but since the returned data doesn't provide any context, it
> >> isn't useful if there are multiple DMA controllers to choose from.
> >>
> >> The void *data pointer must be replaced with a typed structure so that
> >> context can be returned.
> > 
> > I've read up a bit more on how the existing drivers use the filter
> > functions, it seems there are multiple classes of them, the classes
> > that I've encountered are:
> > 
> > 1. matches on chan->device pointer and/or chan_id
> 
> I have the impression that we are now talking about *channel* selection.
> It is not the purpose of those helper functions. It is just to retrieve
> a *request line* for a particular slave interface.

The request line on what though?  The DMA controller, or something
else?

The reason I ask is because on ARM boards, the DMA controller has N
request lines.  Three of those request lines are multiplexed in an
external FPGA to select between N different peripherals.

For example, the UART and MMCI may be routed to the FPGA multiplexer,
and either could be routed to DMA controller request signal 0, 1, or 2,
whereas a different UART might be routed directly to DMA controller
request signal 3 and 4.

At the moment, we handle this via platform data and callbacks passed
into the PL080 DMA driver, by matching virtual DMA channels based upon
strings looked up in the platform data.  This gives the range of
DMA request signal numbers on the controller, and calls a platform
provided function to setup the multiplexer.

Clearly, if your proposal is all about DMA controller request signals
only, the above scheme can't be represented in DT... and that's what
worries me - the fact is that the DMA engine API can and does cope
with this but it seems that we're building restrictions in with DT on
what can be represented.

That makes me wonder whether the model that's being chosen is anywhere
near correct for the DMA engine API.

Now, as I've said before, I'm trying to work on creating an OMAP DMA engine
implementation, and I'd _really_ like to have the freedom to do what's
necessary there without having to think one bit about DT getting in the
way.  To put it another way, I don't want to be constrained by any weirdo
DT representations at the moment, and I really don't want to waste time
discussing them at the moment, rather than getting on with that job.
Because if I end up discussing this at length, I'm not going to be able
to do anything on the OMAP DMA engine stuff.
