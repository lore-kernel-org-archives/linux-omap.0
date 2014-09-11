From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Thu, 11 Sep 2014 13:42:35 +0200
Message-ID: <54118AAB.2010205@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140911111721.GB17476@xps8300>
Sender: linux-serial-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 09/11/2014 01:17 PM, Heikki Krogerus wrote:
>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/825=
0/8250.h
>> index fbed1636e9c4..09489b391568 100644
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -82,6 +82,9 @@ struct serial8250_config {
>>  #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO =
enabled */
>>  #define UART_BUG_DMA_RX	(1 << 5)	/* UART needs DMA RX req before th=
ere is
>>  					   data in FIFO */
>> +#define UART_BUG_DMA_TX	(1 << 6)	/* UART needs one byte in FIFO for
>> +					   kickstart */
>=20
> I don't think we should go ahead with this patch. I'm pretty sure
> this is AM335 specific problem, or at least limited to only few
> platforms. And I don't think we should take any more "BUG" flags.
>=20
> We should add hooks like tx_dma and rx_dma to struct uart_8250_dma so
> that the probe drivers can replace serial8250_tx_dma and
> seria8250_rx_dma, like I think Alan already suggested.

Okay. Wasn't aware that Alan already suggested that.
I also need a watchdog timer for TX since it seems that on omap3 the
DMA engine suddenly forgets to continue with DMA=E2=80=A6

If this is really what we want, I would need to refactor a few things=E2=
=80=A6

> Let's keep serial8250_tx_dma/rx_dma as the default, and not add any
> quirks to them. Only if there is a very common case should it be
> handled in those. The case of RX req needing to be sent before data i=
n
> FIFO maybe one of those, but I'm no sure.

keep in mind that both (RX & TX bugs/hacks) need also a bit of handling
in the 8250-core so it works together (like the tx_err member so we
fall back to manual xmit)

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
