From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 19:39:52 +0100
Message-ID: <4F32C178.8050503@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk> <4F307661.6030706@ti.com> <20120207084117.GP1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756849Ab2BHSkD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 13:40:03 -0500
In-Reply-To: <20120207084117.GP1275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

On 2/7/2012 9:41 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 07, 2012 at 01:54:57AM +0100, Cousson, Benoit wrote:
>> Hi Russell,
>>
>> On 2/7/2012 1:24 AM, Russell King - ARM Linux wrote:
>>> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>>>> In theory that patch should not be even needed.
>>>
>>> In theory that change is needed to fix the obviously broken code which
>>> is there at the moment.
>>
>> Well, both patches were supposed to be merged during the last merge
>> window, so this code is not broken
>
> You're talking out your arse.

Yep, this requires years of practice, but the harder is not necessarily 
to talk but mainly to handle the keyboard.

> It's fucked, because:
>
>          domain.irq_base = pdata->irq_base;
>          domain.nr_irq = nr_irqs;
> #ifdef CONFIG_OF_IRQ
>          domain.of_node = of_node_get(node);
>          domain.ops =&irq_domain_simple_ops;
> #endif
>          irq_domain_add(&domain);
>
> YOU MUST NEVER EVER REGISTER AN IRQ DOMAIN WITH A NULL .ops MEMBER OTHERWISE
> THE KERNEL IS GUARANTEED TO OOPS.

OK, I think I get it now. AFAIR the domain.ops was added inside the 
CONFIG_OF_IRQ because irq_domain_simple_ops was just defined if 
CONFIG_OF_IRQ was defined at that time and thus the build was broken for 
non-DT build.

It appears that this dependency was indeed broken because after googling 
a little bit based on Mark's comment I found that a proper patch to fix 
that was sent during 3.2-rc5.

commit c87fb57346fc7653ace98769f148e0dcd88ac1ee
Author: Jamie Iles <jamie@jamieiles.com>
Date:   Wed Dec 14 23:43:16 2011 +0100

     ARM: 7235/1: irqdomain: export irq_domain_simple_ops for !CONFIG_OF

So indeed, it is now safe and better to remove this CONFIG_OF_IRQ to 
avoid the oops before Grant nuke that code with the new 
irq_domain_add_legacy.

Regards,
Benoit
