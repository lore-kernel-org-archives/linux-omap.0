From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Fri, 19 Sep 2014 13:22:12 +0300
Message-ID: <20140919102212.GA31784@xps8300>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300>
 <54118AAB.2010205@linutronix.de>
 <5419B825.5000201@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5419B825.5000201@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 17, 2014 at 06:34:45PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 09/11/2014 01:42 PM, Sebastian Andrzej Siewior wrote:
> >> We should add hooks like tx_dma and rx_dma to struct uart_8250_dma=
 so
> >> that the probe drivers can replace serial8250_tx_dma and
> >> seria8250_rx_dma, like I think Alan already suggested.
> >=20
> > Okay. Wasn't aware that Alan already suggested that.
> > I also need a watchdog timer for TX since it seems that on omap3 th=
e
> > DMA engine suddenly forgets to continue with DMA=E2=80=A6
> >=20
> > If this is really what we want, I would need to refactor a few thin=
gs=E2=80=A6
> >=20
> >> Let's keep serial8250_tx_dma/rx_dma as the default, and not add an=
y
> >> quirks to them. Only if there is a very common case should it be
> >> handled in those. The case of RX req needing to be sent before dat=
a in
> >> FIFO maybe one of those, but I'm no sure.
> >=20
> > keep in mind that both (RX & TX bugs/hacks) need also a bit of hand=
ling
> > in the 8250-core so it works together (like the tx_err member so we
> > fall back to manual xmit)
>=20
> Done. I've kept the RX workarounds in the 8250_dma and moved the TX
> part into the omap driver.
> I needed to add the 8250_core pieces of patch #10 [0]. Now If you say=
,
> couldn't this done in an other way then I could move the RX workaroun=
ds
> pieces to the omap driver as well as the interrupt routine. Any
> preferences?
>=20
> [0] [PATCH 10/16] tty: serial: 8250_dma: optimize the xmit path due t=
o
>     UART_BUG_DMA_TX

Couldn't you just replace the handle_irq with a custom irq routine in
the omap driver like you did with set_termios? Where you would do
those tricks and/or call serial8250_handle_irq()?

The 8250_core changes in that patch #10 only modify
serial8250_handle_irg right?


Cheers,

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
