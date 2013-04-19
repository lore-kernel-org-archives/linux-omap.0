From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using
 mask/unmask.
Date: Fri, 19 Apr 2013 21:25:25 +0200
Message-ID: <20130419192525.GA30345@blumentopf>
References: <1365758001-15562-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1365758001-15562-2-git-send-email-andreas.fenkart@streamunlimited.com>
 <5167DFC8.8060202@ti.com>
 <20130412110701.GF7361@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60187 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab3DSTZd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Apr 2013 15:25:33 -0400
Received: from mailout-de.gmx.net ([10.1.76.1]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Lefrs-1Uszhd0XHS-00qQGU for
 <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 21:25:31 +0200
Content-Disposition: inline
In-Reply-To: <20130412110701.GF7361@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, jon-hunter@ti.com, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, daniel@zonque.org

Hi Felipe,


On Fri, Apr 12, 2013 at 02:07:01PM +0300, Felipe Balbi wrote:
[snip]
> > > Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> > > ---
> > Patch is incomplete and still confusing ;-) if some one reads the
> > patch without the thread. I think you have already ask the question/
> > suggestion in past but its better to split masking/disabling functions
> > and make them behave properly. Mapping enable/disable to mask/unmask
> > to get around the issue seems more of a hack.
> 
> right, specially since IRQ susystem will already do that for
> irq_enable():
> 
> kernel/irq/chip.c::irq_enable()
> 
> 192 void irq_enable(struct irq_desc *desc)
> 193 {
> 194         irq_state_clr_disabled(desc);
> 195         if (desc->irq_data.chip->irq_enable)
> 196                 desc->irq_data.chip->irq_enable(&desc->irq_data);
> 197         else
> 198                 desc->irq_data.chip->irq_unmask(&desc->irq_data);
> 199         irq_state_clr_masked(desc);
> 200 }
> 
> In fact this patch shouldn't be necessary if only IRQ subsystem would do
> the same for irq_disable() (though it doesn't and I haven't fully read
> the code you to understand why, however there's definitely a reason):
> 
> 202 void irq_disable(struct irq_desc *desc)
> 203 {
> 204         irq_state_set_disabled(desc);
> 205         if (desc->irq_data.chip->irq_disable) {
> 206                 desc->irq_data.chip->irq_disable(&desc->irq_data);
> 207                 irq_state_set_masked(desc);
> 208         }
> 209 }

I started some other thread over here:
[PATCH] genirq: use irq_mask as fallback for irq_disable.
https://lkml.org/lkml/2013/4/19/229

/Andi


