From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 10 Feb 2010 20:09:07 +0530
Message-ID: <d6a0f7aa1002100639n721d86fdn63520aecb056dd59@mail.gmail.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
	 <20100127172526.GB23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:41063 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0BJOjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 09:39:08 -0500
Received: by qw-out-2122.google.com with SMTP id 9so10854qwb.37
        for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 06:39:07 -0800 (PST)
In-Reply-To: <20100127172526.GB23505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Tony,

>
>> +static void serial_omap_start_tx(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 if (up->use_dma && !(up->port.x_char)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.state-=
>xmit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int start =3D up->uart_dma.tx_buf=
_dma_phys +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (xmit->tai=
l & (UART_XMIT_SIZE - 1));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit) || up->uart_dma.=
tx_dma_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&(up->uart_dma.tx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_state =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&(up->uart_dma.tx_lock));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D uart_circ_cha=
rs_pending(xmit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* It is a circular buffer. See if the b=
uffer has wounded back.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If yes it will have to be transferred=
 in two separate dma
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfers
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (start + up->uart_dma.tx_buf_size >=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.tx_buf_dma_phys + UART_XMIT_SIZE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->uart_=
dma.tx_buf_dma_phys +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_XMIT_=
SIZE) - start;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.tx_dma_channel =3D=3D 0xF=
=46)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_request_dma(up->uart_=
dma.uart_dma_tx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "UART Tx DMA",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (void *)uart_tx_dma_callback, up,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &(up->uart_dma.tx_dma_channel));
>
> You need to check the result from omap_request_dma. On a busy system
> it's quite possible that all DMA channels are taken and you need to
> dynamically fall back to PIO transfer instead.
>
> Looks like this function is easy to fix for that. Maybe you also
> need to reprogram something in the UART for switching between DMA
> and PIO?

I explored the possibility of falling back to to Interrupt mode when we=
 get an
-EBUSY signal from request dma.

It is quite complex, as we set DMA mode in FCR [Fifo control register]
and FCR can be configured only when "the baud clock is not running
(DLL_REG and DLH_REG set to 0)."

So we need to reconfigure complete register set since setting DLL and
DLH to zero means
we need to reconfigure for baudrate again this would affect the mcr
configuration and other
flow control configuration which is set. Thus increasing the
complexity of switching
to interrupt mode.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
