From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Thu, 4 Feb 2010 20:39:10 +0530 (IST)
Message-ID: <50326.192.168.10.89.1265296150.squirrel@dbdmail.itg.ti.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
    <20100128032242.GA9070@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758229Ab0BDPJO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 10:09:14 -0500
In-Reply-To: <20100128032242.GA9070@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>


Hi Olof,


>On Thu, Jan 28, 2010 at 8:52 AM, Olof Johansson <olof@lixom.net> wrote=
:
> Hi,
>
> Thanks for reposting this, it's been a while since the last review ro=
und
> so I've taken a closer look at it.
>
> Lots of comments below.
>
>
> -Olof
>
> On Wed, Jan 27, 2010 at 03:26:56PM +0530, Govindraj.R wrote:
>> >From 869dde60756b2115c35d97f8e2daf014cb1af08e Mon Sep 17 00:00:00 2=
001
>> From: Govindraj R <govindraj.raja@ti.com>
>> Date: Wed, 27 Jan 2010 14:57:58 +0530
>> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>>
>> This patch adds support for OMAP-HIGH SPEED UART Controller.
>>
>> It adds support for the following features:
>> 1. It supports Interrupt mode and DMA mode of operation.
>> 2. Supports Hardware flow control and software flow control.
>> 3. Debug Console support on all UARTs.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
>> ---
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0128 +++
>> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 23 +
>> =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 +
>> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 1349 +++++++++++++++++++++++++
>> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A03 +
>> =A05 files changed, 1504 insertions(+), 0 deletions(-)
>> =A0create mode 100755 arch/arm/plat-omap/include/plat/omap-serial.h
>> =A0create mode 100755 drivers/serial/omap-serial.c
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h
>
>> @@ -0,0 +1,128 @@
>> +/*
>> + * Driver for OMAP-UART controller.
>> + * Based on drivers/serial/8250.c
>> + *
>> + * Copyright (C) 2009 Texas Instruments.
>
> It's considered polite to duplicate the original copyright after the =
"based on" text.
>
> Also, 8250.c is v2-or-later, and this is v2-only. You shouldn't chang=
e the license
> without the original author's approval (i.e. it's more hassle than it=
 is worth).

Will retain as specified in 8250 driver.

>
>> + *
>> + * Authors:
>> + * =A0 Govindraj R =A0 =A0 <govindraj.raja@ti.com>
>> + * =A0 Thara Gopinath =A0<thara@ti.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public =
License
>> + * version 2. This program is licensed "as is" without any warranty=
 of any
>> + * kind, whether express or implied.
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
>> +
>> +/*
>> + * Use tty device name as ttyO, [O -> OMAP]
>> + * in bootargs we specify as console=3DttyO0 if uart1
>> + * is used as console uart.
>> + * Use Major 204 and minor 64.
>> + * This is necessary if we should coexist with the 8250 driver,
>> + * if we have an external TI-16C750 UART. Ex.ZOOM2/3 Boards.
>> + */
>
> Comments should document _why_ you do something, not _what_ you're
> doing. As such, the "Use Major 204 and minor 64" is redundant, it's
> obvious from looking at the lines below.
>
>> +
>> +#define OMAP_SERIAL_NAME =A0 =A0 "ttyO"
>> +#define OMAP_SERIAL_MAJOR =A0 =A0204
>> +#define OMAP_SERIAL_MINOR =A0 =A064
>
> Where did these numbers come from? 204/64 are listed as in use in
> Documentation/devices.txt. 213 is the first available minor there. (Y=
ou
> should also update that file).
>

I was referring to some custom uart soc driver files.
Most of them seemed to use in an similar fashion,

References:
drivers/serial/samsung.c
drivers/serial/timbuart.c
drivers/serial/uartlite.c

And many more which co-exist with 8250 driver.
Use in an similar way.

>> +
>> +/*
>> + * We default to IRQ0 for the "no irq" hack. =A0 Some
>> + * machine types want others as well - they're free
>> + * to redefine this in their header file.
>> + */
>> +
>> +#define is_real_interrupt(irq) =A0((irq) !=3D 0)
>
> You should compare to NO_IRQ instead.
>
>> +
>> +#if defined(CONFIG_SERIAL_OMAP_CONSOLE) && defined(CONFIG_MAGIC_SYS=
RQ)
>> +#define SUPPORT_SYSRQ
>> +#endif
>> +
>> +#define OMAP_MDR1_DISABLE =A0 =A00x07
>> +#define OMAP_MDR1_MODE13X =A0 =A00x03
>> +#define OMAP_MDR1_MODE16X =A0 =A00x00
>> +#define OMAP_MODE13X_SPEED =A0 230400
>> +
>> +#define CONSOLE_NAME "console=3D"
>> +
>> +#define RX_TIMEOUT =A0 (3 * HZ)
>> +
>> +#ifdef CONFIG_ARCH_OMAP4
>> +#define OMAP_MAX_HSUART_PORTS 4
>> +#else
>> +#define OMAP_MAX_HSUART_PORTS 3
>> +#endif
>> +
>> +struct omap_uart_port_info {
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_enabled; =A0=
 =A0/* To specify DMA Mode */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0uartclk; =A0 =A0 =A0 =A0=
/* UART clock rate */
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*membase; =A0 =A0 =A0 =
/* ioremap cookie or NULL */
>> + =A0 =A0 resource_size_t =A0 =A0 =A0 =A0 mapbase; =A0 =A0 =A0 =A0/*=
 resource base */
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 irqflags; =A0 =A0 =A0 /*=
 request_irq flags */
>> + =A0 =A0 upf_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags; =A0 =A0 =A0=
 =A0 =A0/* UPF_* flags */
>> + =A0 =A0 };
>> +
>> +struct uart_omap_dma {
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_dma_tx;
>> + =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_dma_rx;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_dma_channel=
;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_dma_channel=
;
>> + =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_buf_dma_phys;
>> + =A0 =A0 dma_addr_t =A0 =A0 =A0 =A0 =A0 =A0 =A0tx_buf_dma_phys;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Buffer for rx dma.It is not required for tx because t=
he buffer
>> + =A0 =A0 =A0* comes from port structure
>> + =A0 =A0 =A0*/
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0uart_base;
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 *rx_buf;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0prev_rx_dma_pos;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_buf_size;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_dma_state;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_dma_state;
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0tx_lock;
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_lock;
>> + =A0 =A0 /* timer to poll activity on rx dma */
>> + =A0 =A0 struct timer_list =A0 =A0 =A0 rx_timer;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_buf_size;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_timeout;
>> +};
>> +
>> +struct uart_omap_port {
>> + =A0 =A0 struct uart_port =A0 =A0 =A0 =A0port;
>> + =A0 =A0 struct uart_omap_dma =A0 =A0uart_dma;
>> + =A0 =A0 struct platform_device =A0*pdev;
>> +
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 ier;
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 lcr;
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 mcr;
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 fcr;
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 efr;
>> +
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_buf_dma_all=
oced;
>
>
> Alloced is bad english. :) =A0"allocated" would be better.

