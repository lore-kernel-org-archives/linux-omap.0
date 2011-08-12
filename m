From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: How to handle named resources with DT?
Date: Fri, 12 Aug 2011 19:47:55 +0800
Message-ID: <20110812114754.GI6618@S2100-06.ap.freescale.net>
References: <20110809162907.GA630@manju-WNB7PBC4801-0006>
 <4E4166F0.9050401@ti.com>
 <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
 <4E4172A8.3030101@ti.com>
 <20110809205542.GD11568@ponder.secretlab.ca>
 <4E41A156.3030407@ti.com>
 <20110809211657.GI11568@ponder.secretlab.ca>
 <4E41A886.30205@ti.com>
 <20110812041016.GA6618@S2100-06.ap.freescale.net>
 <4E44EAAD.1030805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:18816
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587Ab1HLLkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Aug 2011 07:40:08 -0400
Content-Disposition: inline
In-Reply-To: <4E44EAAD.1030805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 12, 2011 at 10:56:13AM +0200, Cousson, Benoit wrote:
[...]
> >>The devil is in the details, but the way the DMA lines are connected
> >>in OMAP is similar to IRQ lines, and maybe a little bit simpler.
> >>
> >>So starting with a copy/paste of the of_irq file should be a good start.
> >>And then the issues will start:-)
> >>
> >
> >I had a conversation with Arnd as below.  Arnd has the concern on
> >multiple dma controllers.  So it is a question if we need to handle
> >multiple dma controllers like we do for multiple irq controllers.
> 
> Quite, interesting, I cannot find the thread, did you discuss that
> on linaro-dev, lakml?
> 
http://thread.gmane.org/gmane.linux.drivers.devicetree/6587

-- 
Regards,
Shawn

