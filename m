From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 21 Jun 2012 13:21:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206211250190.3513@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206150900.50866.arnd@arndb.de> <Pine.LNX.4.64.1206151107480.11729@axis700.grange>
 <201206151127.24386.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61805 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab2FULWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 07:22:08 -0400
In-Reply-To: <201206151127.24386.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Arnd

Sorry for a delayed reply, we had to discuss this your idea internally 
first before replying.

On Fri, 15 Jun 2012, Arnd Bergmann wrote:

> On Friday 15 June 2012, Guennadi Liakhovetski wrote:
> > > In the common case, you could have one device connected to the third
> > > slave ID of the first controller but the fifth slave ID of the
> > > second controller. In this case, you really have to specify each
> > > controller with its slave ID separately, even if that means a lot
> > > of duplicate data for shmobile.
> > 
> > So, you don't think it's worth making a short-cut possible to specify a 
> > DMAC type instead of each instance phandle? It really would mean __a lot__ 
> > of duplication - with 3 generic controllers on (some) current chips and 
> > possibly more on those, that I'm not aware about.
> 
> It's certainly possible to make that short-cut, but I'm not convinced
> if it's worth it. One thing you can do is create a meta-device for
> all of the identical DMA controllers, and refer to that one from the
> devices, but make it a separate device node from the actual controllers,
> of which you can have more than one. This makes the binding for your
> dma controller more complex but reduces the amount of data required
> in the other device nodes.
> 
> In case of sh7372, this could look something like
> 
> 	dma: dmac-mux {
> 		compatible = "renesas,sh-dma-mux";
> 		#dma-cells = <4>; /* slave-id, addr, chcr, mid-rid */
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 
> 		dmae@0xfe008020{
> 			compatible = "renesas,sh-dma";
> 			reg = <0xfe008020 0xfe00828f
> 				0xfe009000 0xfe00900b>
> 			interrupts = <0x20c0 0x2000 0x2020 0x2040 0x2060 0x2080 0x20a0>;
> 		};
> 
> 		dmae@0xfe018020{
> 			compatible = "renesas,sh-dma";
> 			reg = <0xfe018020 0xfe01828f
> 				0xfe019000 0xfe01900b>
> 			interrupts = <0x21c0 0x2100 0x2120 0x2140 0x2160 0x2180 0x21a0>;
> 		};
> 
> 		dmae@0xfe028020{
> 			compatible = "renesas,sh-dma";
> 			reg = <0xfe028020 0xfe02828f
> 				0xfe029000 0xfe02900b>
> 			interrupts = <0x22c0 0x2200 0x2220 0x2240 0x2260 0x2280 0x22a0>;
> 		};
> 	};
> 
> This way, a slave would refer to the dmac-mux node and while
> the device driver binds to the child nodes.

Indeed, this solution should be good enough, thanks! I'm not sure, whether 
making this multiplexing available requires any additional code to the 
generic DMA DT binding implementation. If it does - please, let's make 
this a part of the implementation.

It is also important to provide a flexible multiple channel per device 
configuration support to let slave drivers distinguish between different 
DMA channels, that they get back from the API. But I think this is a part 
of the current proposal and is being taken care of.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