Will correct it.

>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Some bits in registers are cleared on a read, so they=
 must
>> + =A0 =A0 =A0* be saved whenever the register is read but the bits w=
ill not
>> + =A0 =A0 =A0* be immediately processed.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0lsr_break_flag;
>> +#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>
> I know the 8250 code does the define in the structure, but it still s=
eems
> like a random thing to do. =A0Please move it up with the other define=
s.

Will move this from the structure.

>
>> + =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 msr_saved_flags;
>> + =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
>> + =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_lock;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 port_activity;
>> +};
>> +
>> +extern char *saved_command_line;
>> +#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 9ff47db..a5b1c71 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1366,6 +1366,29 @@ config SERIAL_OF_PLATFORM
>> =A0 =A0 =A0 =A0 Currently, only 8250 compatible ports are supported,=
 but
>> =A0 =A0 =A0 =A0 others can easily be added.
>>
>> +config SERIAL_OMAP
>> + =A0 =A0 tristate "OMAP serial port support"
>> + =A0 =A0 depends on ARCH_OMAP3 || ARCH_OMAP4
>> + =A0 =A0 select SERIAL_CORE
>> + =A0 =A0 help
>> + =A0 =A0 If you have a machine based on an Texas Instruments OMAP C=
PU you
>> + =A0 =A0 can enable its onboard serial ports by enabling this optio=
n.
>> +
>> +config SERIAL_OMAP_CONSOLE
>> + =A0 =A0 bool "Console on OMAP serial port"
>> + =A0 =A0 depends on SERIAL_OMAP
>> + =A0 =A0 select SERIAL_CORE_CONSOLE
>> + =A0 =A0 help
>> + =A0 =A0 If you have enabled the serial port on the Texas Instrumen=
ts OMAP
>> + =A0 =A0 CPU you can make it the console by answering Y to this opt=
ion.
>> +
>> + =A0 =A0 Even if you say Y here, the currently visible virtual cons=
ole
>> + =A0 =A0 (/dev/tty0) will still be used as the system console by de=
fault, but
>> + =A0 =A0 you can alter that using a kernel command line option such=
 as
>> + =A0 =A0 "console=3Dtty0". (Try "man bootparam" or see the document=
ation of
>> + =A0 =A0 your boot loader (lilo or loadlin) about how to pass optio=
ns to the
>> + =A0 =A0 kernel at boot time.)
>
> ARM has neither lilo nor loadlin. The help text could do with a minor=
 cleanup.
>

will correct this.

>> +
>> =A0config SERIAL_OF_PLATFORM_NWPSERIAL
>> =A0 =A0 =A0 tristate "NWP serial port driver"
>> =A0 =A0 =A0 depends on PPC_OF && PPC_DCR
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index 5548fe7..42962b3 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -82,3 +82,4 @@ obj-$(CONFIG_KGDB_SERIAL_CONSOLE) +=3D kgdboc.o
>> =A0obj-$(CONFIG_SERIAL_QE) +=3D ucc_uart.o
>> =A0obj-$(CONFIG_SERIAL_TIMBERDALE) =A0 =A0 =A0+=3D timbuart.o
>> =A0obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) +=3D apbuart.o
>> +obj-$(CONFIG_SERIAL_OMAP) +=3D omap-serial.o
>> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-seri=
al.c
>> new file mode 100755
>> index 0000000..72697ca
>> --- /dev/null
>> +++ b/drivers/serial/omap-serial.c
>> @@ -0,0 +1,1349 @@
>> +/*
>> + * Driver for OMAP-UART controller.
>> + * Based on drivers/serial/8250.c
>> + *
>> + * Copyright (C) 2009 Texas Instruments.
>> + *
>> + * Authors:
>> + * =A0 Govindraj R =A0 =A0 <govindraj.raja@ti.com>
>> + * =A0 Thara Gopinath =A0<thara@ti.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public =
License
>> + * version 2. This program is licensed "as is" without any warranty=
 of any
>> + * kind, whether express or implied.
>> + *
>> + * Note: This driver is made seperate from 8250 driver as we cannot
>> + * over load 8250 driver with omap platform specific configuration =
for
>> + * features like DMA, it makes easier to implement features like DM=
A and
>> + * hardware flow control and software flow control configuration wi=
th
>> + * this driver as required for the omap-platform.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/console.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/delay.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/io.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/clk.h>
>> +#include <linux/serial_core.h>
>> +
>> +#include <asm/irq.h>
>> +#include <plat/dma.h>
>> +#include <plat/dmtimer.h>
>> +#include <plat/omap-serial.h>
>> +
>> +static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>> +
>> +/* Forward declaration of functions */
>> +static void uart_tx_dma_callback(int lch, u16 ch_status, void *data=
);
>> +static void serial_omap_rx_timeout(unsigned long uart_no);
>> +static void serial_omap_start_rxdma(struct uart_omap_port *up);
>> +static int serial_omap_remove(struct platform_device *dev);
>> +
>> +int console_detect(char *str)
>> +{
>> + =A0 =A0 char *next, *start =3D NULL;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 i =3D strlen(CONSOLE_NAME);
>> + =A0 =A0 next =3D saved_command_line;
>> +
>> + =A0 =A0 while ((next =3D strchr(next, 'c')) !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strncmp(next, CONSOLE_NAME, i)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D next;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 if (!start)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> + =A0 =A0 i =3D 0;
>> + =A0 =A0 start =3D strchr(start, '=3D') + 1;
>> + =A0 =A0 while (*start !=3D ',') {
>> + =A0 =A0 =A0 =A0 =A0 =A0 str[i++] =3D *start++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i > 6) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s : Invalid Conso=
le Name\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 str[i] =3D '\0';
>> + =A0 =A0 return 0;
>> +}
>
> What's the purpose of this function? console_setup() will already sel=
ect
> the right console for you, right?

Yes correct, will remove this one.

>
>> +
>> +static inline unsigned int serial_in(struct uart_omap_port *up, int=
 offset)
>> +{
>> + =A0 =A0 offset <<=3D up->port.regshift;
>> + =A0 =A0 return readw(up->port.membase + offset);
>> +}
>> +
>> +static inline void serial_out(struct uart_omap_port *up, int offset=
, int value)
>> +{
>> + =A0 =A0 offset <<=3D up->port.regshift;
>> + =A0 =A0 writew(value, up->port.membase + offset);
>> +}
>> +
>> +static inline void serial_omap_clear_fifos(struct uart_omap_port *p=
ort)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>> + =A0 =A0 serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UART_FCR_CLEAR_RCVR | UART_=
=46CR_CLEAR_XMIT);
>> + =A0 =A0 serial_out(up, UART_FCR, 0);
>> +}
>> +
>> +/**
>> + * serial_omap_get_divisor() - calculate divisor value
>> + * @port: uart port info
>> + * @baud: baudrate for which divisor needs to be calculated.
>> + *
>> + * We have written our own function to get the divisor so as to sup=
port
>> + * 13x mode.
>> + */
>
> Again, the why, not the how. Why do you need the 13x divisor? What's
> magic about 3Mbaud?
>

