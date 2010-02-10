From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 10 Feb 2010 09:25:44 -0800
Message-ID: <20100210172544.GU21755@atomide.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
 <20100127172526.GB23505@atomide.com>
 <d6a0f7aa1002100639n721d86fdn63520aecb056dd59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54509 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0BJRZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 12:25:09 -0500
Content-Disposition: inline
In-Reply-To: <d6a0f7aa1002100639n721d86fdn63520aecb056dd59@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

* Govindraj <govindraj.ti@gmail.com> [100210 06:36]:
> Tony,
>=20
> >
> >> +static void serial_omap_start_tx(struct uart_port *port)
> >> +{
> >> + =C2=A0 =C2=A0 struct uart_omap_port *up =3D (struct uart_omap_po=
rt *)port;
> >> +
> >> + =C2=A0 =C2=A0 if (up->use_dma && !(up->port.x_char)) {
> >> +
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct circ_buf *xmit =
=3D &up->port.state->xmit;
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int start =3D=
 up->uart_dma.tx_buf_dma_phys +
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (xmit->tail & (UART_XMIT_SIZE - 1));
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (uart_circ_empty(xm=
it) || up->uart_dma.tx_dma_state)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&(up->uart_d=
ma.tx_lock));
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->uart_dma.tx_dma_st=
ate =3D 1;
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&(up->uart=
_dma.tx_lock));
> >> +
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->uart_dma.tx_buf_si=
ze =3D uart_circ_chars_pending(xmit);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* It is a circul=
ar buffer. See if the buffer has wounded back.
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If yes it will=
 have to be transferred in two separate dma
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* transfers
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start + up->uart_d=
ma.tx_buf_size >=3D
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->uart_dma.tx_buf_dma_phys + UART_XMI=
T_SIZE)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 up->uart_dma.tx_buf_size =3D
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (up->uart_dma.tx_buf_dma_phys +
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 UART_XMIT_SIZE) - start;
> >> +
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (up->uart_dma.tx_dm=
a_channel =3D=3D 0xFF)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 omap_request_dma(up->uart_dma.uart_dma_tx,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "UART Tx DM=
A",
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)uar=
t_tx_dma_callback, up,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &(up->uart_=
dma.tx_dma_channel));
> >
> > You need to check the result from omap_request_dma. On a busy syste=
m
> > it's quite possible that all DMA channels are taken and you need to
> > dynamically fall back to PIO transfer instead.
> >
> > Looks like this function is easy to fix for that. Maybe you also
> > need to reprogram something in the UART for switching between DMA
> > and PIO?
>=20
> I explored the possibility of falling back to to Interrupt mode when =
we get an
> -EBUSY signal from request dma.
>=20
> It is quite complex, as we set DMA mode in FCR [Fifo control register=
]
> and FCR can be configured only when "the baud clock is not running
> (DLL_REG and DLH_REG set to 0)."
>=20
> So we need to reconfigure complete register set since setting DLL and
> DLH to zero means
> we need to reconfigure for baudrate again this would affect the mcr
> configuration and other
> flow control configuration which is set. Thus increasing the
> complexity of switching
> to interrupt mode.

Sure, that's what I figured too.. How about make the reconfigure functi=
on
non __init for that?

Sounds like it will also be needed if we want to power off the uart
for off-idle too.

This is quite a critical driver to get right, it's the only debug
console we have in most cases.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
