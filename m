From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Sat, 28 Jan 2012 11:12:36 -0700
Message-ID: <20120128181236.GD2501@ponder.secretlab.ca>
References: <4F22DEF2.5000807@ti.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178E123E7A@HQMAIL01.nvidia.com>
 <4F230AB5.1050607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46904 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2A2A2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Jan 2012 19:28:03 -0500
Received: by pbaa10 with SMTP id a10so2716653pba.19
        for <linux-omap@vger.kernel.org>; Sat, 28 Jan 2012 16:28:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F230AB5.1050607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 27, 2012 at 09:36:05PM +0100, Cousson, Benoit wrote:
> On 1/27/2012 7:13 PM, Stephen Warren wrote:
> >Cousson, Benoit wrote at Friday, January 27, 2012 10:29 AM:
> >>diff --git a/drivers/of/dma.c b/drivers/of/dma.c
> >
> >>+int of_get_dma_request(struct device_node *np, int index,
> >>+		       struct device_node **ctrl_np)
> >>+{
> >>+	int ret = -EINVAL;
> >>+	struct of_phandle_args dma_spec;
> >>+
> >>+	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
> >>+					 index,&dma_spec);
> >>+	if (ret) {
> >>+		pr_debug("%s: can't parse dma property\n", __func__);
> >>+		goto err0;
> >>+	}
> >>+
> >>+	if (dma_spec.args_count>  0)
> >>+		ret = dma_spec.args[0];
> >
> >Doesn't that force #dma-cells>  0? What about a DMA controller that only
> >supports a single DMA request, in which case you might want #dma-cells==0?
> 
> OK, if such DMA controller exist, it will make sense.
> 
> >Having an of_xlate for the controller would be useful here in general:
> >
> >Is a single int really enough here?
> >
> >Some DMA controllers have N channels that can be used for arbitrary
> >things. You may need to specify the DMA request once when allocating the
> >channel, or maybe individual for each transfer if it can vary. Other
> >controllers may need a special channel ID for each type of request. There
> >are probably more cases I haven't thought of.
> 
> In my naive view of the DMA controller the channel is something that
> will be handled and allocated by the DMA controller upon driver
> request. So this is not something that is necessarily HW related,
> and thus should not be described in DT.
> But, maybe I'm missing your point.

The binding for each dma controller gets to decide the format and size
of the dma spec (just like for irq and gpio specs).  The data in the
spec is opaque to the DMA users, and only has meaning after code with
knowledge of the specific dma controller binding .xlates it into
something useful.

So for OMAP, the binding may trivially map, but other DMA controllers
may require flags or other configuration encoded into the DMA spec.
The generic binding must take that into account.

> >I suppose a controller may be able to represent that cookie in a single
> >int, but perhaps not, e.g. if a binding needs #dma-cells=4 for some
> >reason. Perhaps returning a void* here would be better, coupled with
> >of_put_dma_request() to allow the controller to free it if required?
> >
> >That'd allow individual controller bindings to specify e.g. HW FIFO
> >width, wrap, FIFO levels for HW flow control, ...
> >(I vaguely recall that dmaengine addresses some of this already, but
> >unfortunately I'm not very familiar with it yet)
> 
> Me neither, but do we have to handle all this parameters in DT? I
> guess that most of the configuration will still be under driver
> responsibility for the channel. The DMA controller itself can
> clearly defined a bunch of parameters to expose its capabilities,
> but again so far I do not have any clue about all these fancy DMA
> controller variants. Some flexibility will clearly be needed, but
> how far should we go?

It goes as far as the binding author deems is appropriate.  For your
case it sounds like 1 cell is sufficient, so go with that.  Just don't
restrict other binding authors from encoding more (or less) data.
Especially when it is trivial to allow #dma-cells != 1.

g.
