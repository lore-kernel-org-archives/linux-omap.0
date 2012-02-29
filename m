From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
Date: Wed, 29 Feb 2012 13:42:55 -0800
Message-ID: <20120229214255.GR18901@atomide.com>
References: <4F4BB0FB.3040308@ti.com>
 <20120228234837.GH18901@atomide.com>
 <4F4E4F1D.7020109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964772Ab2B2Vm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 16:42:58 -0500
Content-Disposition: inline
In-Reply-To: <4F4E4F1D.7020109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

* Cousson, Benoit <b-cousson@ti.com> [120229 07:43]:
> On 2/29/2012 12:48 AM, Tony Lindgren wrote:
> > 
> > Hmm, looks like this now produces the following warning at least on omap3:
> 
> Yes, Rajendra has just reported that issue with linux-next.
> 
> It is not due to that series but to the increase of TWL irq_desc I did for Grant to fix a warning with irq_domain in the DT boot.
> Unfortunately due the lack of NR_IRQS we already have becasue of PRCM handler we exceed the actual NR_IRQS that is set to 410 for the moment.
> 
> > [    0.290832] WARNING: at drivers/mfd/twl4030-irq.c:645 twl4030_sih_setup+0x258/0x298()
> > [    0.290832] irq 428 for gpio too big

OK. I've pulled this into dt-part2 branch.
 
> After applying the NR_IRQS fix, we still have a warning but a different one in that case:
> 
> [    0.303771] twl4030: PIH (irq 7) chaining IRQs 368..401
> [    0.304473] twl4030: power (irq 373) chaining IRQs 402..409
> [    0.307159] twl4030: gpio (irq 368) chaining IRQs 410..427
> [    0.307189] ------------[ cut here ]------------
> [    0.307220] WARNING: at drivers/gpio/gpio-twl4030.c:410 gpio_twl4030_probe+0x44/0x214()
> 
> This one is due to a "WARN_ON(ret != pdata->irq_base)" that is checking that the board irq_base is the same as the one from the twl4030_sih_setup. This kind of test are not SPARSE_IRQ friendly at all and should be removed anyway. I've attached a patch to fix the GPIO warning.

OK, maybe post that separately so Samuel can queue it?

> Felipe has started a twl4030 IRQ cleanup series to make that driver SPARSE_IRQ enabled. That's will fix properly the actual hack in the twl-core IRQ management. On top of that we can fix the twl-gpio warning.

Great, good to hear.

Regards,

Tony
