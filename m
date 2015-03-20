From: Tony Lindgren <tony@atomide.com>
Subject: Re: am335x: GPMC: reading speed with prefetch mode
Date: Fri, 20 Mar 2015 08:09:10 -0700
Message-ID: <20150320150910.GS31346@atomide.com>
References: <CAGm1_kvgLKxDt_Xy8tdVDfOk46sD0-ybycXZT3tUd-5-=mD8WA@mail.gmail.com>
 <550AD57A.4070701@zonque.org>
 <CAGm1_kvh9cSwjqM0VohXRLN5sTmWLqAjzdj8W0p47FcpM0cKrA@mail.gmail.com>
 <550AF1A8.8030402@gmail.com>
 <CAGm1_ksmOPhJ=esbHJWy1TwfUS0gv35E0pxpPyQw1sjthT93CA@mail.gmail.com>
 <550C146D.40709@ti.com>
 <CAGm1_kvn8Wf=2RX+877eVTZY7FAfK4WN0LOBcFWJZwHhQBZqUA@mail.gmail.com>
 <550C2910.8020604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38923 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbCTPNs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 11:13:48 -0400
Content-Disposition: inline
In-Reply-To: <550C2910.8020604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, Daniel Mack <zonque@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Falco Hyfing <hyfinglists@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Roger Quadros <rogerq@ti.com> [150320 07:59]:
> On 20/03/15 15:37, Yegor Yefremov wrote:
> > 
> > Btw. where DMA support should be configured? GPMC config has no "dmas"
> > like other components like mmc, uart, USB etc.
> 
> I've never tested dma on omap-nand in mainline. We've been solely relying on
> prefetch-polled mode there.
> 
> someone needs to work on it and test dma support.
> 
> looks like the driver is hardcoding the DMA channel
>                 sig = OMAP24XX_DMA_GPMC;
>                 info->dma = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> 
> this will have to be fixed.
> I'm not sure what else is missing on DMA side. But you could try to use a
> free channel and see if it works?
> 
> Tony any insights?

There are six external DMA request pins on omaps that can be used for
devices on GPMC for DMA. These are the sys_ndmareq0 to 5. So far the only
the old tusb6010 driver is the only one using that, and it's still not
using the DMA engine API. I've been meaning to update it, but have not
had a chance yet.. Anyways, all the new DMA code should use the dmaengine
API instead of the omap legacy DMA calls.

Note that the onenand driver is wrongly using the external gpio request
pin as a GPIO. That's not what the pin is supposed to do, it needs to be
muxed to the external gpio request mode. So I suggest we either rip out
the DMA code from onenand, or update it to use the sys_ndmareq and DMA
engine API.

Regards,

Tony
