From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 3/3] dma: omap-dma: add support for pause of
 non-cyclic transfers
Date: Tue, 11 Aug 2015 13:30:57 +0100
Message-ID: <20150811123057.GE7576@n2100.arm.linux.org.uk>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-4-git-send-email-bigeasy@linutronix.de>
 <55C9E464.2060404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C9E464.2060404@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, peter@hurleysoftware.com, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 11, 2015 at 03:02:44PM +0300, Peter Ujfalusi wrote:
> On 08/07/2015 11:00 PM, Sebastian Andrzej Siewior wrote:
> > +	/*
> > +	 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
> > +	 * From the AM572x TRM, 16.1.4.18 Disabling a Channel During Tran=
sfer:
> > +	 * "When a channel is disabled during a transfer, the channel und=
ergoes
> > +	 * an abort, unless it is hardware-source-synchronized =E2=80=A6"=
=2E
> > +	 * A source-synchronised channel is one where the fetching of dat=
a is
> > +	 * under control of the device. In other words, a device-to-memor=
y
> > +	 * transfer. So, a destination-synchronised channel (which would =
be a
> > +	 * memory-to-device transfer) undergoes an abort if the the CCR_E=
NABLE
> > +	 * bit is cleared.
> > +	 * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the c=
hannel
> > +	 * aborts immediately after completion of current read/write
> > +	 * transactions and then the FIFO is cleaned up." The term "clean=
ed up"
> > +	 * is not defined. TI recommends to check that RD_ACTIVE and WR_A=
CTIVE
> > +	 * are both clear _before_ disabling the channel, otherwise data =
loss
> > +	 * will occur.
> > +	 * The problem is that if the channel is active, then device acti=
vity
> > +	 * can result in DMA activity starting between reading those as b=
oth
> > +	 * clear and the write to DMA_CCR to clear the enable bit hitting=
 the
> > +	 * hardware. If the DMA hardware can't drain the data in its FIFO=
 to the
> > +	 * destination, then data loss "might" occur (say if we write to =
an UART
> > +	 * and the UART is not accepting any further data).
>=20
> I don't know if you have checked it, but probably the TX DMA could be=
 also
> used when the PRZEFETCH is disabled for the channel? Just a guess

The docs aren't very clear on that... and iirc Santosh's reply didn't
suggest that the prefetch bit had any influence on this behaviour.  Giv=
en
the wording in the documentation which seems to be quite explicit about
the conditions, and it omits talking about the prefetch bit, I can only
assume that the prefetch bit has no influence over this behaviour.

=46or example, what happens if the DMA to the device has started - the
device has raised its DMA request line.  The DMA controller has then go=
ne
to memory and has fetched some data and incremented the source address.
Meanwhile, we've cleared the ENABLE bit.  What happens then?  Does the
DMA controller drain the read data to the device, or does it "clean up"
the FIFO by discarding the data?

Given that the conditions under which the FIFO is drained to the
destination are very specific, and which explicitly excludes destinatio=
n-
synchronised transfers, the only conclusion that's possible without
knowing the implementation intimately is that the FIFO is "cleaned up"
which suggests that it's discarded rather than drained to the destinati=
on.

As this DMA controller is in all of the OMAP devices and similar, I
don't think we can rely on the behaviour of any one implementation
either - we don't know what the differences are between the
implementations in different generations of devices without TI providin=
g
more detailed documentation in this area across their various devices.

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
