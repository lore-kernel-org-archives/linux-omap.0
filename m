From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: musb: Fix fifo reads for dm816x with musb_dsps
Date: Wed, 1 Apr 2015 14:44:39 -0700
Message-ID: <20150401214438.GU10805@atomide.com>
References: <1426718882-27187-1-git-send-email-tony@atomide.com>
 <20150401143539.b5ad81f576101080848147ca@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41349 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbbDAVsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 17:48:40 -0400
Content-Disposition: inline
In-Reply-To: <20150401143539.b5ad81f576101080848147ca@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, George Cherian <george.cherian@ti.com>

* Andrew Morton <akpm@linux-foundation.org> [150401 14:36]:
> On Wed, 18 Mar 2015 15:48:02 -0700 Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like dm81xx can only do 32-bit fifo reads like am35x. Let's set
> > up musb-dsps with a custom read_fifo function based on the compatible
> > flag.
> > 
> > Otherwise we can get the following errors when starting dhclient on a
> > asix USB Ethernet adapter:
> > 
> > asix 2-1:1.0 eth2: asix_rx_fixup() Bad Header Length 0xffff003c, offset 4
> > 
> > While at it, let's also remove pointless cast of the driver data.
> 
> This breaks my i386 allmodconfig build.
> 
> > +/* Similar to am35x, dm81xx support only 32-bit read operation */
> > +static void dsps_read_fifo32(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
> > +{
> > +	void __iomem *fifo = hw_ep->fifo;
> > +	u32		val;
> > +	int		i;
> > +
> > +	/* Read for 32bit-aligned destination address */
> > +	if (likely((0x03 & (unsigned long)dst) == 0) && len >= 4) {
> > +		readsl(fifo, dst, len >> 2);
> 
> akpm3:/usr/src/linux-4.0-rc6> grep -r readsl arch/x86 
> akpm3:/usr/src/linux-4.0-rc6> 

Yes sorry, the fix is to use ioread32_rep() instead. I already sent a fix
for that on the 25th as:

"[PATCH 1/1] usb: musb: dsps: fix build on i386 when COMPILE_TEST is set"

https://www.marc.info/?l=linux-usb&m=142731859732737&w=1

Felipe, can you please get that into Linux next?

Regards,

Tony
