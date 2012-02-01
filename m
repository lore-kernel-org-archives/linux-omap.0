From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Wed, 1 Feb 2012 11:50:30 +0100
Message-ID: <4F2918F6.9040100@ti.com>
References: <4F22DEF2.5000807@ti.com> <20120128180602.GC2501@ponder.secretlab.ca> <20120131230928.GA8394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46340 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab2BAKur (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Feb 2012 05:50:47 -0500
In-Reply-To: <20120131230928.GA8394@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On 2/1/2012 12:09 AM, Russell King - ARM Linux wrote:
> On Sat, Jan 28, 2012 at 11:06:02AM -0700, Grant Likely wrote:
>> This makes the assumption that dma specifiers will only ever be 1
>> cell.  I think to be generally useful, the full dma specifier needs to
>> be either handed to the dma controller to get a cookie or passed back
>> to the caller in its entirety.
>
> More to the point, who says that the DMA specifier is even an integer?
> When people are using DMA engines, it (probably) isn't an integer at
> all.  Several platforms I know of use strings for this.
>
> Some platforms can even select between two or more DMA engines for
> handling the same peripheral - I believe Samsung do this depending
> on their individual workloads.
>
> However, the opaque DMA engine API for requesting a channel doesn't
> lend itself well to DT, as the match data and match function are
> entirely left to the individual DMA engine driver and/or platform
> itself.
>
> As far as creating another linear number space for DMA stuff, I'd
> really suggest against that - you're going to need some additional
> code in place to manage that numberspace.  If you at least use a two-
> paid cookie, eg 'dma controller phandle + request signal' then that
> makes all the stuff we're starting to see with the IRQ subsystem,
> IRQ domains etc become completely unnecessary.
>
> I guess what I'm saying is ignore the flat number space, and go
> straight to some kind of 'dma domains' solution from the start.

Fully agree, and this is exactly the idea of this DMA binding: First 
argument is always a DMA controller phandle and then you can add 0, 1 or 
more cells to define extra specifiers dependent of the DMA controller 
driver expectation. The one cell Grant was referring was just the extra 
specifier that is needed for a simple DMA engine like the SDMA we have 
inside OMAP. But the whole idea is to have a flexible enough mechanism 
to allow any kind of specifier.

No more global linear number space like for IRQ!

Regards,
Benoit



