From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Use handle_fasteoi_irq for INTC interrupt
 handling
Date: Thu, 6 Mar 2014 10:15:58 -0800
Message-ID: <20140306181557.GA1381@atomide.com>
References: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
 <20140228171111.GA15399@atomide.com>
 <1393667952.21887.15.camel@e37108.spectralink.com>
 <20140302173727.GB18496@atomide.com>
 <1393844735.2507.21.camel@e37108.spectralink.com>
 <20140303174903.GA25804@atomide.com>
 <1394116365.2785.11.camel@e37108.spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55697 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCFSQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Mar 2014 13:16:03 -0500
Content-Disposition: inline
In-Reply-To: <1394116365.2785.11.camel@e37108.spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?S=C3=B8rensen=2C?= Stefan <Stefan.Sorensen@spectralink.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* S=C3=B8rensen, Stefan <Stefan.Sorensen@spectralink.com> [140306 06:36=
]:
> On Mon, 2014-03-03 at 09:49 -0800, Tony Lindgren wrote:
> > > 	1. CPSW device asserts TX IRQ
> > > 	2. CPSW device asserts RX IRQ
> > > 	3. INTC interrupts CPU, TX IRQ marked as active
> > > 	4. omap_intc_handle_irq ACKs TX IRQ on the INTC
> > > 	5. INTC marks RX IRQ as active
> > > 	6. omap_intc_handle_irq calls cpsw_interrupt
> > > 	7. cpsw_interrupt disables RX+TX IRQ in CPSW device
> > > 	8. cpsw_interrupt disables RX+TX IRQ in INTC (the IRQs are maske=
d)
> > > 	9.. omap_intc_handle_irq sees no unmasked IRQs are pending and r=
eturns
> > > 	10. INTC interrupts CPU, RX IRQ marked as pending
> > > 	11. omap_intc_handle_irq sees no unmasked IRQs are pending and r=
eturns
> > > 	12. Go to step 10
> > >=20
> > > The problem arises in step 8 where an active IRQ is masked. This =
will
> > > not make it inactive in the INTC but it will be cleared from the
> > > pending IRQ registers - this is the register that omap_intc_handl=
e_irq
> > > uses to decide which IRQ is active.
> >=20
> > OK thanks for the info. Looking at your trace above it seems like t=
he
> > two separate TX and RX INTC interrupts are not really treated as se=
parate
> > interrupts in the cpsw driver. It seems the real fix is to fix up t=
he
> > cpsw interrupt handler so it's not racy. It seems that at least ste=
p 7
> > and 8 above should be handled separately for TX and RX based on the=
 INTC
> > interrupts.
>=20
> Looking in drivers/net/ethernet, it looks like a quite common pattern
> is to handle both RXx and TX interrupts with the same handler, which
> will disable both interrupts and then hand off to napi. The cpsw driv=
er
> works the same way, so shouldn't this work on omap?

Hmm yes at least disable_irq should work no matter when it's called.
=20
> > From the INTC point of view we should just have standard level IRQ
> > handling for each interrupt, right? INTC does not need to know abou=
t
> > driver specific coordination between two separate interrupts.
>=20
> The problem is that the INTC is not doing 100% level IRQ handling
> combined with the way we handle the INTC during interrupts. When a IR=
Q
> has become active on the INTC it will stay active until we acknowledg=
e
> it, even if it is masked or de-asserted.

Yes it's starting to sound that INTC has an issuerecovering from the
spurious interrupts.
=20
> My patch does not fix the problem when the active interrupt was
> de-asserted, so I am looking into other ways of dealing with it.

OK.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
