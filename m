From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Spurious interrupt warning
Date: Tue, 6 Jan 2009 16:42:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
References: <20090106110837.GG9752@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41055 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbZAFLNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 06:13:05 -0500
In-Reply-To: <20090106110837.GG9752@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Shah, Hardik" <hardik.shah@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

For capture driver I am also getting similar messages

<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
<4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
Spurious irq 95: 0xffffffdf, please flush posted write for irq 24


Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, January 06, 2009 4:39 PM
> To: Shah, Hardik
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Spurious interrupt warning
> 
> Hi,
> 
> * Shah, Hardik <hardik.shah@ti.com> [090106 11:54]:
> > I have ported the V4L2 driver on top of Tomi's DSS library.  DSS
> library has requested irq number 25.  It is never freeing it.  But
> whenever I get interrupt from the DSS I get this warning
> intermittently.
> >
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq
> 25
> >
> >
> >
> > Please note it's not continuous.  Driver is also working fine. Is
> it something to do with the latest spurious interrupt patch.
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
> 2.6.git;a=commitdiff;h=ea153a1765dc754be688013192e8c83c40e008dc
> >
> > Is there something to do in the driver to solve this interrupt
> warning issue.
> 
> Interesting. Can you please try adding a read-back of the interrupt
> status register (or revision register) at the end of the interrupt
> handler for irq 25?
> 
> I guess it's INT_24XX_DSS_IRQ, which is the same for 34xx as 24xx?
> 
> Most likely this spurious interrupt means that the write does not
> get posted all the way to the interrupt controller for device
> interrupt
> handler for irq 25 before irq 25 is unmasked again.
> 
> Doing a read back in the irq 25 handler after the last write forces
> the write to get posted.
> 
> Let me know if that does not help.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

