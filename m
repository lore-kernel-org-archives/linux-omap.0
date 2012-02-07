From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 08:41:17 +0000
Message-ID: <20120207084117.GP1275@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk> <4F307661.6030706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52004 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab2BGIla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 03:41:30 -0500
Content-Disposition: inline
In-Reply-To: <4F307661.6030706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Feb 07, 2012 at 01:54:57AM +0100, Cousson, Benoit wrote:
> Hi Russell,
>
> On 2/7/2012 1:24 AM, Russell King - ARM Linux wrote:
>> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>>> In theory that patch should not be even needed.
>>
>> In theory that change is needed to fix the obviously broken code which
>> is there at the moment.
>
> Well, both patches were supposed to be merged during the last merge  
> window, so this code is not broken

You're talking out your arse.  It's fucked, because:

        domain.irq_base = pdata->irq_base;
        domain.nr_irq = nr_irqs;
#ifdef CONFIG_OF_IRQ
        domain.of_node = of_node_get(node);
        domain.ops = &irq_domain_simple_ops;
#endif
        irq_domain_add(&domain);

YOU MUST NEVER EVER REGISTER AN IRQ DOMAIN WITH A NULL .ops MEMBER OTHERWISE
THE KERNEL IS GUARANTEED TO OOPS.

I don't care whether you think "oh, but OF_IRQ should have been set".
That's not the point.  The fact is, how this code is _currently_ written,
it is _broken_ and therefore this code needs fixing.
