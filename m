From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap-serial: transmission of x-char with DMA (and other issues)
Date: Mon, 16 Apr 2012 12:19:53 +0100
Message-ID: <20120416111953.GI25053@n2100.arm.linux.org.uk>
References: <20120413104111.GF25053@n2100.arm.linux.org.uk> <CAMrsUd+Wr=txEKSa=R0ybbd2k5Wue=KZzt82ZMtszL=7_moRLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMrsUd+Wr=txEKSa=R0ybbd2k5Wue=KZzt82ZMtszL=7_moRLA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 16, 2012 at 04:39:09PM +0530, Raja, Govindraj wrote:
> On Fri, Apr 13, 2012 at 4:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Can someone tell me how this works with the current omap-serial dri=
ver
> > please? =A0It looks to me like this has been broken when DMA suppor=
t was
> > added to the driver.
>=20
> Yes x-char transmission in dma case is broken will post a patch to fi=
x this.

Looking at the facilities of the OMAP UART hardware and the behaviour o=
f
the DMA hardware, I don't think we have an option to manually insert an
x-char into the data stream.  We certainly can't pause TX DMA at the
DMA hardware without the DMA hardware aborting and flushing its FIFO,
and the UART has no way to temporarily suspend requesting DMA service.

So, I think we actually need a pair of new hooks from uart_throttle()
and uart_unthrottle() for these automatic flow control UARTs which
disable the RX FIFO being read (iow, disable RX interrupts if using PIO
or RX DMA if using DMA.)  The RX FIFO will then fill, and if the waterm=
arks
are set correctly along with hardware-assisted flow control, the UART
will send the XOFF or deassert RTS for us automatically.

At least with RX DMA (which is hardware source synchronised), the DMA
hardware will apparantly drain its FIFOs to memory when disabled, rathe=
r
than aborting and discarding its FIFO contents.

> > Moreover, please look at the probe function error paths. =A0They se=
em to
> > be lacking any kind of realistic cleanup, so are a potential memory=
 leak.
>=20
> I thought this is fixed in 3.4-rc3 with this commit:
>=20
> commit 388bc26226807fbcf4c626b81bb17a2e74aa4b1b
> Author: Shubhrajyoti D <shubhrajyoti@ti.com>
> Date:   Wed Mar 21 17:22:22 2012 +0530
>=20
>     omap-serial: Fix the error handling in the omap_serial probe

Well, it also depends on where I base my branches for development - and
if fixes go in after I've started then these things get missed until I
rebase those branches.

If it's already fixed, then great.

> > Then there's the issue of fiddling with the xmit buffer so that it'=
s
> > using coherent memory in the startup and shutdown functions (why? =A0=
when
> > other serial drivers cope just fine without doing this). =A0If we w=
ant to
> > use DMA coherent memory there, there should be a clean way to do th=
is,
> > rather than going behind the upper layers.
>=20
> Okay I will have a look into this.

I've already cooked up a patch to handle this which adds new hooks from
serial_core into the low level driver for xmit buffer allocation/freein=
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
