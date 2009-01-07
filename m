From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Spurious interrupt warning
Date: Wed, 7 Jan 2009 11:24:51 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D48171F@dlee02.ent.ti.com>
References: <20090106110837.GG9752@atomide.com>
 <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
 <20090106111928.GA10260@atomide.com>
 <13B9B4C6EF24D648824FF11BE8967162036D480BD0@dlee02.ent.ti.com>
 <20090107082618.GC27566@atomide.com>
 <13B9B4C6EF24D648824FF11BE8967162036D4815E2@dlee02.ent.ti.com>
 <20090107171313.GA17855@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759430AbZAGRY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 12:24:59 -0500
In-Reply-To: <20090107171313.GA17855@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Yes Russell doesn't like it.  However, I didn't see any viable alternate
> > solution offered.  If ARM or any hardware vendor does something badly in
> > hardware punishing the current generation in hopes of changing the next
> > is not so good. Especially if some work around exists.
>
> I do hope you realise that precisely the same argument can be made for
> the posting of writes to the timers.
>
> And this is what's soo hard to grasp about your position - at one moment
> you're talking about needing maximal performance (which involves the use
> of device mappings.)  The next moment you're talking about wanting 100%
> predictability by using strongly ordered mappings.

The posting talked about for timers is posting in the device.  The device itself has very specific rules about waiting.

I expect to have to program carefully for this critical device.  I don't expect to have to program as carefully for every other address in the system.

The interconnect performance aspect of DEVICE vs. SO is not in the same order of magnitude as the effect with timer.

> The fact of the matter is that from point of view of the ARM CPU, a
> readback of the same address which was written to with a device mapping
> can not bypass the write.  So a write to register X followed by an
> immediate read of X and an execution dependency on that result _will_
> cause the write to appear on the bus before execution can continue.
> If anything else happens, the CPU is buggy because its allowing writes
> to pass reads which is unpredictable from the system point of view.
>
> If you can't get it to work with a readback and dependency, that suggests
> that something else external to the CPU is misbehaving or broken.

I don't mind using a read back dependency.  I don't like it but that may be necessary in some cases for a given device.

What I don't like is constantly hitting them and getting a broken system.  How many of these are out there?  If we can remove most of them in current software with SO then that isn't a bad tradeoff.

[x] Minimally having an option to enable or disable it would be good.  I just sent you such a patch.  If you dis-allow SO mapping to exist in the kernel I don't even get the option.

When interconnects and the like were really slow these effects were masked.

Regards,
Richard W.

