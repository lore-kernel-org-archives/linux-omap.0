From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2: n8x0: move i2c devices to DT
Date: Wed, 17 Sep 2014 08:08:18 -0700
Message-ID: <20140917150818.GB14505@atomide.com>
References: <1410899500-21323-1-git-send-email-balbi@ti.com>
 <20140916203337.GI19010@saruman.home>
 <20140917145131.GB7987@atomide.com>
 <20140917150205.GB6903@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33735 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbaIQPIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 11:08:37 -0400
Content-Disposition: inline
In-Reply-To: <20140917150205.GB6903@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

* Felipe Balbi <balbi@ti.com> [140917 08:03]:
> On Wed, Sep 17, 2014 at 07:51:32AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [140916 13:34]:
> > > On Tue, Sep 16, 2014 at 03:31:40PM -0500, Felipe Balbi wrote:
> > > > By moving i2c devices to DT we can clean up
> > > > i2c_board_info and fix a problem with moving
> > > > INTC to irq domain where IRQs can be renumbered
> > > > on each boot.
> > > > 
> > > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > > note that this only causes problem for N8x0 because it boots in kinda of
> > > a hybrid way, where it uses DT but not all peripherals are created
> > > through DT.
> > 
> > Thanks applying this into omap-for-v3.18/intc-v2.
> 
> it might be better to apply this on your DT branch and merge DT before
> intc-v2, that might avoid a bisection problem.

Yes it would have been nice to have this as a patch before preparing
for intc-v2, but I did not have my n8x0 booting reliably because of
xhci vs ehci issues on my PC and did not notice it early enough.

I've already sent a pull request for the first part of intc-v2, so
best to keep the related changes together in this case.

Regards,

Tony
