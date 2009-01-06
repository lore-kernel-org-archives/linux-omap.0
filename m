From: Tony Lindgren <tony@atomide.com>
Subject: Re: Spurious interrupt warning
Date: Tue, 6 Jan 2009 13:08:38 +0200
Message-ID: <20090106110837.GG9752@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6629AAC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59567 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZAFLIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 06:08:42 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6629AAC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shah, Hardik" <hardik.shah@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Shah, Hardik <hardik.shah@ti.com> [090106 11:54]:
> I have ported the V4L2 driver on top of Tomi's DSS library.  DSS library has requested irq number 25.  It is never freeing it.  But whenever I get interrupt from the DSS I get this warning intermittently. 
> 
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 25
> 
> 
> 
> Please note it's not continuous.  Driver is also working fine. Is it something to do with the latest spurious interrupt patch.  
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=ea153a1765dc754be688013192e8c83c40e008dc
> 
> Is there something to do in the driver to solve this interrupt warning issue. 

Interesting. Can you please try adding a read-back of the interrupt
status register (or revision register) at the end of the interrupt
handler for irq 25?

I guess it's INT_24XX_DSS_IRQ, which is the same for 34xx as 24xx?

Most likely this spurious interrupt means that the write does not
get posted all the way to the interrupt controller for device interrupt
handler for irq 25 before irq 25 is unmasked again.

Doing a read back in the irq 25 handler after the last write forces
the write to get posted.

Let me know if that does not help.

Regards,

Tony
