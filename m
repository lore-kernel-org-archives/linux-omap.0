From: Tony Lindgren <tony@atomide.com>
Subject: Re: Spurious interrupt warning
Date: Tue, 6 Jan 2009 13:19:29 +0200
Message-ID: <20090106111928.GA10260@atomide.com>
References: <20090106110837.GG9752@atomide.com> <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49696 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZAFLTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 06:19:33 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [090106 13:13]:
> For capture driver I am also getting similar messages
> 
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 24

The same solution should work in the irq 24 handler as well. Just do
a read-back of the last written register in the irq 24 handler.

Or a read back of some safe register in the same device in case
you cannot read back the interrupt status register without clearing
the device interrupts :)

Regards,

Tony

> 
> 
> Thanks,
> Vaibhav Hiremath
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Tuesday, January 06, 2009 4:39 PM
> > To: Shah, Hardik
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: Spurious interrupt warning
> > 
> > Hi,
> > 
> > * Shah, Hardik <hardik.shah@ti.com> [090106 11:54]:
> > > I have ported the V4L2 driver on top of Tomi's DSS library.  DSS
> > library has requested irq number 25.  It is never freeing it.  But
> > whenever I get interrupt from the DSS I get this warning
> > intermittently.
> > >
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> > 25
> > >
> > >
> > >
> > > Please note it's not continuous.  Driver is also working fine. Is
> > it something to do with the latest spurious interrupt patch.
> > > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> > 2.6.git;a=commitdiff;h=ea153a1765dc754be688013192e8c83c40e008dc
> > >
> > > Is there something to do in the driver to solve this interrupt
> > warning issue.
> > 
> > Interesting. Can you please try adding a read-back of the interrupt
> > status register (or revision register) at the end of the interrupt
> > handler for irq 25?
> > 
> > I guess it's INT_24XX_DSS_IRQ, which is the same for 34xx as 24xx?
> > 
> > Most likely this spurious interrupt means that the write does not
> > get posted all the way to the interrupt controller for device
> > interrupt
> > handler for irq 25 before irq 25 is unmasked again.
> > 
> > Doing a read back in the irq 25 handler after the last write forces
> > the write to get posted.
> > 
> > Let me know if that does not help.
> > 
> > Regards,
> > 
> > Tony
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
