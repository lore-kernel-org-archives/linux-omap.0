From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Spurious interrupt warning
Date: Tue, 6 Jan 2009 08:05:46 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D480BD0@dlee02.ent.ti.com>
References: <20090106110837.GG9752@atomide.com>
 <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
 <20090106111928.GA10260@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45265 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZAFOFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 09:05:53 -0500
In-Reply-To: <20090106111928.GA10260@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> * Hiremath, Vaibhav <hvaibhav@ti.com> [090106 13:13]:
> > For capture driver I am also getting similar messages
> >
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> > <4>Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
> > Spurious irq 95: 0xffffffdf, please flush posted write for irq 24
>
> The same solution should work in the irq 24 handler as well. Just do
> a read-back of the last written register in the irq 24 handler.
>
> Or a read back of some safe register in the same device in case
> you cannot read back the interrupt status register without clearing
> the device interrupts :)

I'll re-raise the opinion that SO should be used for device mappings on OMAP.

This is not just an IRQ issue.  It's a generic one to programming a device and knowing when what you have written has taken.

It just happens to be the IRQ path has a very slow dissertation path when you take into account timing domains that it shows up.

Shrinking the race window with SO then using a read back to get the last one or two is most conservative and safe.  Probably 97% for IO accesses are ok on OMAP as device, but that is probably 99.9% with SO.  In our testing we may be able to make that 97 a 99.  Still I'd rather not risk the 1% for production.

Regards,
Richard W.

