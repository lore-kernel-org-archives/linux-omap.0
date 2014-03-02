From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Use handle_fasteoi_irq for INTC interrupt
 handling
Date: Sun, 2 Mar 2014 09:37:28 -0800
Message-ID: <20140302173727.GB18496@atomide.com>
References: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
 <20140228171111.GA15399@atomide.com>
 <1393667952.21887.15.camel@e37108.spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14007 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaCBRhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Mar 2014 12:37:41 -0500
Content-Disposition: inline
In-Reply-To: <1393667952.21887.15.camel@e37108.spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?S=C3=B8rensen=2C?= Stefan <Stefan.Sorensen@spectralink.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* S=C3=B8rensen, Stefan <Stefan.Sorensen@spectralink.com> [140301 02:02=
]:
> On Fri, 2014-02-28 at 09:11 -0800, Tony Lindgren wrote:
> > * Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com> [140224 02=
:12]:
> > > Currently INTC interrupts are handled using handle_level_irq whic=
h
> > > will acknowledge the interrupt before running the handler. If a s=
econd
> > > interrupt is then asserted and this interrupt is disabled while
> > > running the first handler, the INTC will be brought into an
> > > inconsistent state.
> >=20
> > Hmm care to explain a bit more here if the second interrupt you're
> > talking about is the same interrupt or any interrupt in the same
> > interrupt bank? Is this limited to GPIO interrupts?
>=20
> I am seeing it with the cpsw driver on a custom board and on the
> beaglebone. When a tx irq is handled the cpsw irq handler disables bo=
th
> the tx and the rx irqs, and if the rx irq was also asserted (i.e. dup=
lex
> traffic), this bug will trigger. Reproducing it is very simple, just =
hit
> a beaglebone with a flood ping and watch a function trace.

OK so it's for the same interrupt. And that sounds like a good test :)
=20
> Applying this patch I see a significant performance boost on duplex
> traffic. An iperf full duplex test gives a 50-100% increase in receiv=
e
> bandwidth - it now fully saturates a 100Mb interface, so the increase
> might be even larger with a gigabit interface.
>=20
> > The reason I'm asking is because of the issues we've seen earlier
> > with not flushing posted writes from the interrupt handlers. In
> > those case the interrupt on the device gets acked too late without
> > the read back call.
>=20
> I am not very familiar with the low level details of the irq handling=
, =20
> but am335x TRM states that a data synchronization barrier should be u=
sed
> after the ACK is posted to the INTC, and I don't see that anywhere in
> the code. Is this related?

Well sort of, except DSB won't do it as it won't guarantee the write
gets to the device on the bus. So a readback from the device is needed
as only the order of reads and writes is guaranteed.

A good sanity check would be to find the related interrupt handler(s)
in the cpsw driver that do the write to the cpsw registers to ack
interrupts.

Then check if there's a readback in the cpsw interrupt handler(s) of
some harmless cpsw register after acking the interrupt(s) and before
doing return IRQ_HANDLED.

If this fixes things without your patch, then we know it's a driver
issue and there's no need to debug it further :) The missing flush of
posted write usually shows up as a spurious interrupts with no status
in the device, but depending on the driver code handling of spurious
interrupts it may also have other side effects.

I'm not too familiar with the cpsw driver so I can't do a test patch
without digging into it further sorry. For similar examples, you
may want to grep for "flush posted write" and "OCP barrier" in the
kernel code.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
