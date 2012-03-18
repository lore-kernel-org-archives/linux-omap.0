From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 21:58:10 +0000
Message-ID: <201203182158.10957.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203182013.22790.arnd@arndb.de> <20120318204421.759F23E07BF@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab2CRV6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 17:58:37 -0400
In-Reply-To: <20120318204421.759F23E07BF@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

On Sunday 18 March 2012, Grant Likely wrote:
> > struct dma_channel *of_dma_request_channel(struct of_node*, int index,
> >                                       dma_cap_mask_t *mask,
> >                                       void *driver_data)
> > {
> >       struct of_phandle_args dma_spec;
> >       struct dma_device *device;
> >       struct dma_chan *chan = NULL;
> >       dma_filter_fn *filter;
> > 
> >       ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
> >                                        index, &dma_spec);
> > 
> >       device = dma_find_device(dma_spec->np);
> 
> Is dma_find_device() a new function?  How does it look up the dma
> device?

Yes, it would be similar to the proposed function in Benoit's patch

> > 
> >       if (dma_spec->args_count == 0)
> >               filter = dma_filter_simple;
> >       else
> >               filter = device->dma_dt_filter; /* new member */
> 
> I'm not thrilled with this if/else hunk; even the case of
> #dma-cells=<0> should provide a hook; even it if is the stock simple
> filter.  Leaving filter as NULL is the same as accepting everything
> anyway.

Right, good point. So a dmaengine driver would either register a trivial
filter if it wants to do anything here, or it would just leave it as a NULL
pointer otherwise.

	Arnd
