From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 1/6] omap: prcm: switch to a chained IRQ handler mechanism
Date: Fri, 24 Jun 2011 09:00:14 -0700
Message-ID: <87wrgb1apd.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-2-git-send-email-t-kristo@ti.com>
	<20110623081940.GW23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:54929 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759845Ab1FXQAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 12:00:18 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so2809781pvc.39
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 09:00:16 -0700 (PDT)
In-Reply-To: <20110623081940.GW23145@atomide.com> (Tony Lindgren's message of
	"Thu, 23 Jun 2011 01:19:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Tero Kristo <t-kristo@ti.com> [110622 09:38]:

[...]

>> +struct omap_prcm_irq  __initdata omap_prcm_3xxx_irqs[] = {
>> +	OMAP_PRCM_IRQ("wkup",                  0,
>> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
>> +	OMAP_PRCM_IRQ("evgenon",               2,
>> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
>> +	OMAP_PRCM_IRQ("evgenoff",              3,
>> +		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
> ...
>
> Please note consider that this data will be coming from device
> tree and will disappear from here. We won't be merging any new
> data after v3.1 unless it comes from device tree. 

Personally, I don't think this qualifies as device-tree data.  At least
not yet, since the device tree does not currently handle this type of
thing since it's not a real interrupt controller.

Even for the newly proposed (but not merged) irq_domain stuff in the
device tree to work, there needs to be an irq_desc for each of the
"linux IRQs" (to use the term from the irq_domain stuff), so the above
mapping of names needs to exist in order to create the irq_descs so that
irq_domains can even work.

Also, until the rest of our IRQ infrastructure is converted to device
tree (which will also need irq_domains), and until there is a way to
describe the PRCM in the device tree, I don't think it makes sense to
use device tree to describe this small amount of data (which is also
__initdata.)

> So this too will need to be converted because we won't be able to add
> support for new omaps otherwise.

For small amounts of data like this, I think we can.  

As long as we're working on the device tree for the big items, I think
we can make a case that items like this belong in the kernel.  In my
opinion, just because it's data, doesn't mean it always belongs in the
device tree.  Some kinds of data will always be needed to create
infrastructure even for the device tree to work.  I think interrupts are
one of those items.

Kevin
