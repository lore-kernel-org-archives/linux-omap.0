From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 11/13 v2] serial: Add OMAP high-speed UART driver
Date: Thu, 23 Sep 2010 16:42:47 +0530
Message-ID: <AANLkTimi=Sqz2xNheXu2-3xD9MPN6+TdwhEM=TF6XN3B@mail.gmail.com>
References: <37596.172.24.137.131.1285168477.squirrel@dbdmail.itg.ti.com>
	<A24693684029E5489D1D202277BE894472767DA6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE894472767DA6@dlee02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Sergio,

Thanks for the review.
Reply inlined.

<SNIP>

>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + */
>> +
>> +#ifndef __OMAP_SERIAL_H__
>> +#define __OMAP_SERIAL_H__
>> +
>> +#include <linux/serial_core.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <plat/control.h>
>> +#include <plat/mux.h>
>> +
>> +#define DRIVER_NAME =A0"omap-hsuart"
>
> Is there a reason why you keep 2 names in the driver?
>
> You use this for the platform_driver struct "serial_omap_driver",
> Meanwhile you send a driver name of "OMAP-SERIAL" to uart_driver stru=
ct...
>
> Also IMHO, if you're just going to use this once, then it makes no se=
nse to
> have this macro.


One is the driver name other one the device name
Driver name passed to platform registration the other to tty
interface for tty interface creation.

Driver_name will be shared between two layers one for platform_device_a=
dd
and platform device_register as name parameter requires this.
Thus defined a macro to share between two files.
omap-serial.c and */mach-omap2/serial.c
as far as device name is concerned i find it readable with
macro as done in other serial drivers.

>
>> +
>> +/*
>> + * Use tty device name as ttyO, [O -> OMAP]
>> + * in bootargs we specify as console=3DttyO0 if uart1
>> + * is used as console uart.
>> + */
>> +#define OMAP_SERIAL_NAME =A0 =A0 "ttyO"
>> +
>> +#define OMAP_MDR1_DISABLE =A0 =A00x07
>> +#define OMAP_MDR1_MODE13X =A0 =A00x03
>>
>>

<SNIP>

#include <linux/serial_core.h>
>> +
>> +#include <asm/irq.h>
>
> Shouldn't this be:
>
> #include <linux/irq.h>
>
> ?

Yes.

<SNIP>

>> +
>> +/**
>> + * serial_omap_get_divisor() - calculate divisor value
>
> I heard sometime back a suggestion that kernel doc type comments aren=
't
> required for static private functions, as nobody is supposed to care =
about
> this driver internals.
>
> Also, the parenthesis after the function name shouldn't be there.

OK.


>> +
>> +static void serial_omap_enable_ms(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>
> Isn't this a bit error prone?
>
> I mean, How would you ensure that the uart_port and uart_omap_port st=
ructs
> Will remain compatible?
>

We register with serial core layer with our structure and serial core l=
ayer is
the one thats does an call to this func with the parameters.
So the data is available from serial core layer this its aligned with
the serial layer
All the serial driver do in this manner to get driver specific port
data from serial
port data.

>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pd=
ev->id);
>> + =A0 =A0 up->ier |=3D UART_IER_MSI;
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> +}
>> +
>> +static void serial_omap_stop_tx(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>
> Same here and below functions that does the same.

As replied above.

<SNIP>

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D serial_in(up, UART_=
RX);
>>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (lsr & UART_LSR_PE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.parity++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lsr & UART_LSR_FE=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.frame++;
>
> AFAIK, Above 2 if conditions require brackets aswell, to keep consist=
ency
> And ease of reading the whole 3 cases as part of a single chain of
> comparisons.
>
> Also, add a space here, as below if condition doesn't seem to be rela=
ted.

OK.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lsr & UART_LSR_OE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.overrun++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Mask off conditions w=
hich should be ignored.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsr &=3D up->port.read_sta=
tus_mask;
>> +
>> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->port.line =3D=3D u=
p->port.cons->index) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Recover=
 the break flag from console xmit */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsr |=3D u=
