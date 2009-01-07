From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Spurious interrupt warning
Date: Wed, 7 Jan 2009 10:13:30 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D4815E2@dlee02.ent.ti.com>
References: <20090106110837.GG9752@atomide.com>
 <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com>
 <20090106111928.GA10260@atomide.com>
 <13B9B4C6EF24D648824FF11BE8967162036D480BD0@dlee02.ent.ti.com>
 <20090107082618.GC27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbZAGQNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 11:13:48 -0500
In-Reply-To: <20090107082618.GC27566@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>

> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, January 07, 2009 2:26 AM
> > It just happens to be the IRQ path has a very slow dissertation path when
> you take into account timing domains that it shows up.
> >
> > Shrinking the race window with SO then using a read back to get the last one
> or two is most conservative and safe.  Probably 97% for IO accesses are ok on
> OMAP as device, but that is probably 99.9% with SO.  In our testing we may be
> able to make that 97 a 99.  Still I'd rather not risk the 1% for production.
>
> Sure you can patch the SO back if you want to. However, it's a more
> generic problem, and Russell has stated that he does not want to
> merge it.

Yes Russell doesn't like it.  However, I didn't see any viable alternate solution offered.  If ARM or any hardware vendor does something badly in hardware punishing the current generation in hopes of changing the next is not so good. Especially if some work around exists.

In the end vendors will carry some out of tree patch.  All that will happen is a new person to the lists will be put off.

> At least the interrupt problems are easy to debug now, so I'd say
> those are easy one liners to fix. The other places where we need
> to flush posted writes may be harder to track down, but should be
> possible to spot by reading the code of the problem driver.

The code you added to spotlight issues and the fixes it generates should stay in place.  SO does not solve the whole problem it just shrinks it.

I don't like the idea of exposing ourselves to some known hardware limitation just because we don't like the fix.  Already a lot of hours have been wasted on this issue.  Why drag it out further.

I've complained bitterly already and those nits have been acknowledged by hardware people in TI and ARM.

Regards,
Richard W.

