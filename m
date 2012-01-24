From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap-serial RX DMA polling?
Date: Tue, 24 Jan 2012 03:47:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201240210310.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221718190.26641@utopia.booyaka.com> <CAAL8m4wcSfhjxg0Lyo-W7DQ85rikb6asRds95hwQQNTDXe2YKQ@mail.gmail.com> <alpine.DEB.2.00.1201230304310.29673@utopia.booyaka.com> <CAAL8m4wBuFQYkyFUwNWrUZTBWuQHggy=y3Oi=6DBHNB_rqU9tA@mail.gmail.com>
 <alpine.DEB.2.00.1201231228310.29673@utopia.booyaka.com> <CAAL8m4zE6wD67GCeVe9BOBZ=5yrCkrXUUu26y2GAXrdiDD3R8g@mail.gmail.com> <alpine.DEB.2.00.1201240010100.29673@utopia.booyaka.com> <20120124090021.GQ16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120124090021.GQ16726@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Govindraj <govindraj.ti@gmail.com>, khilman@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 24 Jan 2012, Russell King - ARM Linux wrote:

> On Tue, Jan 24, 2012 at 12:58:57AM -0700, Paul Walmsley wrote:
> 
> > In a correctly-working RX PIO path, the driver is going to receive an 
> > interrupt the moment the data is ready to be transferred from the FIFO.  
> 
> That's hellishly inefficient.  

If the point is to minimize the receive latency, as Govindraj described 
earlier, then setting an RX FIFO threshold to one byte is the way to go.  
It certainly seems preferable to the use of a DMA RX path with a 1 
microsecond polling timer.  Ideally this would be something that the 
serial user could tune.

> Generally, what you want for transmit is to wait for the TX FIFO to
> drain to maybe half full, and then reload it until it is completely
> full.

Interesting rule of thumb.  For OMAP there are also power management 
considerations.  For example, if we can estimate the maximum amount of 
time it will take for the CPU to refill the transmit FIFO, then the TX 
FIFO threshold can be adjusted down to reduce the number of 
wakeups/interrupts needed to transmit a buffer.

In fact from a narrow PM perspective, the ideal TX FIFO threshold would 
basically be zero: to allow the entire FIFO to drain before waking the CPU 
back up to refill it.  There's no data loss restriction as there is with 
the RX FIFO.  Of course, many serial users couldn't tolerate such an 
setting and still work acceptably.  It would be nice if the driver could 
allow serial users to override the estimate that it generates.

> For the RX FIFO, you want to set the watermark such that you get a
> decent number of bytes in there before the receive interrupt is
> raised, but not soo many that an overrun is likely.

One other constraint.  If the RX FIFO threshold is set too high, then the 
CPU is effectively prevented from entering a deep sleep state, since the 
CPU has to be able to wake up in time to prevent an RX overrun.  The lower 
the RX FIFO threshold, the more time the CPU has to wake up, and the 
deeper the sleep state the CPU can enter.

> One of the point of having FIFOs is that they batch up the transmit and
> receive activity to make it more efficient at servicing the UART.

Yep.  Also, another point is to allow the servicer to enter a low power 
state while the FIFOs fill or drain.

> Setting the FIFO levels to one character virtually negates the point of 
> having FIFOs - there is no point setting the TX FIFO to raise an 
> interrupt when there's one character space left.  As has already been 
> reported, this just puts the interrupt rate up, and means you waste a 
> lot more CPU (or bus) time servicing the transmit path.

In the case of this particular patchset, there was indeed a point to 
setting the TX FIFO to 1; it was to work around a hardware bug.  As the 
patch description stated, it's a pretty nasty penalty that is worth 
avoiding if at all possible[*].  I'm not endorsing that as an appropriate 
setting outside of a bug workaround.

> As for RX DMA vs RX PIO, that depends on the UART (I don't know how
> OMAPs UARTs behave.)  To sanely use RX DMA, you need the UART to raise
> the RX timeout interrupt after characters have been offloaded by the
> RX DMA.  Lets saying that RX FIFO is 32 bytes deep, and it's set to
> raise the RX DMA request at 16 bytes full.  If you program the DMA
> controller to burst 16 bytes off the RX FIFO, you'll empty it and
> it'll never raise the RX timeout interrupt.  So you'll need to know
> how many characters you're expecting.
>
> If on the other hand you burst 8 bytes off the RX FIFO, you'll leave
> 8 bytes in the FIFO.  If the UART works properly, it will raise an
> RX timeout interrupt after N bit periods where the RX line is inactive.
> 
> What that means is that during a burst of RX activity, your DMA takes
> the strain of receiving characters, and you process those characters
> when either the RX buffer becomes full or when there's a pause in
> reception.  This gives good efficiency during bursts while maintaining
> interactivity - to the same levels as that expected by RX PIO using
> the FIFO.

Well, Govindraj has some low-latency requirement, and no way to specify 
how many bytes he's expecting.  So if RX DMA is going to be used, the 
driver will still need some kind of timer to flush any bytes that could be 
stuck in the middle of a DMA transfer.  This still seems like a case where 
RX PIO would do a better job; no need for a timer, and immediate 
notification when a character arrives, if the threshold is set that way.

As far as the RX timeout goes, those don't seem to be delivered properly 
when the CPU is in a low-power state.  This is probably due to the 
previously-mentioned hardware bug, although it could be due to a driver 
bug.  So we may be out of luck there.  We (meaning the people working on 
OMAP) also need to figure out here what the OMAP UART RX timeout would 
theoretically be, since it doesn't appear to be documented.

Thanks for the comments.


- Paul

* There is another workaround for this bug under development here that
  shouldn't require changing the TX FIFO.  If it passes testing here, then 
  the TX FIFO of 1 shouldn't be needed.
