From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: architected timers: Mark the clockevent with the
 C3_STOP feature
Date: Wed, 4 Jul 2012 16:11:26 +0530
Message-ID: <CAMQu2gypTXaG7ADEJuKSUq9eBMOUQAoBW5SmUbC4Td4ZxXVFVA@mail.gmail.com>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com> <20120704102617.GC16639@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:37552 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933181Ab2GDKls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:41:48 -0400
Received: by qaat11 with SMTP id t11so3336601qaa.13
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 03:41:47 -0700 (PDT)
In-Reply-To: <20120704102617.GC16639@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>, linux-omap@vger.kernel.org

On Wed, Jul 4, 2012 at 3:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Wed, Jul 04, 2012 at 03:24:33PM +0530, Santosh Shilimkar wrote:
> > ARM arch timers stop in low power state and hence can not wakeup CPUs in
> > deeper idle states when used as cloc event devices. Marking these clock
> > event
> > devices with C3_STOP so that during lowpower states, the tick is managed
> > by
> > wakeup capable broadcast timer.
>
> Will tells me that the arch timers don't stop in low power modes, they
> just can't produce wakeup events.  Apparantly the spec says:
>
>    The system counter must be implemented in an always-on power domain.
>    Use of lower-frequency modes must not affect the implemented accuracy.
>
> Are you sure your above description of the problem is correct?

Yes. Will is right.
The arch timers don't stop with a real time counter implementation.
The issue is they are not wakeup capable hence you need a broad-cast switching
which in turn needs C3_STOP.

Regards
Santosh
