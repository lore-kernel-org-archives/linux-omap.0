From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Use handle_fasteoi_irq for INTC interrupt
 handling
Date: Mon, 3 Mar 2014 09:49:03 -0800
Message-ID: <20140303174903.GA25804@atomide.com>
References: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
 <20140228171111.GA15399@atomide.com>
 <1393667952.21887.15.camel@e37108.spectralink.com>
 <20140302173727.GB18496@atomide.com>
 <1393844735.2507.21.camel@e37108.spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62689 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaCCRtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 12:49:07 -0500
Content-Disposition: inline
In-Reply-To: <1393844735.2507.21.camel@e37108.spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?S=C3=B8rensen=2C?= Stefan <Stefan.Sorensen@spectralink.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* S=C3=B8rensen, Stefan <Stefan.Sorensen@spectralink.com> [140303 03:08=
]:
> On Sun, 2014-03-02 at 09:37 -0800, Tony Lindgren wrote:
> > * S=C3=B8rensen, Stefan <Stefan.Sorensen@spectralink.com> [140301 0=
2:02]:
> > > On Fri, 2014-02-28 at 09:11 -0800, Tony Lindgren wrote:
> > > > * Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com> [14022=
4 02:12]:
> > > > > Currently INTC interrupts are handled using handle_level_irq =
which
> > > > > will acknowledge the interrupt before running the handler. If=
 a second
> > > > > interrupt is then asserted and this interrupt is disabled whi=
le
> > > > > running the first handler, the INTC will be brought into an
> > > > > inconsistent state.
> > > >=20
> > > > Hmm care to explain a bit more here if the second interrupt you=
're
> > > > talking about is the same interrupt or any interrupt in the sam=
e
> > > > interrupt bank? Is this limited to GPIO interrupts?
> > >=20
> > > I am seeing it with the cpsw driver on a custom board and on the
> > > beaglebone. When a tx irq is handled the cpsw irq handler disable=
s both
> > > the tx and the rx irqs, and if the rx irq was also asserted (i.e.=
 duplex
> > > traffic), this bug will trigger. Reproducing it is very simple, j=
ust hit
> > > a beaglebone with a flood ping and watch a function trace.
> >=20
> > OK so it's for the same interrupt. And that sounds like a good test=
 :)
>=20
> No, the tx and rx are separate interrupts, but the cpsw driver has a
> common handler.

Oh OK sounds like that's where the problem is :)
 =20
> > > > The reason I'm asking is because of the issues we've seen earli=
er
> > > > with not flushing posted writes from the interrupt handlers. In
> > > > those case the interrupt on the device gets acked too late with=
out
> > > > the read back call.
> > >=20
> > > I am not very familiar with the low level details of the irq hand=
ling, =20
> > > but am335x TRM states that a data synchronization barrier should =
be used
> > > after the ACK is posted to the INTC, and I don't see that anywher=
e in
> > > the code. Is this related?
> >=20
> > Well sort of, except DSB won't do it as it won't guarantee the writ=
e
> > gets to the device on the bus. So a readback from the device is nee=
ded
> > as only the order of reads and writes is guaranteed.
>=20
> I think that we are talking about two different scenarios, what I am
> seeing is that an interrupt is disabled while active on the INTC.

Yes sounds like these are different issues.
=20
> 	1. CPSW device asserts TX IRQ
> 	2. CPSW device asserts RX IRQ
> 	3. INTC interrupts CPU, TX IRQ marked as active
> 	4. omap_intc_handle_irq ACKs TX IRQ on the INTC
> 	5. INTC marks RX IRQ as active
> 	6. omap_intc_handle_irq calls cpsw_interrupt
> 	7. cpsw_interrupt disables RX+TX IRQ in CPSW device
> 	8. cpsw_interrupt disables RX+TX IRQ in INTC (the IRQs are masked)
> 	9.. omap_intc_handle_irq sees no unmasked IRQs are pending and retur=
ns
> 	10. INTC interrupts CPU, RX IRQ marked as pending
> 	11. omap_intc_handle_irq sees no unmasked IRQs are pending and retur=
ns
> 	12. Go to step 10
>=20
> The problem arises in step 8 where an active IRQ is masked. This will
> not make it inactive in the INTC but it will be cleared from the
> pending IRQ registers - this is the register that omap_intc_handle_ir=
q
> uses to decide which IRQ is active.

OK thanks for the info. Looking at your trace above it seems like the
two separate TX and RX INTC interrupts are not really treated as separa=
te
interrupts in the cpsw driver. It seems the real fix is to fix up the
cpsw interrupt handler so it's not racy. It seems that at least step 7
and 8 above should be handled separately for TX and RX based on the INT=
C
interrupts.

=46rom the INTC point of view we should just have standard level IRQ
handling for each interrupt, right? INTC does not need to know about
driver specific coordination between two separate interrupts.
=20
> > A good sanity check would be to find the related interrupt handler(=
s)
> > in the cpsw driver that do the write to the cpsw registers to ack
> > interrupts.
> >=20
> > Then check if there's a readback in the cpsw interrupt handler(s) o=
f
> > some harmless cpsw register after acking the interrupt(s) and befor=
e
> > doing return IRQ_HANDLED.
> >=20
> > If this fixes things without your patch, then we know it's a driver
> > issue and there's no need to debug it further :) The missing flush =
of
> > posted write usually shows up as a spurious interrupts with no stat=
us
> > in the device, but depending on the driver code handling of spuriou=
s
> > interrupts it may also have other side effects.
> >=20
> > I'm not too familiar with the cpsw driver so I can't do a test patc=
h
> > without digging into it further sorry. For similar examples, you
> > may want to grep for "flush posted write" and "OCP barrier" in the
> > kernel code.
>=20
> I tried this with an assortment of different CPSW registers - no chan=
ge.

OK thanks for trying. Based on your description above it seems that
the problem you found is not related to flushing posted writes even
though that issue might be there also once race issue is fixed.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