p->lsr_break_flag;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lsr_br=
eak_flag =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lsr & UART_LSR_BI)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D T=
TY_BREAK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lsr & UART_LSR_PE=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D T=
TY_PARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lsr & UART_LSR_FE=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D T=
TY_FRAME;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uart_handle_sysrq_char(&up->port, ch))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore_char;
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_insert_char(&up->port, lsr, UART_LSR_=
OE, ch, flag);
>> +ignore_char:
>> + =A0 =A0 =A0 =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> + =A0 =A0 } while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count=
-- > 0));
>> + =A0 =A0 spin_unlock(&up->port.lock);
>> + =A0 =A0 tty_flip_buffer_push(tty);
>> + =A0 =A0 spin_lock(&up->port.lock);
>
> This is very odd... So you unlock a spinlock, and then lock it back?
>
> Have you activated spinlock debug in menuconfig to test locking?

Again as said earlier.
This lock is maintained by the serial core layer.
We do not maintain it or initialize it.

It comes from the interface registration and needs to be used as said b=
y the
serial layer.
Common across serial drivers.
Reference 8250.c serial driver as this driver is derived from 8250
as said below the licensing in driver file.

>
>> +}
>> +
>> +static void transmit_chars(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 struct circ_buf *xmit =3D &up->port.state->xmit;
>> + =A0 =A0 int count;
>> +
>> + =A0 =A0 if (up->port.x_char) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TX, up->port.x_char);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.x_char =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 count =3D up->port.fifosize / 4;
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TX, xmit->buf[xmit->ta=
il]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 xmit->tail =3D (xmit->tail + 1) & (UART_XM=
IT_SIZE - 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.tx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 } while (--count > 0);
>> +
>> + =A0 =A0 if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(&up->port);
>> +
>> + =A0 =A0 if (uart_circ_empty(xmit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
>> +}
>> +
>> +static inline void serial_omap_enable_ier_thri(struct uart_omap_por=
t *up)
>> +{
>> + =A0 =A0 if (!(up->ier & UART_IER_THRI)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_THRI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 }
>> +}
>> +
>> +static void serial_omap_start_tx(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 struct circ_buf *xmit;
>> + =A0 =A0 unsigned int start;
>> + =A0 =A0 int ret =3D 0;
>
> This var is useless.
>
>> +
>> + =A0 =A0 if (!up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_enable_ier_thri(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (up->uart_dma.tx_dma_used)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 xmit =3D &up->port.state->xmit;
>> +
>> + =A0 =A0 if (up->uart_dma.tx_dma_channel =3D=3D OMAP_UART_DMA_CH_FR=
EE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_request_dma(up->uart_dma.uart=
_dma_tx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "UART Tx D=
MA",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)ua=
rt_tx_dma_callback, up,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(up->uart=
_dma.tx_dma_channel));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
>
> As you're not using the return value anywhere, why not doing this ins=
tead?

Yes can be done,

IMHO its looks simpler with ret value populated then do a comparison
than having multi line statements for a comparison.


>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (omap_request_dma(up->uart_dma.uart=
_dma_tx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"UART =
Tx DMA",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void =
*)uart_tx_dma_callback, up,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&(up->=
uart_dma.tx_dma_channel)) < 0) {
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_enable_ier_thr=
i(up);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
<SNIP>

>a_channel);
>> +}
>> +
>> +static unsigned int check_modem_status(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 int status;
>
> This should be unsigned int.

Yes.

>
> Also, space here.

OK.

>
>> + =A0 =A0 status =3D serial_in(up, UART_MSR);
>> +
>> + =A0 =A0 status |=3D up->msr_saved_flags;
>> + =A0 =A0 up->msr_saved_flags =3D 0;
>> +
>> + =A0 =A0 if ((status & UART_MSR_ANY_DELTA) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return status;
>
> Space here too.

OK.

>
>> + =A0 =A0 if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI =
&&
>> +}
>> +
>> +/**
>> + * serial_omap_irq() - This handles the interrupt from one port
>> + * @irq: uart port irq number
>> + * @dev_id: uart port info
>> + */
>> +static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D dev_id;
>> + =A0 =A0 unsigned int iir, lsr;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 iir =3D serial_in(up, UART_IIR);
>> + =A0 =A0 if (iir & UART_IIR_NO_INT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>
> You're in interrupt context already, why do you need to disable inter=
rupts?

Transmit and receive operations do port specific operations
hence need to do this, all this comes straight from the way
done 8250 with port handle func.

>
>> + =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> + =A0 =A0 if (iir & UART_IIR_RLSI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lsr & UART_LSR_DR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 receive_ch=
ars(up, &lsr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~(UART_IER_RD=
I | UART_IER_RLSI);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, u=
p->ier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (serial_omap_start_rxdm=
a(up) !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lsr & =
UART_LSR_DR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 receive_chars(up, &lsr);
>
> Shouldn't be simpler to just do:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((serial_omap_start=
_rxdma(up) !=3D 0) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(lsr & UART_LSR_DR))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiv=
e_chars(up, &lsr);
>
> ?

Yes fine can adapt to this.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>
>> +

<SNIP>

>> + =A0 =A0 serial_omap_clear_fifos(up);
>> + =A0 =A0 /* For Hardware flow control */
>> + =A0 =A0 serial_out(up, UART_MCR, UART_MCR_RTS);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Clear the interrupt registers.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 (void) serial_in(up, UART_LSR);
>> + =A0 =A0 if (serial_in(up, UART_LSR) & UART_LSR_DR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void) serial_in(up, UART_RX);
>> + =A0 =A0 (void) serial_in(up, UART_IIR);
>> + =A0 =A0 (void) serial_in(up, UART_MSR);
>
> Why the void typecasting?
>

To ignore read return value.
as we are not interested in return value here.

>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Now, initialize the UART
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> + =A0 =A0 /*

<SNIP>

>> +
>> +static int
>> +serial_omap_verify_port(struct uart_port *port, struct serial_struc=
t
>> *ser)
>> +{
>> + =A0 =A0 /* we don't want the core code to modify any port params *=
/
>> + =A0 =A0 dev_dbg(port->dev, "serial_omap_verify_port+\n");
>> + =A0 =A0 return -EINVAL;
>
> Is this some sort of hack?
>
> If so, it should be marked as such.
>

This can be used to probe the individual port status
if we need so, but we do not have any such functionality
from controller specific stuff that can be added here.
Its one the interface that needs to be passed to serial core.

>> +}
>> +
>> +static const char *
>> +serial_omap_type(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_type+%d\n", up->pdev->i=
d);
>> + =A0 =A0 return up->name;
>> +}
>> +
>> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> +
>> +static struct uart_omap_port *serial_omap_console_ports[4];
>> +
>> +static struct uart_driver serial_omap_reg;
>> +
>> +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>> +
>> +static inline void wait_for_xmitr(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 unsigned int status, tmout =3D 10000;
>> +
>> + =A0 =A0 /* Wait up to 10ms for the character(s) to be sent. */
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D serial_in(up, UART_LSR);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_LSR_BI)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lsr_break_flag =3D UAR=
T_LSR_BI;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (--tmout =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 } while ((status & BOTH_EMPTY) !=3D BOTH_EMPTY);
>> +
>> + =A0 =A0 /* Wait up to 1s for flow control if necessary */
>> + =A0 =A0 if (up->port.flags & UPF_CONS_FLOW) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmout =3D 1000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (tmout =3D 1000000; tmout; tmout--) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int msr =3D seria=
l_in(up, UART_MSR);
>
> Space here.

OK.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->msr_saved_flags |=3D m=
sr & MSR_SAVE_FLAGS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msr & UART_MSR_CTS)
<SNIP>

>> + =A0 =A0 if (options)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &parity=
, &bits, &flow);
>> +
>> + =A0 =A0 r =3D uart_set_options(&up->port, co, baud, parity, bits, =
flow);
>> +
>> + =A0 =A0 return r;
>
>
> You could just do:
>
> =A0 =A0 =A0 =A0return uart_set_options(&up->port, co, baud, parity, b=
its, flow);
>
> And get rid of var "r".


OK.

>
>> +}

<SNIP>

>> + =A0 =A0 up->port.irqflags =3D omap_up_info->irqflags;
>> + =A0 =A0 up->port.uartclk =3D omap_up_info->uartclk;
>
> Where is up->port.lock being initialized?

As said earlier port lock comes from serial core
needs to used for port specific operation as said by
the interface we do not initialize or maintain it
we only use it in driver.

=46or further reference on serial driver ops and usage:
/Documentation/serial/driver

---
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