Refering to TRM UART chapter 17:

Table 17-1. UART Mode Baud Rates, Divisor Values, and Error Rates

referring to oversampling - divisor value

baudrate 460,800 to 3,686,400 all have divisor 13

except 3,000,000 which has divisor value 16

thus we are checking if baud !=3D 3000000



>> +static unsigned int
>> +serial_omap_get_divisor(struct uart_port *port, unsigned int baud)
>> +{
>> + =A0 =A0 unsigned int divisor;
>> +
>> + =A0 =A0 if (baud > OMAP_MODE13X_SPEED && baud !=3D 3000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 13;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 16;
>> + =A0 =A0 return port->uartclk/(baud * divisor);
>> +}
>> +
>> +static void serial_omap_stop_rxdma(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 if (up->uart_dma.rx_dma_state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&up->uart_dma.rx_timer);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma.rx_dma_channel)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(up->uart_dma.rx_dma_channel)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D 0xFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_state =3D 0x0;
>> + =A0 =A0 }
>> +}
>> +
>> +static void serial_omap_enable_ms(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
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
>> +
>> + =A0 =A0 if (up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.tx_dma_channel !=3D 0xFF)=
 {
>
> Could be nice to have a define for this magic value.

Will add an macro.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if dma is still=
 active . If yes do nothing,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* return. Else stop dma
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_get_dma_active_st=
atus
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (up->uart_dma.tx_dma_channel))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma=
=2Etx_dma_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(up->uart_dma=
=2Etx_dma_channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channe=
l =3D 0xFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (up->ier & UART_IER_THRI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_THRI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 }
>> +}
>> +
>> +static void serial_omap_stop_rx(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 serial_omap_stop_rxdma(up);
>> + =A0 =A0 up->ier &=3D ~UART_IER_RLSI;
>> + =A0 =A0 up->port.read_status_mask &=3D ~UART_LSR_DR;
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> +}
>> +
>> +static inline void receive_chars(struct uart_omap_port *up, int *st=
atus)
>> +{
>> + =A0 =A0 struct tty_struct *tty =3D up->port.state->port.tty;
>> + =A0 =A0 unsigned int flag;
>> + =A0 =A0 unsigned char ch, lsr =3D *status;
>> + =A0 =A0 int max_count =3D 256;
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (likely(lsr & UART_LSR_DR))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D serial_in(up, UART_=
RX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 flag =3D TTY_NORMAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rx++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(lsr & UART_LSR_BRK_ERROR_BITS=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For statistics only
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lsr & UART_LSR_BI) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsr &=3D ~=
(UART_LSR_FE | UART_LSR_PE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.brk++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We do=
 the SysRQ and SAK checking
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* here =
because otherwise the break
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* may g=
et masked by ignore_status_mask
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* or re=
ad_status_mask.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_h=
andle_break(&up->port))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 goto ignore_char;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (lsr & UART_LSR_=
PE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.parity++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lsr & UART_LSR_FE=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.i=
count.frame++;
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
>> + =A0 =A0 tty_flip_buffer_push(tty);
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
>> +
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
>> +static void serial_omap_start_tx(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 if (up->use_dma && !(up->port.x_char)) {
>
> If you turn this test around you can lose one level of indentation an=
d
> make the function more readable, by putting the 2-line else-case here
> followed by the return, and not indent the rest.
>
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.state-=
>xmit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int start =3D up->uart_dma.tx_buf=
_dma_phys +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (xmit->tai=
l & (UART_XMIT_SIZE - 1));
>
> Might as well define these variables at the head of the function.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit) || up->uart_dma.=
tx_dma_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&(up->uart_dma.tx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_state =3D 1;
>
> What's state 1? Magic value.
>
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_params(up->uart_dma.tx_d=
ma_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DMA_AMODE_CONSTANT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 up->uart_dma.uart_base, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_params(up->uart_dma.tx_dm=
a_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DMA_AMODE_POST_INC, start, 0, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_transfer_params(up->uart_dma.=
tx_dma_channel,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DMA_DATA_TYPE_S8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 up->uart_dma.tx_buf_size, 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 OMAP_DMA_SYNC_ELEMENT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 up->uart_dma.uart_dma_tx, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_start_dma(up->uart_dma.tx_dma_channel=
);
>> +
>> + =A0 =A0 } else if (!(up->ier & UART_IER_THRI)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_THRI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 }
>> +}
>> +
>> +static unsigned int check_modem_status(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 int status;
>> + =A0 =A0 status =3D serial_in(up, UART_MSR);
>> +
>> + =A0 =A0 status |=3D up->msr_saved_flags;
>> + =A0 =A0 up->msr_saved_flags =3D 0;
>> +
>> + =A0 =A0 if ((status & UART_MSR_ANY_DELTA) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return status;
>> + =A0 =A0 if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI =
&&
>> + =A0 =A0 =A0 =A0 up->port.state !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_TERI)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rng++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DDSR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.dsr++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DDCD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_dcd_change
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (&up->port=
, status & UART_MSR_DCD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DCTS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_cts_change
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (&up->port=
, status & UART_MSR_CTS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&up->port.state->por=
t.delta_msr_wait);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return status;
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
>> +
>> + =A0 =A0 iir =3D serial_in(up, UART_IIR);
>> + =A0 =A0 if (iir & UART_IIR_NO_INT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 lsr =3D serial_in(up, UART_LSR);
>> + =A0 =A0 if ((iir & 0x4) && up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_RDI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_start_rxdma(up);
>> + =A0 =A0 } else if (lsr & UART_LSR_DR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 receive_chars(up, &lsr);
>> + =A0 =A0 }
>> + =A0 =A0 check_modem_status(up);
>> + =A0 =A0 if ((lsr & UART_LSR_THRE) && (iir & 0x2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 transmit_chars(up);
>> +
>> + =A0 =A0 up->port_activity =3D jiffies;
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static unsigned int serial_omap_tx_empty(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned long flags =3D 0;
>> + =A0 =A0 unsigned int ret;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pde=
v->id);
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> + =A0 =A0 ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_=
TEMT : 0;
>> + =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static unsigned int serial_omap_get_mctrl(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned char status;
>> + =A0 =A0 unsigned int ret;
>> +
>> + =A0 =A0 status =3D check_modem_status(up);
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pd=
ev->id);
>> +
>> + =A0 =A0 ret =3D 0;
>> + =A0 =A0 if (status & UART_MSR_DCD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_CAR;
>> + =A0 =A0 if (status & UART_MSR_RI)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_RNG;
>> + =A0 =A0 if (status & UART_MSR_DSR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_DSR;
>> + =A0 =A0 if (status & UART_MSR_CTS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_CTS;
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static void serial_omap_set_mctrl(struct uart_port *port, unsigned =
int mctrl)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned char mcr =3D 0;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->pd=
ev->id);
>> + =A0 =A0 if (mctrl & TIOCM_RTS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_RTS;
>> + =A0 =A0 if (mctrl & TIOCM_DTR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_DTR;
>> + =A0 =A0 if (mctrl & TIOCM_OUT1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_OUT1;
>> + =A0 =A0 if (mctrl & TIOCM_OUT2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_OUT2;
>> + =A0 =A0 if (mctrl & TIOCM_LOOP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_LOOP;
>> +
>> + =A0 =A0 mcr |=3D up->mcr;
>> + =A0 =A0 serial_out(up, UART_MCR, mcr);
>> +}
>> +
>> +static void serial_omap_break_ctl(struct uart_port *port, int break=
_state)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned long flags =3D 0;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pd=
ev->id);
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> + =A0 =A0 if (break_state =3D=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->lcr |=3D UART_LCR_SBC;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->lcr &=3D ~UART_LCR_SBC;
>> + =A0 =A0 serial_out(up, UART_LCR, up->lcr);
>> + =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> +}
>> +
>> +static int serial_omap_startup(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned long flags =3D 0;
>> + =A0 =A0 int retval;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Allocate the IRQ
>> + =A0 =A0 =A0*/
>> + =A0 =A0 retval =3D request_irq(up->port.irq, serial_omap_irq, up->=
port.irqflags,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->name, =
up);
>> + =A0 =A0 if (retval)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev=
->id);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Clear the FIFO buffers and disable them.
>> + =A0 =A0 =A0* (they will be reenabled in set_termios())
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_omap_clear_fifos(up);
>> + =A0 =A0 /* For Hardware flow control */
>> + =A0 =A0 serial_out(up, UART_MCR, 0x2);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Clear the interrupt registers.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 (void) serial_in(up, UART_LSR);
>> + =A0 =A0 if (serial_in(up, UART_LSR) & UART_LSR_DR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void) serial_in(up, UART_RX);
>> + =A0 =A0 (void) serial_in(up, UART_IIR);
>> + =A0 =A0 (void) serial_in(up, UART_MSR);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Now, initialize the UART
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> + =A0 =A0 if (up->port.flags & UPF_FOURPORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!is_real_interrupt(up->port.irq))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D TIOCM_=
OUT1;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Most PC uarts need OUT2 raised to ena=
ble interrupts.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_real_interrupt(up->port.irq))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D TIOCM_=
OUT2;
>> + =A0 =A0 }
>
> The above if/else seems to come straight over from the 8250 driver. O=
ne
> of the cases can likely be removed here. :)
>
>> + =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
>> + =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> +
>> + =A0 =A0 up->msr_saved_flags =3D 0;
>> +
>> + =A0 =A0 if (up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!up->is_buf_dma_alloced) {
>
> Will you ever come here with use_dma =3D 1 and is_buf_dma_alloced =3D=
 0?
>
> I.e. do yo need the separate variable at all?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_page((unsigned long)u=
p->port.state->xmit.buf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.state->xmit.buf =3D=
 NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.state->xmit.buf =3D=
 dma_alloc_coherent(NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_XMIT_=
SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_addr_=
t *)&(up->uart_dma.tx_buf_dma_phys),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
>
> Huh, why two assignments in a row?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->is_buf_dma_alloced =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 init_timer(&(up->uart_dma.rx_timer));
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timer.function =3D serial_=
omap_rx_timeout;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timer.data =3D up->pdev->i=
d;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Currently the buffer size is 4KB. Can i=
ncrease it */
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf =3D dma_alloc_coherent=
(NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_addr_t *)&(up->uart_d=
ma.rx_buf_dma_phys), 0);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Finally, enable interrupts. Note: Modem status interr=
upts
>> + =A0 =A0 =A0* are set via set_termios(), which will be occurring im=
minently
>> + =A0 =A0 =A0* anyway, so we don't enable them here.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 up->ier =3D UART_IER_RLSI | UART_IER_RDI;
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> +
>> + =A0 =A0 up->port_activity =3D jiffies;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void serial_omap_shutdown(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned long flags =3D 0;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pde=
v->id);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Disable interrupts from this port
>> + =A0 =A0 =A0*/
>> + =A0 =A0 up->ier =3D 0;
>> + =A0 =A0 serial_out(up, UART_IER, 0);
>> +
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> + =A0 =A0 if (up->port.flags & UPF_FOURPORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* reset interrupts on the AST Fourport bo=
ard */
>> + =A0 =A0 =A0 =A0 =A0 =A0 inb((up->port.iobase & 0xfe0) | 0x1f);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D TIOCM_OUT1;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl &=3D ~TIOCM_OUT2;
>
> Same comment here regarding fourport and 8250
>
>> + =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
>> + =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Disable break condition and FIFOs
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_out(up, UART_LCR, serial_in(up, UART_LCR) & ~UART_L=
CR_SBC);
>> + =A0 =A0 serial_omap_clear_fifos(up);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Read data port to reset things, and then free the irq
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (serial_in(up, UART_LSR) & UART_LSR_DR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void) serial_in(up, UART_RX);
>> + =A0 =A0 if (up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int tmp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->is_buf_dma_alloced) {
>
> ... same comment as above.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(up->port=
=2Edev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_XMIT_=
SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.s=
tate->xmit.buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.tx_buf_dma_phys);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.state->xmit.buf =3D=
 NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->is_buf_dma_alloced =3D=
 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rx(port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(up->port.dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_size,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_dma_phys);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D serial_in(up, UART_OMAP_SYSC) & 0x=
7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); /* fo=
rce-idle */
>> + =A0 =A0 }
>> + =A0 =A0 free_irq(up->port.irq, up);
>> +}
>> +
>> +static inline void
>> +serial_omap_configure_xonxoff
>> + =A0 =A0 =A0 =A0 =A0 =A0 (struct uart_omap_port *up, struct ktermio=
s *termios)
>> +{
>> + =A0 =A0 unsigned char efr =3D 0;
>> +
>> + =A0 =A0 up->lcr =3D serial_in(up, UART_LCR);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> + =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr & ~UART_EFR_ECB);
>> +
>> + =A0 =A0 serial_out(up, UART_XON1, termios->c_cc[VSTART]);
>> + =A0 =A0 serial_out(up, UART_XOFF1, termios->c_cc[VSTOP]);
>> +
>> + =A0 =A0 /* clear SW control mode bits */
>> + =A0 =A0 efr =3D up->efr;
>> + =A0 =A0 efr &=3D 0xf0;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* IXON Flag:
>> + =A0 =A0 =A0* Enable XON/XOFF flow control on output.
>> + =A0 =A0 =A0* Transmit XON1, XOFF1
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (termios->c_iflag & IXON)
>> + =A0 =A0 =A0 =A0 =A0 =A0 efr |=3D 0x01 << 3;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* IXOFF Flag:
>> + =A0 =A0 =A0* Enable XON/XOFF flow control on input.
>> + =A0 =A0 =A0* Receiver compares XON1, XOFF1.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (termios->c_iflag & IXOFF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 efr |=3D 0x01 << 1;
>> +
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>
> So, UART_EFR_ECB is documented, but it would be nice to have the othe=
r
> bits documented as #defines too.
>
>> + =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> +
>> + =A0 =A0 up->mcr =3D serial_in(up, UART_MCR);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* IXANY Flag:
>> + =A0 =A0 =A0* Enable any character to restart output.
>> + =A0 =A0 =A0* Operation resumes after receiving any
>> + =A0 =A0 =A0* character after recognition of the XOFF character
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (termios->c_iflag & IXANY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mcr |=3D 1<<5;
>> +
>> + =A0 =A0 serial_out(up, UART_MCR, up->mcr | 1<<6);
>> +
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> + =A0 =A0 serial_out(up, UART_TI752_TCR, 0x0f);
>> + =A0 =A0 /* Enable special char function UARTi.EFR_REG[5] and
>> + =A0 =A0 =A0* load the new software flow control mode IXON or IXOFF
>> + =A0 =A0 =A0* and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_out(up, UART_EFR, efr | 1<<5);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> +
>> + =A0 =A0 serial_out(up, UART_MCR, up->mcr & ~(1<<6));
>> + =A0 =A0 serial_out(up, UART_LCR, up->lcr);
>> +}
>> +
>> +static void
>> +serial_omap_set_termios(struct uart_port *port, struct ktermios *te=
rmios,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ktermios *old)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned char cval =3D 0;
>> + =A0 =A0 unsigned char efr =3D 0;
>> + =A0 =A0 unsigned long flags =3D 0;
>> + =A0 =A0 unsigned int baud, quot;
>> +
>> + =A0 =A0 switch (termios->c_cflag & CSIZE) {
>> + =A0 =A0 case CS5:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case CS6:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN6;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case CS7:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN7;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 case CS8:
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (termios->c_cflag & CSTOPB)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_STOP;
>> + =A0 =A0 if (termios->c_cflag & PARENB)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_PARITY;
>> + =A0 =A0 if (!(termios->c_cflag & PARODD))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_EPAR;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Ask the core to calculate the divisor for us.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 baud =3D uart_get_baud_rate(port, termios, old, 0, port->u=
artclk/13);
>> + =A0 =A0 quot =3D serial_omap_get_divisor(port, baud);
>> +
>> + =A0 =A0 if (up->use_dma)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->fcr =3D UART_FCR_ENABLE_FIFO
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | 0x1 << 6 | 0x1 << 4
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | UART_FCR_DMA_SELECT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->fcr =3D UART_FCR_ENABLE_FIFO
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | 0x1 << 6 | 0x1 << 4;
>
> More magic numbers.
>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Ok, we're now changing the port state. =A0Do it with
>> + =A0 =A0 =A0* interrupts disabled.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Update the per-port timeout.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 uart_update_timeout(port, termios->c_cflag, baud);
>> +
>> + =A0 =A0 up->port.read_status_mask =3D UART_LSR_OE | UART_LSR_THRE =
| UART_LSR_DR;
>> + =A0 =A0 if (termios->c_iflag & INPCK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.read_status_mask |=3D UART_LSR_FE=
 | UART_LSR_PE;
>> + =A0 =A0 if (termios->c_iflag & (BRKINT | PARMRK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.read_status_mask |=3D UART_LSR_BI=
;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Characters to ignore
>> + =A0 =A0 =A0*/
>> + =A0 =A0 up->port.ignore_status_mask =3D 0;
>> + =A0 =A0 if (termios->c_iflag & IGNPAR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART_LSR_=
PE | UART_LSR_FE;
>> + =A0 =A0 if (termios->c_iflag & IGNBRK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART_LSR_=
BI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we're ignoring parity and break in=
dicators,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* ignore overruns too (for real raw sup=
port).
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mas=
k |=3D UART_LSR_OE;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* ignore all characters if CREAD is not set
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((termios->c_cflag & CREAD) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART_LSR_=
DR;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Modem status interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 up->ier &=3D ~UART_IER_MSI;
>> + =A0 =A0 if (UART_ENABLE_MS(&up->port, termios->c_cflag))
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 serial_out(up, UART_LCR, cval); =A0 =A0 =A0 =A0 /* reset D=
LAB */
>> +
>> + =A0 =A0 /*-----------FIFOs and DMA Settings -----------*/
>
> Unstandard comment style
>
>> +
>> + =A0 =A0 /* FCR can be changed only when the
>> + =A0 =A0 =A0* baud clock is not running
>> + =A0 =A0 =A0* DLL_REG and DLH_REG set to 0.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
>> + =A0 =A0 serial_out(up, UART_DLL, 0);
>> + =A0 =A0 serial_out(up, UART_DLM, 0);
>> + =A0 =A0 serial_out(up, UART_LCR, 0);
>> +
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> +
>> + =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x0); =A0 =A0 =A0 =A0 =A0/* Acces=
s FCR */
>
> Access FCR by writing LCR? Please explain. Same goes for the ones bel=
ow.


Most of these configuration come straight from TRM:

7.5 UART/IrDA/CIR Basic Programming Model


>
>> +
>> + =A0 =A0 up->mcr =3D serial_in(up, UART_MCR);
>> + =A0 =A0 serial_out(up, UART_MCR, up->mcr | 0x40); =A0 =A0 =A0 /* A=
ccess TLR*/
>> + =A0 =A0 /* FIFO ENABLE, DMA MODE */
>> + =A0 =A0 serial_out(up, UART_FCR, up->fcr);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf); =A0 =A0 =A0 =A0 /* Access =
EFR */
>> +
>> + =A0 =A0 if (up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TI752_TLR, 0x00);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SCR, ((1 << 6) | =
(1 << 7)));
>> + =A0 =A0 }
>> +
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr);
>> + =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> + =A0 =A0 serial_out(up, UART_MCR, up->mcr); =A0 =A0 =A0/* Restore T=
LR */
>> +
>> + =A0 =A0 /*-----Protocol, Baud Rate, and Interrupt Settings -- */
>
> More unstandard comment format
>
>> +
>> + =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_MDR1_DISABLE);
>> +
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> +
>> + =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>> +
>> + =A0 =A0 serial_out(up, UART_LCR, 0);
>> + =A0 =A0 serial_out(up, UART_IER, 0);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> +
>> + =A0 =A0 serial_out(up, UART_DLL, quot & 0xff); =A0 =A0 =A0 =A0 =A0=
/* LS of divisor */
>> + =A0 =A0 serial_out(up, UART_DLM, quot >> 8); =A0 =A0 =A0 =A0 =A0 =A0=
/* MS of divisor */
>> +
>> + =A0 =A0 serial_out(up, UART_LCR, 0);
>> + =A0 =A0 serial_out(up, UART_IER, up->ier);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xbf);
>> +
>> + =A0 =A0 serial_out(up, UART_EFR, up->efr);
>> + =A0 =A0 serial_out(up, UART_LCR, cval);
>> +
>> + =A0 =A0 if (baud > 230400 && baud !=3D 3000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_MDR1_M=
ODE13X);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_MDR1_M=
ODE16X);
>
> More 13-divider special case.
>
>> +
>> + =A0 =A0 /*---------- Hardware Flow Control Configuration------- */
>> +
>> + =A0 =A0 if (termios->c_cflag & CRTSCTS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 efr |=3D (UART_EFR_CTS | UART_EFR_RTS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->mcr =3D serial_in(up, UART_MCR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_MCR, up->mcr | 0x40);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, 0xbf); /* Access =
EFR */
>
> EFR or LCR?!

writing 0xbf to LCR gives acces to EFR

references : 17.5 UART/IrDA/CIR Basic Programming Model

>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_EFR, up->efr | UART_EF=
R_ECB);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TI752_TCR, 0x0f);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_EFR, efr); /* Enable A=
UTORTS and AUTOCTS */
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, 0x80);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_MCR, up->mcr | 0x02);
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, cval);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
>> + =A0 =A0 /* --------Software Flow Control Configuration-------- */
>> + =A0 =A0 if (termios->c_iflag & (IXON | IXOFF))
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_configure_xonxoff(up, termios)=
;
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->=
pdev->id);
>> +}
>> +
>> +static void
>> +serial_omap_pm(struct uart_port *port, unsigned int state,
>> + =A0 =A0 =A0 =A0 =A0 =A0unsigned int oldstate)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned char efr;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id)=
;
>> + =A0 =A0 efr =3D serial_in(up, UART_EFR);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xBF);
>> + =A0 =A0 serial_out(up, UART_EFR, efr | UART_EFR_ECB);
>> + =A0 =A0 serial_out(up, UART_LCR, 0);
>> +
>> + =A0 =A0 serial_out(up, UART_IER, (state !=3D 0) ? UART_IERX_SLEEP =
: 0);
>> + =A0 =A0 serial_out(up, UART_LCR, 0xBF);
>> + =A0 =A0 serial_out(up, UART_EFR, efr);
>> + =A0 =A0 serial_out(up, UART_LCR, 0);
>> + =A0 =A0 /* Enable module level wake up */
>> + =A0 =A0 serial_out(up, UART_OMAP_WER, (state !=3D 0) ? 0x7f : 0);
>> +}
>> +
>> +static void serial_omap_release_port(struct uart_port *port)
>> +{
>> + =A0 =A0 dev_dbg(port->dev, "serial_omap_release_port+\n");
>> +}
>> +
>> +static int serial_omap_request_port(struct uart_port *port)
>> +{
>> + =A0 =A0 dev_dbg(port->dev, "serial_omap_request_port+\n");
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void serial_omap_config_port(struct uart_port *port, int fla=
gs)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 dev_dbg(up->port.dev, "serial_omap_config_port+%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->pdev->id);
>> + =A0 =A0 up->port.type =3D PORT_OMAP;
>> +}
>> +
>> +static int
>> +serial_omap_verify_port(struct uart_port *port, struct serial_struc=
t *ser)
>> +{
>> + =A0 =A0 /* we don't want the core code to modify any port params *=
/
>> + =A0 =A0 dev_dbg(port->dev, "serial_omap_verify_port+\n");
>> + =A0 =A0 return -EINVAL;
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->msr_saved_flags |=3D m=
sr & MSR_SAVE_FLAGS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msr & UART_MSR_CTS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +
>> +static void serial_omap_console_putchar(struct uart_port *port, int=
 ch)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> +
>> + =A0 =A0 wait_for_xmitr(up);
>> + =A0 =A0 serial_out(up, UART_TX, ch);
>> +}
>> +
>> +static void
>> +serial_omap_console_write(struct console *co, const char *s,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int count)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D serial_omap_console_ports[co=
->index];
>> + =A0 =A0 unsigned int ier;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* First save the IER then disable the interrupts
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ier =3D serial_in(up, UART_IER);
>> + =A0 =A0 serial_out(up, UART_IER, 0);
>> +
>> + =A0 =A0 uart_console_write(&up->port, s, count, serial_omap_consol=
e_putchar);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Finally, wait for transmitter to become empty
>> + =A0 =A0 =A0* and restore the IER
>> + =A0 =A0 =A0*/
>> + =A0 =A0 wait_for_xmitr(up);
>> + =A0 =A0 serial_out(up, UART_IER, ier);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* The receive handling will happen properly because the
>> + =A0 =A0 =A0* receive ready bit will still be set; it is not cleare=
d
>> + =A0 =A0 =A0* on read. =A0However, modem control will not, we must
>> + =A0 =A0 =A0* call it if we have saved something in the saved flags
>> + =A0 =A0 =A0* while processing with interrupts off.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (up->msr_saved_flags)
>> + =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
>> +}
>> +
>> +static int __init
>> +serial_omap_console_setup(struct console *co, char *options)
>> +{
>> + =A0 =A0 struct uart_omap_port *up;
>> + =A0 =A0 int baud =3D 9600;
>
> Nearly every OMAP setup seems to prefer 115200 as default baudrate, r=
ight?

Yes, but shouldn't we initialize to lowest possible baud?

>
>> + =A0 =A0 int bits =3D 8;
>> + =A0 =A0 int parity =3D 'n';
>> + =A0 =A0 int flow =3D 'n';
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 if (serial_omap_console_ports[co->index] =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 up =3D serial_omap_console_ports[co->index];
>> +
>> + =A0 =A0 if (options)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &parity=
, &bits, &flow);
>> +
>> + =A0 =A0 r =3D uart_set_options(&up->port, co, baud, parity, bits, =
flow);
>> +
>> + =A0 =A0 return r;
>> +}
>> +
>> +static struct console serial_omap_console =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D OMAP_SERIAL_NAME,
>> + =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D serial_omap_console_write,
>> + =A0 =A0 .device =A0 =A0 =A0 =A0 =3D uart_console_device,
>> + =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D serial_omap_console_setup,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D CON_PRINTBUFFER,
>> + =A0 =A0 .index =A0 =A0 =A0 =A0 =A0=3D -1,
>> + =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D &serial_omap_reg,
>> +};
>> +
>> +static void serial_omap_add_console_port(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 serial_omap_console_ports[up->pdev->id] =3D up;
>> +}
>> +
>> +#define OMAP_CONSOLE (&serial_omap_console)
>> +
>> +#else
>> +
>> +#define OMAP_CONSOLE NULL
>> +
>> +static inline void serial_omap_add_console_port(struct uart_omap_po=
rt *up) {}
>
> Please do the empty body on a separate line.
>
>> +
>> +#endif
>> +
>> +struct uart_ops serial_omap_pops =3D {
>> + =A0 =A0 .tx_empty =A0 =A0 =A0 =3D serial_omap_tx_empty,
>> + =A0 =A0 .set_mctrl =A0 =A0 =A0=3D serial_omap_set_mctrl,
>> + =A0 =A0 .get_mctrl =A0 =A0 =A0=3D serial_omap_get_mctrl,
>> + =A0 =A0 .stop_tx =A0 =A0 =A0 =A0=3D serial_omap_stop_tx,
>> + =A0 =A0 .start_tx =A0 =A0 =A0 =3D serial_omap_start_tx,
>> + =A0 =A0 .stop_rx =A0 =A0 =A0 =A0=3D serial_omap_stop_rx,
>> + =A0 =A0 .enable_ms =A0 =A0 =A0=3D serial_omap_enable_ms,
>> + =A0 =A0 .break_ctl =A0 =A0 =A0=3D serial_omap_break_ctl,
>> + =A0 =A0 .startup =A0 =A0 =A0 =A0=3D serial_omap_startup,
>> + =A0 =A0 .shutdown =A0 =A0 =A0 =3D serial_omap_shutdown,
>> + =A0 =A0 .set_termios =A0 =A0=3D serial_omap_set_termios,
>> + =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D serial_omap_pm,
>> + =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D serial_omap_type,
>> + =A0 =A0 .release_port =A0 =3D serial_omap_release_port,
>> + =A0 =A0 .request_port =A0 =3D serial_omap_request_port,
>> + =A0 =A0 .config_port =A0 =A0=3D serial_omap_config_port,
>> + =A0 =A0 .verify_port =A0 =A0=3D serial_omap_verify_port,
>> +};
>> +
>> +static struct uart_driver serial_omap_reg =3D {
>> + =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> + =A0 =A0 .driver_name =A0 =A0=3D "OMAP-SERIAL",
>> + =A0 =A0 .dev_name =A0 =A0 =A0 =3D OMAP_SERIAL_NAME,
>> + =A0 =A0 .major =A0 =A0 =A0 =A0 =A0=3D OMAP_SERIAL_MAJOR,
>> + =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D OMAP_SERIAL_MINOR,
>> + =A0 =A0 .nr =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP_MAX_HSUART_PORTS,
>> + =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D OMAP_CONSOLE,
>> +};
>> +
>> +static
>> +int serial_omap_suspend(struct platform_device *pdev, pm_message_t =
state)
>
> No linewrap (checkpatch should have caught this)

I use checkpatch --strict,
don't know how this passed

>
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 if (up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &up->p=
ort);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int serial_omap_resume(struct platform_device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 if (up)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &up->po=
rt);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void serial_omap_rx_timeout(unsigned long uart_no)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D ui[uart_no];
>> + =A0 =A0 unsigned int curr_dma_pos;
>> + =A0 =A0 curr_dma_pos =3D omap_get_dma_dst_pos(up->uart_dma.rx_dma_=
channel);
>> +
>> + =A0 =A0 if ((curr_dma_pos =3D=3D up->uart_dma.prev_rx_dma_pos) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(curr_dma_pos =3D=
=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - up->port_ac=
tivity) <
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RX_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&up->uart_dma.rx=
_timer, jiffies +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usecs_to_j=
iffies(up->uart_dma.rx_timeout));
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rxdma(up)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_RDI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, u=
p->ier);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>
> Since you have a return above, there's no need to do the rest in the
> else-clause. Saves one level of indentation.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int curr_transmitted_size =3D cur=
r_dma_pos -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 up->uart_dma.prev_rx_dma_pos;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rx +=3D curr_transmitted_s=
ize;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tty_insert_flip_string(up->port.state->por=
t.tty,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->uart_=
dma.prev_rx_dma_pos -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_dma_phys),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_trans=
mitted_size);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tty_flip_buffer_push(up->port.state->port.=
tty);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D curr_dma_=
pos;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.rx_buf_size +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_dma_phys =3D=3D curr_dma_pos)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_start_rxdma(up=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&up->uart_dma.rx=
_timer, jiffies +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usecs_to_j=
iffies(up->uart_dma.rx_timeout));
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->port_activity =3D jiffies;
>> + =A0 =A0 }
>> +}
>> +
>> +static void uart_rx_dma_callback(int lch, u16 ch_status, void *data=
)
>> +{
>> + =A0 =A0 return;
>> +}
>> +
>> +static void serial_omap_start_rxdma(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 if (up->uart_dma.rx_dma_channel =3D=3D 0xFF) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_request_dma(up->uart_dma.uart_dma_rx,=
 "UART Rx DMA",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)uart_rx_dma_callba=
ck, up,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(up->uart=
_dma.rx_dma_channel));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_params(up->uart_dma.rx_dm=
a_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_A=
MODE_CONSTANT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.uart_base, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_params(up->uart_dma.rx_d=
ma_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_A=
MODE_POST_INC,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_dma_phys, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_transfer_params(up->uart_dma.=
rx_dma_channel,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_D=
ATA_TYPE_S8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.rx_buf_size, 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_S=
YNC_ELEMENT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.uart_dma_rx, 0);
>> + =A0 =A0 }
>> + =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D up->uart_dma.rx_buf_dma_p=
hys;
>> + =A0 =A0 if (cpu_is_omap44xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP44XX_DMA4_BASE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP_DMA4_CDAC(up->uart_=
dma.rx_dma_channel));
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0, OMAP34XX_DMA4_BASE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP_DMA4_CDAC(up->uart_=
dma.rx_dma_channel));
>> + =A0 =A0 omap_start_dma(up->uart_dma.rx_dma_channel);
>> + =A0 =A0 mod_timer(&up->uart_dma.rx_timer, jiffies +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usecs_to_j=
iffies(up->uart_dma.rx_timeout));
>> + =A0 =A0 up->uart_dma.rx_dma_state =3D 1;
>> +}
>> +
>> +static void serial_omap_continue_tx(struct uart_omap_port *up)
>> +{
>> + =A0 =A0 struct circ_buf *xmit =3D &up->port.state->xmit;
>> + =A0 =A0 int start =3D up->uart_dma.tx_buf_dma_phys
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (xmit->tail & (UART_XMIT=
_SIZE - 1));
>> +
>> + =A0 =A0 if (uart_circ_empty(xmit))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 up->uart_dma.tx_buf_size =3D uart_circ_chars_pending(xmit)=
;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* It is a circular buffer. See if the buffer has wounde=
d back.
>> + =A0 =A0 =A0* If yes it will have to be transferred in two separate=
 dma
>> + =A0 =A0 =A0* transfers
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (start + up->uart_dma.tx_buf_size >=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_dma_ph=
ys + UART_XMIT_SIZE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->uart_dma.tx_buf_dma_p=
hys + UART_XMIT_SIZE) - start;
>> + =A0 =A0 omap_set_dma_dest_params(up->uart_dma.tx_dma_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_A=
MODE_CONSTANT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.uart_base, 0, 0);
>> + =A0 =A0 omap_set_dma_src_params(up->uart_dma.tx_dma_channel, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_A=
MODE_POST_INC, start, 0, 0);
>> + =A0 =A0 omap_set_dma_transfer_params(up->uart_dma.tx_dma_channel,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_D=
ATA_TYPE_S8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.tx_buf_size, 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_S=
YNC_ELEMENT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_d=
ma.uart_dma_tx, 0);
>
>
> Isn't there a dma_sync call missing somewhere around here? Same for
> the similar RX setup (both before DMA is started, as well as once it =
is
> completed on the RX side).

Sorry i didn't get you here as don't see any such dma_sync call
in arch/arm/plat-omap/dma.c.

>
>> +
>> + =A0 =A0 omap_start_dma(up->uart_dma.tx_dma_channel);
>> +}
>> +
>> +static void uart_tx_dma_callback(int lch, u16 ch_status, void *data=
)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)dat=
a;
>> + =A0 =A0 struct circ_buf *xmit =3D &up->port.state->xmit;
>> +
>> + =A0 =A0 xmit->tail =3D (xmit->tail + up->uart_dma.tx_buf_size) & \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (UART_XMIT_SIZE - 1);
>> + =A0 =A0 up->port.icount.tx +=3D up->uart_dma.tx_buf_size;
>> +
>> + =A0 =A0 if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(&up->port);
>> +
>> + =A0 =A0 if (uart_circ_empty(xmit)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&(up->uart_dma.tx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_state =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&(up->uart_dma.tx_lock));
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma.tx_dma_channel)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_continue_tx(up);
>> + =A0 =A0 }
>> + =A0 =A0 up->port_activity =3D jiffies;
>> + =A0 =A0 return;
>> +}
>> +
>> +static int serial_omap_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct uart_omap_port =A0 *up;
>> + =A0 =A0 struct resource =A0 =A0 =A0 =A0 *mem, *irq, *dma_tx, *dma_=
rx;
>> + =A0 =A0 struct omap_uart_port_info *omap_up_info =3D pdev->dev.pla=
tform_data;
>> + =A0 =A0 int ret =3D -ENOSPC;
>> + =A0 =A0 char str[7];
>> +
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> + =A0 =A0 irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> + =A0 =A0 if (!irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D (int) request_mem_region(mem->start, (mem->end - m=
em->start) + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pdev->dev.driver->name);
>> + =A0 =A0 if (!ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "memory region already=
 claimed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dma_tx =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> + =A0 =A0 if (!dma_tx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dma_rx =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> + =A0 =A0 if (!dma_rx) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 up =3D kzalloc(sizeof(*up), GFP_KERNEL);
>> + =A0 =A0 if (up =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
>> + =A0 =A0 }
>> + =A0 =A0 sprintf(up->name, "OMAP UART%d", pdev->id);
>> + =A0 =A0 up->pdev =3D pdev;
>> + =A0 =A0 up->port.dev =3D &pdev->dev;
>> + =A0 =A0 up->port.type =3D PORT_OMAP;
>> + =A0 =A0 up->port.iotype =3D UPIO_MEM;
>> + =A0 =A0 up->port.irq =3D irq->start;
>> + =A0 =A0 up->port.regshift =3D 2;
>> + =A0 =A0 up->port.fifosize =3D 64;
>> + =A0 =A0 up->port.ops =3D &serial_omap_pops;
>> + =A0 =A0 up->port.line =3D pdev->id;
>> +
>> + =A0 =A0 up->port.membase =3D omap_up_info->membase;
>> + =A0 =A0 up->port.mapbase =3D omap_up_info->mapbase;
>> + =A0 =A0 up->port.flags =3D omap_up_info->flags;
>> + =A0 =A0 up->port.irqflags =3D omap_up_info->irqflags;
>> + =A0 =A0 up->port.uartclk =3D omap_up_info->uartclk;
>> + =A0 =A0 up->uart_dma.uart_base =3D mem->start;
>> + =A0 =A0 if (omap_up_info->dma_enabled) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_tx =3D dma_tx->start=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.uart_dma_rx =3D dma_rx->start=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->use_dma =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_size =3D 4096;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timeout =3D 1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (up->use_dma) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&(up->uart_dma.tx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&(up->uart_dma.rx_lock));
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channel =3D 0xFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D 0xFF;
>> + =A0 =A0 }
>> + =A0 =A0 if (console_detect(str)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\n %s: Invalid console paramter...=
\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\n %s: UART Driver Init Failed!\n"=
, __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> + =A0 =A0 }
>
> See comments above about console_detect()
>
>> + =A0 =A0 ui[pdev->id] =3D up;
>> + =A0 =A0 serial_omap_add_console_port(up);
>> +
>> + =A0 =A0 ret =3D uart_add_one_port(&serial_omap_reg, &up->port);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, up);
>> + =A0 =A0 return 0;
>> +err:
>> + =A0 =A0 dev_err(&pdev->dev, "[UART%d]: failure [%s]\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pdev->id, __func__);
>
> It would be nice to get the actual error (i.e. printing out err) here=
=2E
>
>> +do_release_region:
>> + =A0 =A0 release_mem_region(mem->start, (mem->end - mem->start) + 1=
);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int serial_omap_remove(struct platform_device *dev)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(dev);
>> +
>> + =A0 =A0 platform_set_drvdata(dev, NULL);
>> + =A0 =A0 if (up) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_remove_one_port(&serial_omap_reg, &up=
->port);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(up);
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver serial_omap_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,
>> +
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
>> + =A0 =A0 },
>> +};
>> +
>> +int __init serial_omap_init(void)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D uart_register_driver(&serial_omap_reg);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 ret =3D platform_driver_register(&serial_omap_driver);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 uart_unregister_driver(&serial_omap_reg);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +void __exit serial_omap_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&serial_omap_driver);
>> + =A0 =A0 uart_unregister_driver(&serial_omap_reg);
>> +}
>> +
>> +module_init(serial_omap_init);
>> +module_exit(serial_omap_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP High Speed UART driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Texas Instruments Inc");
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core=
=2Eh
>> index 8c3dd36..e02b945 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -182,6 +182,9 @@
>> =A0/* Aeroflex Gaisler GRLIB APBUART */
>> =A0#define PORT_APBUART =A0 =A090
>>
>> +/* TI OMAP-UART */
>> +#define PORT_OMAP =A0 =A091
>> +
>> =A0#ifdef __KERNEL__
>>
>> =A0#include <linux/compiler.h>
>> --
>> 1.6.3.3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


--=20
---
Regards,
Govindraj.R



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
