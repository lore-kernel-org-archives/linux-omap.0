From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap-serial RX DMA polling?
Date: Tue, 24 Jan 2012 09:00:21 +0000
Message-ID: <20120124090021.GQ16726@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com> <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com> <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com> <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com> <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com> <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com> <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51817 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab2AXJAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 04:00:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Govindraj <govindraj.ti@gmail.com>, khilman@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Tue, Jan 24, 2012 at 12:58:57AM -0700, Paul Walmsley wrote:
> On Tue, 24 Jan 2012, Govindraj wrote:
>=20
> > On Tue, Jan 24, 2012 at 1:18 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
> > > On Mon, 23 Jan 2012, Govindraj wrote:
> > >> On Mon, Jan 23, 2012 at 4:17 PM, Paul Walmsley <paul@pwsan.com> =
wrote:
> > >
> > > The point is that if you want tty_insert_flip_string() to be call=
ed after
> > > every character is received, there seems little point in using RX=
 DMA.
> > > It should be less efficient than PIO. =A0And the current way that=
 it is used
> > > is pointless from a power management point of view.
> >=20
> > Yes, Its between power and performance, current way gives a better
> > response for most devices
>=20
> That seems rather unlikely.  And I don't agree that there is a balanc=
e to=20
> be struck in this case.  Compared to a correctly-working RX PIO path,=
 the=20
> RX DMA in the current driver is likely to be much worse in energy=20
> consumption, and to be equal at best in receive latency.
>=20
> In a correctly-working RX PIO path, the driver is going to receive an=
=20
> interrupt the moment the data is ready to be transferred from the FIF=
O. =20

That's hellishly inefficient.  In a correctly working RX PIO path with
=46IFO, this is how most hardware is designed to work:

- The UART receives a character.  It places it into its FIFO, and it st=
arts
  a timer based on the bit rate.
- If another character is being received, this will be received and pla=
ced
  into the FIFO.  The timer is restarted.  This continues until the FIF=
O
  hits the watermark level which raises the receive interrupt.
- If no character is received, the timer eventually expires and a
  receive timeout interrupt is raised instead.

Generally, what you want for transmit is to wait for the TX FIFO to
drain to maybe half full, and then reload it until it is completely
full.

=46or the RX FIFO, you want to set the watermark such that you get a
decent number of bytes in there before the receive interrupt is
raised, but not soo many that an overrun is likely.

One of the point of having FIFOs is that they batch up the transmit and
receive activity to make it more efficient at servicing the UART.

Setting the FIFO levels to one character virtually negates the point
of having FIFOs - there is no point setting the TX FIFO to raise an
interrupt when there's one character space left.  As has already been
reported, this just puts the interrupt rate up, and means you waste a
lot more CPU (or bus) time servicing the transmit path.

As for RX DMA vs RX PIO, that depends on the UART (I don't know how
OMAPs UARTs behave.)  To sanely use RX DMA, you need the UART to raise
the RX timeout interrupt after characters have been offloaded by the
RX DMA.  Lets saying that RX FIFO is 32 bytes deep, and it's set to
raise the RX DMA request at 16 bytes full.  If you program the DMA
controller to burst 16 bytes off the RX FIFO, you'll empty it and
it'll never raise the RX timeout interrupt.  So you'll need to know
how many characters you're expecting.

If on the other hand you burst 8 bytes off the RX FIFO, you'll leave
8 bytes in the FIFO.  If the UART works properly, it will raise an
RX timeout interrupt after N bit periods where the RX line is inactive.

What that means is that during a burst of RX activity, your DMA takes
the strain of receiving characters, and you process those characters
when either the RX buffer becomes full or when there's a pause in
reception.  This gives good efficiency during bursts while maintaining
interactivity - to the same levels as that expected by RX PIO using
the FIFO.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
