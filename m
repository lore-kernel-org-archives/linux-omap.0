From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Wed, 5 Nov 2014 14:43:23 -0500
Message-ID: <20141105194323.GI24112@csclub.uwaterloo.ca>
References: <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
 <20141105011506.GG24112@csclub.uwaterloo.ca>
 <5459DBB7.1090702@linutronix.de>
 <20141105153307.GN24110@csclub.uwaterloo.ca>
 <20141105162024.GH24112@csclub.uwaterloo.ca>
 <545A50BB.2020307@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <545A50BB.2020307@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 05, 2014 at 05:30:51PM +0100, Sebastian Andrzej Siewior wro=
te:
> On 11/05/2014 05:20 PM, Lennart Sorensen wrote:
> > On Wed, Nov 05, 2014 at 10:33:15AM -0500, Lennart Sorensen wrote:
> >> Two systems ran 16 hours each so far with no issues.  Pushed 170MB=
 of
> >> data through the pair of serial ports on one system at 230400.
> >=20
> > The console on uart3 doesn't appear to be using the dma assuming th=
e
> > values in /sys for the dma controller and bytes transferred mean an=
ything.
> > It does mention in dmesg that it allocated dma channels for uart3 t=
hough.
>=20
> Then it should use it :)

I managed to get something dma related on uart3.  But it isn't happy:

[   95.577401] DMA misaligned error with device 53
repeated many times.

I wonder if the dma support isn't quite working for the omap572x yet in
this tree (ti's 3.12.y tree), or maybe it is picky and the driver still
needs a bit of work.

I have had no issues on uart7 and 8 without dma.

> There is omap_8250_tx_dma() and omap_8250_rx_dma(). Both setup
> callbacks (the rx+tx _complete). Upon successful DMA transfer you
> should see them invoked with bytes transfered (>0).
> For RX transfer you need at least trigger bytes in the FIFO within a
> given time frame (I think it was 46 bytes and the delay may be up to =
2
> bytes). If you miss this then DMA for RX won't wire and you purge the
> FIFO manually via "timeout-interrupt" (the callback will be invoked
> with an error condition and 0 bytes).
>=20
> Assuming this works for you then one should figure out why the counte=
rs
> in /sys are not updated=E2=80=A6

--=20
Len Sorensen
