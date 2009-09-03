From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
Date: Thu, 3 Sep 2009 13:40:29 +0800
Message-ID: <F12CE1A68F023D498A2691C7B53931150397CE81@ZMY16EXM66.ds.mot.com>
References: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com> <F12CE1A68F023D498A2691C7B539311503935B24@ZMY16EXM66.ds.mot.com> <d6a0f7aa0909010013n2c9334cdt56afa642e2a0617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <d6a0f7aa0909010013n2c9334cdt56afa642e2a0617@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: vimal singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>, Chen Xiaolong-A21785 <A21785@motorola.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Govindraj [mailto:govindraj.ti@gmail.com]=20
> Sent: Tuesday, September 01, 2009 3:14 PM
> To: HU TAO-TGHK48
> Cc: vimal singh; linux-omap@vger.kernel.org; LKML;=20
> linux-serial@vger.kernel.org; Ye Yuan.Bo-A22116; Chen Xiaolong-A21785
> Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
>=20
> On Mon, Aug 31, 2009 at 5:20 PM, HU=20
> TAO-TGHK48<taohu@motorola.com> wrote:
> >
> > 1. Shall we cleanup PM related stuff in=20
> arch/arm/mach-omap2/serial.c as
> > well?
> > =A0 =A0Originally serail.c register UART IRQ =A0to decide if UART=20
> idle for a
> > while and is able to enter low power mode (e.g. retention).
> > =A0 =A0To work with original 8250 driver, it is probably the=20
> only way since
> > 8250 is not aware of OMAP PM.
> >
> > =A0 =A0However =A0it would be more reasonable to merge PM stuff to
> > omap-serial.c. since the new driver is already OMAP specific
> >
> > 2. There is an issue for DMA =A0with current implementation=20
> in serial.c
> > =A0 =A0When Rx DMA is active NO Rx IRQ will be generated.
> > =A0 =A0So serial.c will easily set uart->can_sleep with "1"=20
> even there is
> > Rx DMA ongoing
> > =A0 =A0+ =A0 if ((iir & 0x4) && up->use_dma) {
> > =A0 =A0+ =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_RDI;
> > =A0 =A0+ =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier
> >
> > =A0 In my view, the best way is to do the idle detection in
> > omap_serial.c.
>=20
> Yes I understand that we cannot adapt 8250 PM model for omap-serial
> driver in DMA mode I am currently working on that adaption with dma
> mode and will be posting a separate patch for changes on serial.c.
>=20
> Wouldn't it be cleaner to inherit and adapt the Serial-PM framework
> from serial.c rather than redefining the PM changes in the driver.
>=20
> As Serial-PM framework already has support for interrupt mode and we
> have to adapt the same for DMA  mode.
>=20
> Also defining PM changes in omap-serial would need changes in=20
> PM framework.
> As PM framework calls functions from serail.c file if we are defining
> PM framework in our driver then we may need to redefine the functions
> as in serial.c or modify the PM-framework for uart-activity check.
> I feel adapting the existing serial-PM framework for DMA mode would b=
e
> better rather than
> doing these changes.
<HuTao> It is reasonable to implement it step by step.
<HuTao> I mean for the 1st patch we can just follow existing framework


>=20
>=20
> >
> > 3. Can a flag be added to enable auto-RTS and auto-CRT individually=
?
> > =A0 OMAP HW supports independent auto-RTS and auto-CTS.
> > =A0 And we had a case that only auto-RTS can be enabled due=20
> to HW design.
>=20
> Agree,
> I think this data should not go from serial.c rather it should go fro=
m
> *-board*.c file.
>=20
> As the the support for RTS/CTS is board specific.

<HuTao> I think so

>=20
>=20
> >
> > Below is the idea.
> >
> > =A0In arch/arm/mach-omap2/serial.c
> > =A0static struct plat_serialomap_port serial_platform_data[] =3D {
> > =A0 =A0 =A0 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .membase =A0 =A0 =A0 =A0=3D IO_ADDR=
ESS(OMAP_UART1_BASE),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D 72,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.rtscts =A0 =A0 =A0 =A0 =3D UART_EF=
R_RTS
> >
> >
> > In omap_serial.c
> > +static int serial_omap_probe(struct platform_device *pdev) {
> > struct plat_serialomap_port *pdata =3D pdev->dev.platform_data;
> > ... ...
> > + =A0 =A0 =A0 up->rtscts =3D =A0pdata->rtscts;
> >
> >
> > serial_omap_set_termios(struct uart_port *port, struct ktermios
> > *termios,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ktermios *old=
)
> > {
> > ... ...
> > =A0 =A0 =A0 =A0if (termios->c_cflag & CRTSCTS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 efr |=3D up->rtscts;
> >
> >
> >
> > Thanks
> >
> > Tao Hu
> >
> >
> >
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of vimal singh
> > Sent: Friday, August 28, 2009 9:50 PM
> > To: linux-omap@vger.kernel.org; LKML; linux-serial@vger.kernel.org
> > Subject: [RFC][PATCH]: Adding support for omap-serail driver
> >
> > From: Govindraj R <govindraj.raja@ti.com>
> >
> > This patch adds support for OMAP3430-HIGH SPEED UART Controller.
> >
> > It currently adds support for the following features.
> >
> > =A0 =A0 =A0 =A01. Supports Interrupt Mode for all three UARTs on SD=
P/ZOOM2.
> > =A0 =A0 =A0 =A02. Supports DMA Mode for all three UARTs on SDP/ZOOM=
2.
> > =A0 =A0 =A0 =A03. Supports Hardware flow control (CTS/RTS) on SDP/Z=
OOM2.
> > =A0 =A0 =A0 =A04. Supports 3.6Mbps baudrate on SDP/ZOOM2.
> > =A0 =A0 =A0 =A05. Debug Console support on all UARTs on SDP/ZOOM2.
> > =A0 =A0 =A0 =A06. Support for quad uart on ZOOM2 board.
> >
> > The reason for adding this new driver alternative to 8250=20
> is to avoid
> > polluting 8250 driver with too many omap specific data as=20
> 8250 already
> > supports more than 16 different uart controllers and may=20
> need too many
> > omap-platform checks to implement feature like DMA support.
> >
> > Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> > ---
> > =A0arch/arm/plat-omap/include/mach/omap-serial.h | =A0 84 +
> > =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 92 +
> > =A0drivers/serial/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A01
> > =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| 1431
> > ++++++++++++++++++++++++++
> > =A04 files changed, 1608 insertions(+)
> >
> > diff --git a/arch/arm/plat-omap/include/mach/omap-serial.h
> > b/arch/arm/plat-omap/include/mach/omap-serial.h
> > new file mode 100644
> > index 0000000..d1b0bf2
> > --- /dev/null
> > +++ b/arch/arm/plat-omap/include/mach/omap-serial.h
> > @@ -0,0 +1,84 @@
> > +/*
> > + * arch/arm/plat-omap/include/mach/omap-serial.h
> > + *
> > + * Driver for OMAP3430 UART controller.
> > + *
> > + * Copyright (C) 2009 Texas Instruments.
> > + *
> > + * Authors:
> > + * =A0 =A0 Thara Gopinath =A0<thara@ti.com>
> > + * =A0 =A0 Govindraj R =A0 =A0 <govindraj.raja@ti.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > +License
> > + * version 2. This program is licensed "as is" without any=20
> warranty of
> > +any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#ifndef __OMAP_SERIAL_H__
> > +#define __OMAP_SERIAL_H__
> > +
> > +#include <linux/serial_core.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* TI OMAP CONSOLE */
> > +#define PORT_OMAP =A0 =A0 =A0 86
> > +
> > +#define DRIVER_NAME =A0 =A0"omap-hsuart"
> > +
> > +/*
> > + * We default to IRQ0 for the "no irq" hack. =A0 Some
> > + * machine types want =A0others as well - they're free
> > + * to redefine this in their header file.
> > + */
> > +#define is_real_interrupt(irq) =A0((irq) !=3D 0)
> > +
> > +#if defined(CONFIG_SERIAL_OMAP_CONSOLE) &&=20
> defined(CONFIG_MAGIC_SYSRQ)
> > +#define SUPPORT_SYSRQ #endif
> > +
> > +#ifdef CONFIG_ARCH_OMAP34XX
> > +#define OMAP_MDR1_DISABLE =A0 =A0 =A00x07
> > +#define OMAP_MDR1_MODE13X =A0 =A0 =A00x03
> > +#define OMAP_MDR1_MODE16X =A0 =A0 =A00x00
> > +#define OMAP_MODE13X_SPEED =A0 =A0 230400
> > +#endif
> > +
> > +#define CONSOLE_NAME =A0 "console=3D"
> > +
> > +#define UART_CLK =A0 =A0 =A0 (48000000)
> > +#define QUART_CLK =A0 =A0 =A0(1843200)
> > +
> > +/* UART NUMBERS */
> > +#define UART1 =A0 =A0 =A0 =A0 =A0(0x0)
> > +#define UART2 =A0 =A0 =A0 =A0 =A0(0x1)
> > +#define UART3 =A0 =A0 =A0 =A0 =A0(0x2)
> > +#define QUART =A0 =A0 =A0 =A0 =A0(0x3)
> > +
> > +#ifdef CONFIG_MACH_OMAP_ZOOM2
> > +#define MAX_UARTS =A0 =A0 =A0QUART
> > +#else
> > +#define MAX_UARTS =A0 =A0 =A0UART3
> > +#endif
> > +
> > +#define UART_BASE(uart_no) =A0 =A0 =A0 =A0 =A0 =A0 (uart_no =3D=3D=
 UART1) ?
> > OMAP_UART1_BASE :\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (uart_no =3D=3D UART2) ?
> > OMAP_UART2_BASE :\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0OMAP_UART3_BASE
> > +
> > +#define UART_MODULE_BASE(uart_no) =A0 =A0 =A0(UART1 =3D=3D uart_no=
 ? \
> > +
> > IO_ADDRESS(OMAP_UART1_BASE) :\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (UART2 =3D=3D uart_no ? \
> > +
> > IO_ADDRESS(OMAP_UART2_BASE) :\
> > +
> > IO_ADDRESS(OMAP_UART3_BASE)))
> > +extern unsigned int fcr[MAX_UARTS];
> > +extern char *saved_command_line;
> > +
> > +struct plat_serialomap_port {
> > + =A0 =A0 =A0 void __iomem =A0 =A0*membase; =A0 =A0 =A0 /* ioremap =
cookie or NULL */
> > + =A0 =A0 =A0 =A0resource_size_t mapbase; =A0 =A0 =A0 /* resource b=
ase */
> > + =A0 =A0 =A0 unsigned int =A0 =A0irq; =A0 =A0 =A0 =A0 =A0 =A0/* in=
terrupt number */
> > + =A0 =A0 =A0 unsigned char =A0 regshift; =A0 =A0 =A0 /* register s=
hift */
> > + =A0 =A0 =A0 upf_t =A0 =A0 =A0 =A0 =A0 flags; =A0 =A0 =A0 =A0 =A0/=
* UPF_* flags */
> > + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0*private_data;
> > +};
> > +
> > +#endif /* __OMAP_SERIAL_H__ */
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig index
> > 037c1e0..906fb61 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -1359,6 +1359,98 @@ config SERIAL_OF_PLATFORM
> > =A0 =A0 =A0 =A0 =A0Currently, only 8250 compatible ports are suppor=
ted, but
> > =A0 =A0 =A0 =A0 =A0others can easily be added.
> >
> > +config SERIAL_OMAP
> > + =A0 =A0 =A0 bool "OMAP serial port support"
> > + =A0 =A0 =A0 depends on ARM && ARCH_OMAP
> > + =A0 =A0 =A0 select SERIAL_CORE
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 If you have a machine based on an Texas Instruments=20
> OMAP CPU you
> > + =A0 =A0 =A0 can enable its onboard serial ports by enabling this =
option.
> > +
> > +config SERIAL_OMAP_CONSOLE
> > + =A0 =A0 =A0 bool "Console on OMAP serial port"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP
> > + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 If you have enabled the serial port on the Texas Inst=
ruments
> > OMAP
> > + =A0 =A0 =A0 CPU you can make it the console by answering Y to=20
> this option.
> > +
> > + =A0 =A0 =A0 Even if you say Y here, the currently visible=20
> virtual console
> > + =A0 =A0 =A0 (/dev/tty0) will still be used as the system=20
> console by default,
> > but
> > + =A0 =A0 =A0 you can alter that using a kernel command line=20
> option such as
> > + =A0 =A0 =A0 "console=3DttyS0". (Try "man bootparam" or see the=20
> documentation
> > of
> > + =A0 =A0 =A0 your boot loader (lilo or loadlin) about how to=20
> pass options to
> > the
> > + =A0 =A0 =A0 kernel at boot time.)
> > +
> > +config SERIAL_OMAP_DMA_UART1
> > + =A0 =A0 =A0 bool "UART1 DMA support"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 If you have enabled the serial port on the Texas Inst=
ruments
> > OMAP
> > + =A0 =A0 =A0 CPU you can enable the DMA transfer on UART 1 by answ=
ering
> > + =A0 =A0 =A0 =A0to this option.
> > +
> > +config SERIAL_OMAP_UART1_RXDMA_TIMEOUT
> > + =A0 =A0 =A0 int "Timeout value for RX DMA in microseconds"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART1
> > + =A0 =A0 =A0 default "1"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the timeout value in which you want the data=20
> pulled by RX
> > dma to
> > + =A0 =A0 =A0 =A0 be passed to the tty framework.
> > +
> > +config SERIAL_OMAP_UART1_RXDMA_BUFSIZE
> > + =A0 =A0 =A0 int "DMA buffer size for RX in bytes"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART1
> > + =A0 =A0 =A0 default "4096"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the dma buffer size for UART Rx
> > +
> > +config SERIAL_OMAP_DMA_UART2
> > + =A0 =A0 =A0 bool "UART2 DMA support"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 If you have enabled the serial port on the Texas=20
> Instruments
> > OMAP
> > + =A0 =A0 =A0 =A0 CPU you can enable the DMA transfer on UART 2 by =
answering
> > + =A0 =A0 =A0 =A0 to this option.
> > +
> > +config SERIAL_OMAP_UART2_RXDMA_TIMEOUT
> > + =A0 =A0 =A0 int "Timeout value for RX DMA in microseconds"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART2
> > + =A0 =A0 =A0 default "1"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the timeout value in which you want the data=20
> pulled by RX
> > dma to
> > + =A0 =A0 =A0 =A0 be passed to the tty framework.
> > +
> > +config SERIAL_OMAP_UART2_RXDMA_BUFSIZE
> > + =A0 =A0 =A0 int "DMA buffer size for RX in bytes"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART2
> > + =A0 =A0 =A0 default "4096"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the dma buffer size for UART Rx
> > +
> > +config SERIAL_OMAP_DMA_UART3
> > + =A0 =A0 =A0 bool "UART3 DMA support"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 If you have enabled the serial port on the Texas=20
> Instruments
> > OMAP
> > + =A0 =A0 =A0 =A0 CPU you can enable the DMA transfer on UART 3 by =
answering
> > + =A0 =A0 =A0 =A0 to this option.
> > +
> > +config SERIAL_OMAP_UART3_RXDMA_TIMEOUT
> > + =A0 =A0 =A0 int "Timeout value for RX DMA in microseconds"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART3
> > + =A0 =A0 =A0 default "1"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the timeout value in which you want the data=20
> pulled by RX
> > dma to
> > + =A0 =A0 =A0 =A0 be passed to the tty framework.
> > +
> > +config SERIAL_OMAP_UART3_RXDMA_BUFSIZE
> > + =A0 =A0 =A0 int "DMA buffer size for RX in bytes"
> > + =A0 =A0 =A0 depends on SERIAL_OMAP_DMA_UART3
> > + =A0 =A0 =A0 default "4096"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Set the dma buffer size for UART Rx
> > +
> > =A0config SERIAL_OF_PLATFORM_NWPSERIAL
> > =A0 =A0 =A0 =A0tristate "NWP serial port driver"
> > =A0 =A0 =A0 =A0depends on PPC_OF && PPC_DCR
> > diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile inde=
x
> > d5a2998..db38f2c 100644
> > --- a/drivers/serial/Makefile
> > +++ b/drivers/serial/Makefile
> > @@ -79,3 +79,4 @@ obj-$(CONFIG_SERIAL_KS8695) +=3D serial_ks8695.o
> > =A0obj-$(CONFIG_KGDB_SERIAL_CONSOLE) +=3D kgdboc.o
> > =A0obj-$(CONFIG_SERIAL_QE) +=3D ucc_uart.o
> > =A0obj-$(CONFIG_SERIAL_TIMBERDALE) =A0 =A0 =A0 =A0+=3D timbuart.o
> > +obj-$(CONFIG_SERIAL_OMAP) +=3D omap-serial.o
> > diff --git a/drivers/serial/omap-serial.c=20
> b/drivers/serial/omap-serial.c
> > new file mode 100644 index 0000000..3b84740
> > --- /dev/null
> > +++ b/drivers/serial/omap-serial.c
> > @@ -0,0 +1,1431 @@
> > +/*
> > + * drivers/serial/omap-serial.c
> > + *
> > + * Driver for OMAP3430 UART controller.
> > + *
> > + * Copyright (C) 2009 Texas Instruments.
> > + *
> > + * Authors:
> > + * =A0 =A0 Thara Gopinath =A0<thara@ti.com>
> > + * =A0 =A0 Govindraj R =A0 =A0 <govindraj.raja@ti.com>
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > +License
> > + * version 2. This program is licensed "as is" without any=20
> warranty of
> > +any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/console.h>
> > +#include <linux/serial_reg.h>
> > +#include <linux/delay.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_flip.h>
> > +#include <linux/io.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include <asm/irq.h>
> > +#include <mach/dma.h>
> > +#include <mach/dmtimer.h>
> > +#include <mach/omap-serial.h>
> > +
> > +#ifdef DEBUG
> > +#define DPRINTK =A0printk
> > +#else
> > +#define DPRINTK(x...)
> > +#endif
> > +
> > +static u8 uart_dma_tx[MAX_UARTS + 1] =3D
> > + =A0 =A0 =A0 {OMAP24XX_DMA_UART1_TX, OMAP24XX_DMA_UART2_TX,
> > OMAP24XX_DMA_UART3_TX};
> > +static u8 uart_dma_rx[MAX_UARTS + 1] =3D
> > + =A0 =A0 =A0 {OMAP24XX_DMA_UART1_RX, OMAP24XX_DMA_UART2_RX,
> > OMAP24XX_DMA_UART3_RX};
> > +
> > +struct uart_omap_dma {
> > + =A0 =A0 =A0 int rx_dma_channel;
> > + =A0 =A0 =A0 int tx_dma_channel;
> > + =A0 =A0 =A0 dma_addr_t rx_buf_dma_phys; =A0 =A0 /* Physical adres=
s of RX DMA
> > buffer */
> > + =A0 =A0 =A0 dma_addr_t tx_buf_dma_phys; =A0 =A0 /* Physical adres=
s of TX DMA
> > buffer */
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Buffer for rx dma.It is not required for tx beca=
use the
> > buffer
> > + =A0 =A0 =A0 =A0* comes from port structure
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 unsigned char *rx_buf;
> > + =A0 =A0 =A0 unsigned int prev_rx_dma_pos;
> > + =A0 =A0 =A0 int tx_buf_size;
> > + =A0 =A0 =A0 int tx_dma_state;
> > + =A0 =A0 =A0 int rx_dma_state;
> > + =A0 =A0 =A0 spinlock_t tx_lock;
> > + =A0 =A0 =A0 spinlock_t rx_lock;
> > + =A0 =A0 =A0 struct timer_list =A0 =A0 =A0 rx_timer;/* timer to po=
ll=20
> activity on rx
> > dma */
> > + =A0 =A0 =A0 int rx_buf_size;
> > + =A0 =A0 =A0 int rx_timeout;
> > +};
> > +
> > +struct uart_omap_port {
> > + =A0 =A0 =A0 struct uart_port =A0 =A0 =A0 =A0port;
> > + =A0 =A0 =A0 struct uart_omap_dma =A0 =A0uart_dma;
> > + =A0 =A0 =A0 struct platform_device =A0*pdev;
> > +
> > + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 ier;
> > + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 lcr;
> > + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 mcr;
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma;
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_buf_dm=
a_alloced;
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Some bits in registers are cleared on a read, so=
=20
> they must
> > + =A0 =A0 =A0 =A0* be saved whenever the register is read but the=20
> bits will not
> > + =A0 =A0 =A0 =A0* be immediately processed.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0lsr_break_flag;
> > +#define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
> > + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 msr_saved_flags;
> > + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
> > + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_lock;
> > +};
> > +
> > +static struct uart_omap_port *ui[MAX_UARTS + 1]; unsigned int
> > +fcr[MAX_UARTS]; unsigned long up_activity;
> > +
> > +/* Forward declaration of dma callback functions */ static void
> > +uart_tx_dma_callback(int lch, u16 ch_status, void *data);=20
> #ifdef DEBUG
> > +static void serial_omap_display_reg(struct uart_port *port); #endi=
f
> > +static void serial_omap_rx_timeout(unsigned long uart_no);=20
> static void
> > +serial_omap_start_rxdma(struct uart_omap_port *up);
> > +
> > +int console_detect(char *str)
> > +{
> > + =A0 =A0 =A0 char *next, *start =3D NULL;
> > + =A0 =A0 =A0 int i;
> > +
> > + =A0 =A0 =A0 i =3D strlen(CONSOLE_NAME);
> > + =A0 =A0 =A0 next =3D saved_command_line;
> > +
> > + =A0 =A0 =A0 while ((next =3D strchr(next, 'c')) !=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strncmp(next, CONSOLE_NAME, i)) =
{
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D next;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next++;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (!start)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> > + =A0 =A0 =A0 i =3D 0;
> > + =A0 =A0 =A0 start =3D strchr(start, '=3D') + 1;
> > + =A0 =A0 =A0 while (*start !=3D ',') {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 str[i++] =3D *start++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i > 6) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "Inv=
alid Console Name\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 str[i] =3D '\0';
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static inline unsigned int serial_in(struct uart_omap_port *up, in=
t
> > +offset) {
> > + =A0 =A0 =A0 offset <<=3D up->port.regshift;
> > + =A0 =A0 =A0 if (up->pdev->id !=3D 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return readb(up->port.membase + offse=
t);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return readw(up->port.membase + offse=
t); }
> > +
> > +static inline void serial_out(struct uart_omap_port *up,=20
> int offset,
> > +int value) {
> > + =A0 =A0 =A0 offset <<=3D up->port.regshift;
> > + =A0 =A0 =A0 if (up->pdev->id !=3D 4)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(value, up->port.membase + offs=
et);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(value, up->port.membase + offs=
et); }
> > +
> > +static inline void serial_omap_clear_fifos(struct=20
> uart_omap_port *p) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(p, UART_FCR, UART_FCR_ENAB=
LE_FIFO);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(p, UART_FCR, UART_FCR_ENAB=
LE_FIFO |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UART_F=
CR_CLEAR_RCVR |
> > UART_FCR_CLEAR_XMIT);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(p, UART_FCR, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fcr[p->pdev->id - 1] =3D 0;
> > +}
> > +
> > +/*
> > + * We have written our own function to get the divisor so=20
> as to support
> > + * 13x mode.
> > + */
> > +static unsigned int
> > +serial_omap_get_divisor(struct uart_port *port, unsigned=20
> int baud) {
> > + =A0 =A0 =A0 unsigned int divisor;
> > + =A0 =A0 =A0 if (baud > OMAP_MODE13X_SPEED && baud !=3D 3000000)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 13;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 divisor =3D 16;
> > + =A0 =A0 =A0 return port->uartclk/(baud * divisor); }
> > +
> > +static void serial_omap_stop_rxdma(struct uart_omap_port *up) {
> > + =A0 =A0 =A0 if (up->uart_dma.rx_dma_state) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&up->uart_dma.rx_timer=
);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma.rx_dma_cha=
nnel);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(up->uart_dma.rx_dma_cha=
nnel);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D 0xFF;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_state =3D 0x0;
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void serial_omap_enable_ms(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_enable_ms+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
> > + =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > +}
> > +
> > +static void serial_omap_stop_tx(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 if (up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.tx_dma_channel !=3D =
0xFF) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if dma is =
still active . If yes do
> > nothing,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* return. Else sto=
p dma
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int status =3D omap_r=
eadl(OMAP34XX_DMA4_BASE +
> > +
> > OMAP_DMA4_CCR(up->uart_dma.tx_dma_channel));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (1 << 7)=
)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retur=
n;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uar=
t_dma.tx_dma_channel);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(up->uar=
t_dma.tx_dma_channel);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_c=
hannel =3D 0xFF;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (up->ier & UART_IER_THRI) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_THRI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > + =A0 =A0 =A0 }
> > +#ifdef CONFIG_PM
> > + =A0 =A0 =A0 if (!up->uart_dma.rx_dma_state) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tmp;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D (serial_in(up, UART_OMAP_SYSC=
) & 0x7)=20
> | (2 << 3);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); =
/*=20
> smart-idle */
> > + =A0 =A0 =A0 }
> > +#endif
> > +}
> > +
> > +static void serial_omap_stop_rx(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 serial_omap_stop_rxdma(up);
> > + =A0 =A0 =A0 up->ier &=3D ~UART_IER_RLSI;
> > + =A0 =A0 =A0 up->port.read_status_mask &=3D ~UART_LSR_DR;
> > + =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > +
> > +}
> > +
> > +static inline void receive_chars(struct uart_omap_port *up, int
> > +*status) {
> > + =A0 =A0 =A0 struct tty_struct *tty =3D up->port.info->port.tty;
> > + =A0 =A0 =A0 unsigned int ch, flag;
> > + =A0 =A0 =A0 int max_count =3D 256;
> > +
> > + =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D serial_in(up, UART_RX);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =3D TTY_NORMAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rx++;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(*status & (UART_LSR_BI |=
 UART_LSR_PE |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0UART_LSR_FE |=20
> UART_LSR_OE))) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For statistics o=
nly
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*status & UART_LS=
R_BI) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *stat=
us &=3D ~(UART_LSR_FE |=20
> UART_LSR_PE);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->p=
ort.icount.brk++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =
We do the SysRQ and SAK checking
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =
here because otherwise the break
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =
may get masked by=20
> ignore_status_mask
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =
or read_status_mask.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (u=
art_handle_break(&up->port))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 goto ignore_char;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (*status & =
UART_LSR_PE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->p=
ort.icount.parity++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (*status & UA=
RT_LSR_FE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->p=
ort.icount.frame++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*status & UART_LS=
R_OE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->p=
ort.icount.overrun++;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Mask off conditi=
ons which should=20
> be ignored.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status &=3D up->port=
=2Eread_status_mask;
> > +
> > +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->port.line =3D=
=3D up->port.cons->index) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re=
cover the break flag=20
> from console
> > xmit */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *stat=
us |=3D up->lsr_break_flag;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->l=
sr_break_flag =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +#endif
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*status & UART_LS=
R_BI)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =
=3D TTY_BREAK;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (*status & UA=
RT_LSR_PE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =
=3D TTY_PARITY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (*status & UA=
RT_LSR_FE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag =
=3D TTY_FRAME;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_handle_sysrq_char(&up->port,=
 ch))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore_char;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_insert_char(&up->port, *status,=20
> UART_LSR_OE, ch,
> > flag);
> > +
> > +ignore_char:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status =3D serial_in(up, UART_LSR);
> > + =A0 =A0 =A0 } while ((*status & UART_LSR_DR) && (max_count-- > 0)=
);
> > + =A0 =A0 =A0 tty_flip_buffer_push(tty);
> > +
> > +
> > +}
> > +
> > +static void transmit_chars(struct uart_omap_port *up) {
> > + =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.info->xmit;
> > + =A0 =A0 =A0 int count;
> > +
> > + =A0 =A0 =A0 if (up->port.x_char) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TX, up->port.x_ch=
ar);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.tx++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.x_char =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (uart_circ_empty(xmit) || uart_tx_stopped(&up->por=
t)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 count =3D up->port.fifosize / 4;
> > + =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TX, xmit->buf[xmi=
t->tail]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xmit->tail =3D (xmit->tail + 1) &=20
> (UART_XMIT_SIZE - 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.tx++;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 } while (--count > 0);
> > +
> > + =A0 =A0 =A0 if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(&up->port);
> > +
> > + =A0 =A0 =A0 if (uart_circ_empty(xmit))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
> > +}
> > +
> > +static void serial_omap_start_tx(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > #ifdef
> > +CONFIG_PM
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disallow OCP bus idle. UART TX irq=
s are not seen
> > during
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* bus idle. Alternative is to set =
kernel=20
> timer at fifo
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* drain rate.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int tmp;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D (serial_in(up, UART_OMAP_SYSC=
) & 0x7)=20
> | (1 << 3);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); =
/* no-idle */
> > #endif
> > +
> > + =A0 =A0 =A0 if (up->use_dma && !(up->port.x_char)) {
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.i=
nfo->xmit;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int start =3D up->uart_dma.t=
x_buf_dma_phys +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(xmit->tail & (UART_XMIT_SIZE -
> > 1));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_circ_empty(xmit) ||=20
> up->uart_dma.tx_dma_state)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&(up->uart_dma.tx_lock));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_state =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&(up->uart_dma.tx_lock));
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D
> > uart_circ_chars_pending(xmit);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* It is a circular buffer. See if th=
e buffer has
> > wounded back.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If yes it will have to be transf=
erred in=20
> two separate
> > dma
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfers */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (start + up->uart_dma.tx_buf_size =
>=3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->u=
art_dma.tx_buf_dma_phys +
> > UART_XMIT_SIZE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_s=
ize =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->=
uart_dma.tx_buf_dma_phys +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_=
XMIT_SIZE) - start;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.tx_dma_channel =3D=3D=
 0xFF)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_request_dma(uart_dma_tx[up->pdev->id-1],
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "UART Tx DMA",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (void=20
> *)uart_tx_dma_callback,
> > up,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=20
> &(up->uart_dma.tx_dma_channel));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_set_dma_dest_params(up->uart_dma.tx_dma_channel, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0OMAP_DMA_AMODE_CONSTANT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0
> UART_BASE(up->pdev->id - 1), 0,
> > 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_set_dma_src_params(up->uart_dma.tx_dma_channel, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=20
> OMAP_DMA_AMODE_POST_INC, start,
> > 0, 0);
> > +
> > +
> > omap_set_dma_transfer_params(up->uart_dma.tx_dma_channel,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0OMAP_DMA_DATA_TYPE_S8,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0
> up->uart_dma.tx_buf_size,
> > 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0OMAP_DMA_SYNC_ELEMENT,
> > +
> > uart_dma_tx[(up->pdev->id)-1], 0);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_start_dma(up->uart_dma.tx_dma_ch=
annel);
> > +
> > + =A0 =A0 =A0 } else if (!(up->ier & UART_IER_THRI)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_THRI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static unsigned int check_modem_status(struct uart_omap_port *up) =
{
> > + =A0 =A0 =A0 int status;
> > + =A0 =A0 =A0 status =3D serial_in(up, UART_MSR);
> > +
> > + =A0 =A0 =A0 status |=3D up->msr_saved_flags;
> > + =A0 =A0 =A0 up->msr_saved_flags =3D 0;
> > +
> > + =A0 =A0 =A0 if ((status & UART_MSR_ANY_DELTA) =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> > + =A0 =A0 =A0 if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER=
_MSI &&
> > + =A0 =A0 =A0 =A0 =A0 up->port.info !=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_TERI)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rng++=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DDSR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.dsr++=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DDCD)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_dcd_chang=
e
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (&up-=
>port, status & UART_MSR_DCD);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_MSR_DCTS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_handle_cts_chang=
e
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (&up-=
>port, status & UART_MSR_CTS);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> wake_up_interruptible(&up->port.info->delta_msr_wait);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return status;
> > +}
> > +
> > +/*
> > + * This handles the interrupt from one port.
> > + */
> > +static inline irqreturn_t serial_omap_irq(int irq, void *dev_id) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D dev_id;
> > + =A0 =A0 =A0 unsigned int iir, lsr;
> > +
> > + =A0 =A0 =A0 iir =3D serial_in(up, UART_IIR);
> > + =A0 =A0 =A0 if (iir & UART_IIR_NO_INT)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
> > + =A0 =A0 =A0 lsr =3D serial_in(up, UART_LSR);
> > + =A0 =A0 =A0 if ((iir & 0x4) && up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier &=3D ~UART_IER_RDI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_start_rxdma(up);
> > + =A0 =A0 =A0 } else if (lsr & UART_LSR_DR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 receive_chars(up, &lsr);
> > + =A0 =A0 =A0 check_modem_status(up);
> > + =A0 =A0 =A0 if ((lsr & UART_LSR_THRE) && (iir & 0x2))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 transmit_chars(up);
> > + =A0 =A0 =A0 up_activity =3D jiffies;
> > +
> > + =A0 =A0 =A0 return IRQ_HANDLED;
> > +}
> > +
> > +static unsigned int serial_omap_tx_empty(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned long flags;
> > + =A0 =A0 =A0 unsigned int ret;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_tx_empty+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> > + =A0 =A0 =A0 ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ?=20
> TIOCSER_TEMT :
> > 0;
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static unsigned int serial_omap_get_mctrl(struct uart_port *port) =
{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned char status;
> > + =A0 =A0 =A0 unsigned int ret;
> > +
> > + =A0 =A0 =A0 status =3D check_modem_status(up);
> > + =A0 =A0 =A0 DPRINTK("serial_omap_get_mctrl+%d\n", up->pdev->id);
> > +
> > + =A0 =A0 =A0 ret =3D 0;
> > + =A0 =A0 =A0 if (status & UART_MSR_DCD)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_CAR;
> > + =A0 =A0 =A0 if (status & UART_MSR_RI)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_RNG;
> > + =A0 =A0 =A0 if (status & UART_MSR_DSR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_DSR;
> > + =A0 =A0 =A0 if (status & UART_MSR_CTS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D TIOCM_CTS;
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static void serial_omap_set_mctrl(struct uart_port *port,=20
> unsigned int
> > +mctrl) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned char mcr =3D 0;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_set_mctrl+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 if (mctrl & TIOCM_RTS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_RTS;
> > + =A0 =A0 =A0 if (mctrl & TIOCM_DTR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_DTR;
> > + =A0 =A0 =A0 if (mctrl & TIOCM_OUT1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_OUT1;
> > + =A0 =A0 =A0 if (mctrl & TIOCM_OUT2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_OUT2;
> > + =A0 =A0 =A0 if (mctrl & TIOCM_LOOP)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcr |=3D UART_MCR_LOOP;
> > +
> > + =A0 =A0 =A0 mcr |=3D up->mcr;
> > + =A0 =A0 =A0 serial_out(up, UART_MCR, mcr);
> > +}
> > +
> > +static void serial_omap_break_ctl(struct uart_port *port, int
> > +break_state) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_break_ctl+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> > + =A0 =A0 =A0 if (break_state =3D=3D -1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lcr |=3D UART_LCR_SBC;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lcr &=3D ~UART_LCR_SBC;
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, up->lcr);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags); }
> > +
> > +static int serial_omap_startup(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned long flags;
> > + =A0 =A0 =A0 int irq_flags =3D 0;
> > + =A0 =A0 =A0 int retval;
> > +
> > + =A0 =A0 =A0 /* Zoom2 has GPIO_102 connected to Serial device:
> > + =A0 =A0 =A0 =A0* Active High
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (up->port.flags & UPF_IOREMAP)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_flags |=3D IRQF_TRIGGER_HIGH;
> > +
> > + =A0 =A0 =A0 if (up->port.flags & UPF_SHARE_IRQ)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_flags |=3D IRQF_SHARED;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Allocate the IRQ
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 retval =3D request_irq(up->port.irq, serial_omap_irq,=
=20
> irq_flags,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->n=
ame, up);
> > + =A0 =A0 =A0 if (retval)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> > + =A0 =A0 =A0 DPRINTK("serial_omap_startup+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Stop the baud clock and disable the UART. UART w=
ill be
> > enabled
> > + =A0 =A0 =A0 =A0* back in set_termios. This is essential for DMA m=
ode
> > operations.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> > + =A0 =A0 =A0 serial_out(up, UART_DLL, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_DLM, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_MDR1_DISABLE);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Clear the FIFO buffers and disable them.
> > + =A0 =A0 =A0 =A0* (they will be reenabled in set_termios())
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 serial_omap_clear_fifos(up);
> > + =A0 =A0 =A0 serial_out(up, UART_SCR, 0x00);
> > + =A0 =A0 =A0 /* For Hardware flow control */
> > + =A0 =A0 =A0 serial_out(up, UART_MCR, 0x2);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Clear the interrupt registers.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 (void) serial_in(up, UART_LSR);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_RX);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_IIR);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_MSR);
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Now, initialize the UART
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_WLEN8);
> > + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> > + =A0 =A0 =A0 if (up->port.flags & UPF_FOURPORT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_real_interrupt(up->port.irq))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D T=
IOCM_OUT1;
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Most PC uarts need OUT2 raised t=
o enable=20
> interrupts.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_real_interrupt(up->port.irq))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D T=
IOCM_OUT2;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> > +
> > + =A0 =A0 =A0 up->msr_saved_flags =3D 0;
> > +
> > + =A0 =A0 =A0 if (up->port.flags & UPF_FOURPORT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int icp;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable interrupts on the AST Fou=
rport board
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 icp =3D (up->port.iobase & 0xfe0) | 0=
x01f;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(0x80, icp);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) inb_p(icp);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!up->is_buf_dma_alloced) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_page((unsigned
> > long)up->port.info->xmit.buf);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.info->xmit.b=
uf =3D NULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.info->xmit.b=
uf =3D
> > dma_alloc_coherent(NULL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_=
XMIT_SIZE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_=
addr_t
> > *)&(up->uart_dma.tx_buf_dma_phys),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->is_buf_dma_alloce=
d =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_timer(&(up->uart_dma.rx_timer));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timer.function =3D=20
> serial_omap_rx_timeout;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timer.data =3D up->pd=
ev->id;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Currently the buffer size is 4KB. =
Can increase it
> > later*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf =3D dma_alloc_coh=
erent(NULL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_s=
ize,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dma_addr_t=20
> *)&(up->uart_dma.rx_buf_dma_phys),
> > 0);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Finally, enable interrupts. =A0Note=
: Modem status
> > interrupts
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 * are set via set_termios(), which wi=
ll be occurring
> > imminently
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 * anyway, so we don't enable them her=
e.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier =3D UART_IER_RLSI | UART_IER_=
RDI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > +
> > + =A0 =A0 =A0 up_activity =3D jiffies;
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static void serial_omap_shutdown(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_shutdown+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Disable interrupts from this port
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 up->ier =3D 0;
> > + =A0 =A0 =A0 serial_out(up, UART_IER, 0);
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> > + =A0 =A0 =A0 if (up->port.flags & UPF_FOURPORT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset interrupts on the AST Fourpo=
rt board */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inb((up->port.iobase & 0xfe0) | 0x1f)=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl |=3D TIOCM_OUT1;
> > + =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.mctrl &=3D ~TIOCM_OUT2;
> > + =A0 =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Disable break condition and FIFOs
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, serial_in(up, UART_LCR) &
> > ~UART_LCR_SBC);
> > + =A0 =A0 =A0 serial_omap_clear_fifos(up);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Read data port to reset things, and then free th=
e irq
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 (void) serial_in(up, UART_RX);
> > + =A0 =A0 =A0 if (up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int tmp;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->is_buf_dma_alloced) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(up-=
>port.dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 U=
ART_XMIT_SIZE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
p->port.info->xmit.buf,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
p->uart_dma.tx_buf_dma_phys);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.info->xmit.b=
uf =3D NULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->is_buf_dma_alloce=
d =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rx(port);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(up->port.dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
p->uart_dma.rx_buf_size,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
p->uart_dma.rx_buf,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
p->uart_dma.rx_buf_dma_phys);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf =3D NULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D serial_in(up, UART_OMAP_SYSC)=
 & 0x7;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); =
/*=20
> force-idle */
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 free_irq(up->port.irq, up);
> > +}
> > +
> > +static void
> > +serial_omap_set_termios(struct uart_port *port, struct ktermios
> > *termios,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ktermios *old)
> > +{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned char cval;
> > + =A0 =A0 =A0 unsigned char efr =3D 0;
> > + =A0 =A0 =A0 unsigned long flags;
> > + =A0 =A0 =A0 unsigned int baud, quot;
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> > + =A0 =A0 =A0 serial_out(up, UART_DLL, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_DLM, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
> > + =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_MDR1_DISABLE);
> > + =A0 =A0 =A0 switch (termios->c_cflag & CSIZE) {
> > + =A0 =A0 =A0 case CS5:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN5;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 case CS6:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN6;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 case CS7:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN7;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 case CS8:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval =3D UART_LCR_WLEN8;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (termios->c_cflag & CSTOPB)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_STOP;
> > + =A0 =A0 =A0 if (termios->c_cflag & PARENB)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_PARITY;
> > + =A0 =A0 =A0 if (!(termios->c_cflag & PARODD))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D UART_LCR_EPAR;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Ask the core to calculate the divisor for us.
> > + =A0 =A0 =A0 =A0*/
> > +
> > + =A0 =A0 =A0 baud =3D uart_get_baud_rate(port, termios, old, 0,
> > port->uartclk/13);
> > + =A0 =A0 =A0 quot =3D serial_omap_get_divisor(port, baud);
> > +
> > + =A0 =A0 =A0 if (up->use_dma)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fcr[up->pdev->id - 1] =3D UART_FCR_EN=
ABLE_FIFO
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | 0x1 << 6 | 0x1 << 4
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | UART_FCR_DMA_SELECT;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fcr[up->pdev->id - 1] =3D UART_FCR_EN=
ABLE_FIFO
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | 0x1 << 6 | 0x1 << 4;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Ok, we're now changing the port state. =A0Do it =
with
> > + =A0 =A0 =A0 =A0* interrupts disabled.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Update the per-port timeout.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 uart_update_timeout(port, termios->c_cflag, baud);
> > +
> > + =A0 =A0 =A0 up->port.read_status_mask =3D UART_LSR_OE | UART_LSR_=
THRE |
> > UART_LSR_DR;
> > + =A0 =A0 =A0 if (termios->c_iflag & INPCK)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.read_status_mask |=3D UART_L=
SR_FE |=20
> UART_LSR_PE;
> > + =A0 =A0 =A0 if (termios->c_iflag & (BRKINT | PARMRK))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.read_status_mask |=3D UART_L=
SR_BI;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Characters to ignore
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 up->port.ignore_status_mask =3D 0;
> > + =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART=
_LSR_PE |
> > UART_LSR_FE;
> > + =A0 =A0 =A0 if (termios->c_iflag & IGNBRK) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART=
_LSR_BI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we're ignoring parity and bre=
ak indicators,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ignore overruns too (for real ra=
w support).
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_statu=
s_mask |=3D UART_LSR_OE;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* ignore all characters if CREAD is not set
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if ((termios->c_cflag & CREAD) =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.ignore_status_mask |=3D UART=
_LSR_DR;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* CTS flow control flag and modem status interrupt=
s
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 up->ier &=3D ~UART_IER_MSI;
> > + =A0 =A0 =A0 if (UART_ENABLE_MS(&up->port, termios->c_cflag))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER_MSI;
> > + =A0 =A0 =A0 serial_out(up, UART_IER, up->ier);
> > +
> > + =A0 =A0 =A0 if (termios->c_cflag & CRTSCTS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 efr |=3D (UART_EFR_CTS | UART_EFR_RTS=
);
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, cval | UART_LCR_DLAB); /*=20
> set DLAB */
> > + =A0 =A0 =A0 serial_out(up, UART_DLL, quot & 0xff); =A0 =A0 =A0 =A0=
 =A0/*=20
> LS of divisor
> > */
> > + =A0 =A0 =A0 serial_out(up, UART_DLM, quot >> 8); =A0 =A0 =A0 =A0 =
=A0 =A0/*=20
> MS of divisor
> > */
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, cval); =A0 =A0 =A0 =A0 /* re=
set DLAB */
> > + =A0 =A0 =A0 up->lcr =3D cval; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 /* Save LCR */
> > + =A0 =A0 =A0 if (up->use_dma)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SCR =A0, ((1=
 << 6) |=20
> (1 << 7)));
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xbf); =A0 =A0 =A0 =A0 /* Ac=
cess EFR */
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, UART_EFR_ECB);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0x0); =A0 =A0 =A0 =A0 =A0/* =
Access FCR */
> > + =A0 =A0 =A0 serial_out(up, UART_FCR, fcr[up->pdev->id - 1]);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xbf); =A0 =A0 =A0 =A0 /* Ac=
cess EFR */
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, efr);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, cval); =A0 =A0 =A0 =A0 /* Re=
store LCR */
> > +
> > + =A0 =A0 =A0 serial_omap_set_mctrl(&up->port, up->port.mctrl);
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Clear all the status registers and RX register b=
efore
> > + =A0 =A0 =A0 =A0* enabling UART
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 (void) serial_in(up, UART_LSR);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_RX);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_IIR);
> > + =A0 =A0 =A0 (void) serial_in(up, UART_MSR);
> > +
> > + =A0 =A0 =A0 if (baud > 230400 && baud !=3D 3000000)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_M=
DR1_MODE13X);
> > + =A0 =A0 =A0 else if (baud =3D=3D 3000000)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_M=
DR1_MODE16X);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_MDR1, OMAP_M=
DR1_MODE16X);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_set_termios+%d\n",=20
> up->pdev->id); #ifdef
> > DEBUG
> > + =A0 =A0 =A0 serial_omap_display_reg(port);
> > +#endif
> > +}
> > +
> > +static void
> > +serial_omap_pm(struct uart_port *port, unsigned int state,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int oldstate)
> > +{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned char efr;
> > + =A0 =A0 =A0 DPRINTK("serial_omap_pm+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 efr =3D serial_in(up, UART_EFR);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, efr | UART_EFR_ECB);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_IER, (state !=3D 0) ?=20
> UART_IERX_SLEEP : 0);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, efr);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0);
> > +}
> > +
> > +static void serial_omap_release_port(struct uart_port *port) {
> > + =A0 =A0 =A0 DPRINTK("serial_omap_release_port+\n");
> > +}
> > +
> > +static int serial_omap_request_port(struct uart_port *port) {
> > + =A0 =A0 =A0 DPRINTK("serial_omap_request_port+\n");
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static void serial_omap_config_port(struct uart_port=20
> *port, int flags)
> > +{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_config_port+%d\n", up->pdev->id)=
;
> > + =A0 =A0 =A0 up->port.type =3D PORT_OMAP;
> > +}
> > +
> > +static int
> > +serial_omap_verify_port(struct uart_port *port, struct=20
> serial_struct
> > +*ser) {
> > + =A0 =A0 =A0 /* we don't want the core code to modify any port par=
ams */
> > + =A0 =A0 =A0 DPRINTK("serial_omap_verify_port+\n");
> > + =A0 =A0 =A0 return -EINVAL;
> > +}
> > +
> > +static const char *
> > +serial_omap_type(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > +
> > + =A0 =A0 =A0 DPRINTK("serial_omap_type+%d\n", up->pdev->id);
> > + =A0 =A0 =A0 return up->name;
> > +}
> > +
> > +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
> > +
> > +static struct uart_omap_port *serial_omap_console_ports[4];
> > +
> > +static struct uart_driver serial_omap_reg;
> > +
> > +#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> > +
> > +/*
> > + * =A0 =A0 Wait for transmitter & holding register to empty
> > + */
> > +static inline void wait_for_xmitr(struct uart_omap_port *up) {
> > + =A0 =A0 =A0 unsigned int status, tmout =3D 10000;
> > +
> > + =A0 =A0 =A0 /* Wait up to 10ms for the character(s) to be sent. *=
/
> > + =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D serial_in(up, UART_LSR);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & UART_LSR_BI)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->lsr_break_flag =3D=
 UART_LSR_BI;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (--tmout =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> > + =A0 =A0 =A0 } while ((status & BOTH_EMPTY) !=3D BOTH_EMPTY);
> > +
> > + =A0 =A0 =A0 /* Wait up to 1s for flow control if necessary */
> > + =A0 =A0 =A0 if (up->port.flags & UPF_CONS_FLOW) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmout =3D 1000000;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (tmout =3D 1000000; tmout; tmout-=
-) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int msr =3D =
serial_in(up, UART_MSR);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->msr_saved_flags |=
=3D msr & MSR_SAVE_FLAGS;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msr & UART_MSR_CT=
S)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void serial_omap_console_putchar(struct uart_port=20
> *port, int ch)
> >
> > +{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > +
> > + =A0 =A0 =A0 wait_for_xmitr(up);
> > + =A0 =A0 =A0 serial_out(up, UART_TX, ch);
> > +}
> > +
> > +/*
> > + * Print a string to the serial port trying not to disturb
> > + * any possible real use of the port...
> > + *
> > + * =A0 =A0 The console_lock must be held when we get here.
> > + */
> > +static void
> > +serial_omap_console_write(struct console *co, const char *s,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int count)
> > +{
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D
> > serial_omap_console_ports[co->index];
> > + =A0 =A0 =A0 unsigned int ier;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0First save the IER then disable the i=
nterrupts
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 ier =3D serial_in(up, UART_IER);
> > + =A0 =A0 =A0 serial_out(up, UART_IER, 0);
> > +
> > + =A0 =A0 =A0 uart_console_write(&up->port, s, count,
> > serial_omap_console_putchar);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0Finally, wait for transmitter to beco=
me empty
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0and restore the IER
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 wait_for_xmitr(up);
> > + =A0 =A0 =A0 serial_out(up, UART_IER, ier);
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0The receive handling will happen prop=
erly=20
> because the
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0receive ready bit will still be set; =
it is=20
> not cleared
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0on read. =A0However, modem control wi=
ll not, we must
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0call it if we have saved something in=
 the=20
> saved flags
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0while processing with interrupts off.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (up->msr_saved_flags)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_modem_status(up);
> > +}
> > +
> > +static int __init
> > +serial_omap_console_setup(struct console *co, char *options) {
> > + =A0 =A0 =A0 struct uart_omap_port *up;
> > + =A0 =A0 =A0 int baud =3D 9600;
> > + =A0 =A0 =A0 int bits =3D 8;
> > + =A0 =A0 =A0 int parity =3D 'n';
> > + =A0 =A0 =A0 int flow =3D 'n';
> > + =A0 =A0 =A0 int r;
> > +
> > + =A0 =A0 =A0 if (serial_omap_console_ports[co->index] =3D=3D NULL)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > + =A0 =A0 =A0 up =3D serial_omap_console_ports[co->index];
> > +
> > + =A0 =A0 =A0 if (options)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &p=
arity, &bits,
> > &flow);
> > +
> > + =A0 =A0 =A0 r =3D uart_set_options(&up->port, co, baud, parity,=20
> bits, flow);
> > +
> > + =A0 =A0 =A0 return r;
> > +}
> > +
> > +static struct console serial_omap_console =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ttyS",
> > + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D serial_omap_console_wri=
te,
> > + =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D uart_console_device,
> > + =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D serial_omap_console_set=
up,
> > + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D CON_PRINTBUFFER,
> > + =A0 =A0 =A0 .index =A0 =A0 =A0 =A0 =A0=3D -1,
> > + =A0 =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D &serial_omap_reg,
> > +};
> > +
> > +static void serial_omap_add_console_port(struct=20
> uart_omap_port *up) {
> > + =A0 =A0 =A0 serial_omap_console_ports[up->pdev->id - 1] =3D up; }
> > +
> > +#define OMAP_CONSOLE =A0 (&serial_omap_console)
> > +
> > +#else
> > +
> > +#define OMAP_CONSOLE =A0 NULL
> > +
> > +static inline void serial_omap_add_console_port(struct=20
> uart_omap_port
> > +*up) {}
> > +
> > +#endif
> > +
> > +struct uart_ops serial_omap_pops =3D {
> > + =A0 =A0 =A0 .tx_empty =A0 =A0 =A0 =3D serial_omap_tx_empty,
> > + =A0 =A0 =A0 .set_mctrl =A0 =A0 =A0=3D serial_omap_set_mctrl,
> > + =A0 =A0 =A0 .get_mctrl =A0 =A0 =A0=3D serial_omap_get_mctrl,
> > + =A0 =A0 =A0 .stop_tx =A0 =A0 =A0 =A0=3D serial_omap_stop_tx,
> > + =A0 =A0 =A0 .start_tx =A0 =A0 =A0 =3D serial_omap_start_tx,
> > + =A0 =A0 =A0 .stop_rx =A0 =A0 =A0 =A0=3D serial_omap_stop_rx,
> > + =A0 =A0 =A0 .enable_ms =A0 =A0 =A0=3D serial_omap_enable_ms,
> > + =A0 =A0 =A0 .break_ctl =A0 =A0 =A0=3D serial_omap_break_ctl,
> > + =A0 =A0 =A0 .startup =A0 =A0 =A0 =A0=3D serial_omap_startup,
> > + =A0 =A0 =A0 .shutdown =A0 =A0 =A0 =3D serial_omap_shutdown,
> > + =A0 =A0 =A0 .set_termios =A0 =A0=3D serial_omap_set_termios,
> > + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D serial_omap_pm,
> > + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D serial_omap_type,
> > + =A0 =A0 =A0 .release_port =A0 =3D serial_omap_release_port,
> > + =A0 =A0 =A0 .request_port =A0 =3D serial_omap_request_port,
> > + =A0 =A0 =A0 .config_port =A0 =A0=3D serial_omap_config_port,
> > + =A0 =A0 =A0 .verify_port =A0 =A0=3D serial_omap_verify_port,
> > +};
> > +
> > +static struct uart_driver serial_omap_reg =3D {
> > + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 .driver_name =A0 =A0=3D "OMAP-SERIAL",
> > + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "ttyS",
> > + =A0 =A0 =A0 .major =A0 =A0 =A0 =A0 =A0=3D TTY_MAJOR,
> > + =A0 =A0 =A0 .minor =A0 =A0 =A0 =A0 =A0=3D 64,
> > + =A0 =A0 =A0 .nr =A0 =A0 =A0 =A0 =A0 =A0 =3D 4,
> > + =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D OMAP_CONSOLE,
> > +};
> > +
> > +static int serial_omap_remove(struct platform_device *dev);
> > +
> > +static
> > +int serial_omap_suspend(struct platform_device *pdev, pm_message_t
> > +state) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(pd=
ev);
> > + =A0 =A0 =A0 unsigned int tmp;
> > +
> > + =A0 =A0 =A0 if (up)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_suspend_port(&serial_omap_reg, &=
up->port);
> > + =A0 =A0 =A0 if (up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Silicon Errata 2.15 workaround.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* UART Module has to be put in for=
ce idle if it is
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* configured in DMA mode and when =
there is=20
> no activity
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* expected.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D (serial_in(up, UART_OMAP_SYSC=
) & 0x7);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); =
/*=20
> force-idle */
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static int serial_omap_resume(struct platform_device *dev) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(de=
v);
> > + =A0 =A0 =A0 if (up)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_resume_port(&serial_omap_reg, &u=
p->port);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static void serial_omap_rx_timeout(unsigned long uart_no) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D ui[uart_no - 1];
> > + =A0 =A0 =A0 unsigned int curr_dma_pos;
> > + =A0 =A0 =A0 curr_dma_pos =3D omap_readl(OMAP34XX_DMA4_BASE +
> > +
> > OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> > + =A0 =A0 =A0 if ((curr_dma_pos =3D=3D up->uart_dma.prev_rx_dma_pos=
) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(curr_dma_=
pos =3D=3D 0)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - up_act=
ivity)=20
> < 10000) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&up->uart_d=
ma.rx_timer, jiffies +
> > +
> > usecs_to_jiffies(up->uart_dma.rx_timeout));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_rxdm=
a(up);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->ier |=3D UART_IER=
_RDI;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_I=
ER, up->ier);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int curr_transmitted_size =3D=
 curr_dma_pos -
> > +
> > up->uart_dma.prev_rx_dma_pos;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.icount.rx +=3D curr_transmit=
ted_size;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_insert_flip_string(up->port.info-=
>port.tty,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->u=
art_dma.rx_buf +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->=
uart_dma.prev_rx_dma_pos -
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->u=
art_dma.rx_buf_dma_phys),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_=
transmitted_size);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tty_flip_buffer_push(up->port.info->p=
ort.tty);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D curr=
_dma_pos;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->uart_dma.rx_buf_size +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->u=
art_dma.rx_buf_dma_phys =3D=3D
> > curr_dma_pos)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_start_rxd=
ma(up);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&up->uart_d=
ma.rx_timer, jiffies +
> > +
> > usecs_to_jiffies(up->uart_dma.rx_timeout));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_activity =3D jiffies;
> > +
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +static void uart_rx_dma_callback(int lch, u16 ch_status,=20
> void *data) {
> > + =A0 =A0 =A0 return;
> > +}
> > +
> > +static void serial_omap_start_rxdma(struct uart_omap_port=20
> *up) { #ifdef
> >
> > +CONFIG_PM
> > + =A0 =A0 =A0 /* Disallow OCP bus idle. UART TX irqs are not seen d=
uring
> > + =A0 =A0 =A0 =A0* bus idle. Alternative is to set kernel timer at =
fifo
> > + =A0 =A0 =A0 =A0* drain rate.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 unsigned int tmp;
> > + =A0 =A0 =A0 tmp =3D (serial_in(up, UART_OMAP_SYSC) & 0x7) | (1 <<=
 3);
> > + =A0 =A0 =A0 serial_out(up, UART_OMAP_SYSC, tmp); /* no-idle */ #e=
ndif
> > + =A0 =A0 =A0 if (up->uart_dma.rx_dma_channel =3D=3D 0xFF) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_request_dma(uart_dma_rx[up->pdev->id-1], "UART Rx
> > DMA",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)uart_rx_dma_c=
allback, up,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(up-=
>uart_dma.rx_dma_channel));
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_set_dma_src_params(up->uart_dma.rx_dma_channel, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DMA_AMODE_CONSTANT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=20
> UART_BASE(up->pdev->id - 1), 0,
> > 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> omap_set_dma_dest_params(up->uart_dma.rx_dma_channel, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DMA_AMODE_POST_INC,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=20
> up->uart_dma.rx_buf_dma_phys, 0,
> > 0);
> > +
> > omap_set_dma_transfer_params(up->uart_dma.rx_dma_channel,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DMA_DATA_TYPE_S8,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 up->uart_dma.rx_buf_size, 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DMA_SYNC_ELEMENT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=20
> uart_dma_rx[up->pdev->id-1], 0);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 up->uart_dma.prev_rx_dma_pos =3D up->uart_dma.rx_buf_=
dma_phys;
> > + =A0 =A0 =A0 omap_writel(0, OMAP34XX_DMA4_BASE
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=20
> OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> > + =A0 =A0 =A0 omap_start_dma(up->uart_dma.rx_dma_channel);
> > + =A0 =A0 =A0 mod_timer(&up->uart_dma.rx_timer, jiffies +
> > +
> > usecs_to_jiffies(up->uart_dma.rx_timeout));
> > + =A0 =A0 =A0 up->uart_dma.rx_dma_state =3D 1;
> > +}
> > +
> > +static void serial_omap_continue_tx(struct uart_omap_port *up) {
> > + =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.info->xmit;
> > + =A0 =A0 =A0 int start =3D up->uart_dma.tx_buf_dma_phys
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (xmit->tail & (UART=
_XMIT_SIZE - 1));
> > + =A0 =A0 =A0 if (uart_circ_empty(xmit))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > + =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D uart_circ_chars_pending(=
xmit);
> > + =A0 =A0 =A0 /* It is a circular buffer. See if the buffer has=20
> wounded back.
> > + =A0 =A0 =A0 * If yes it will have to be transferred in two separa=
te dma
> > + =A0 =A0 =A0 * transfers
> > + =A0 =A0 =A0 */
> > + =A0 =A0 =A0 if (start + up->uart_dma.tx_buf_size >=3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_d=
ma_phys +=20
> UART_XMIT_SIZE)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_buf_size =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (up->uart_dma.tx_buf_=
dma_phys +=20
> UART_XMIT_SIZE)
> > - start;
> > + =A0 =A0 =A0 omap_set_dma_dest_params(up->uart_dma.tx_dma_channel,=
 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OM=
AP_DMA_AMODE_CONSTANT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UA=
RT_BASE(up->pdev->id - 1), 0, 0);
> > + =A0 =A0 =A0 omap_set_dma_src_params(up->uart_dma.tx_dma_channel, =
0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_AMODE_POST_INC, start, 0, 0)=
;
> > +
> > + =A0 =A0 =A0 omap_set_dma_transfer_params(up->uart_dma.tx_dma_chan=
nel,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0OMAP_DMA_DATA_TYPE_S8,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0up->uart_dma.tx_buf_size, 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0OMAP_DMA_SYNC_ELEMENT,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0
> uart_dma_tx[(up->pdev->id)-1], 0);
> > +
> > + =A0 =A0 =A0 omap_start_dma(up->uart_dma.tx_dma_channel);
> > +}
> > +
> > +static void uart_tx_dma_callback(int lch, u16 ch_status,=20
> void *data) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)data;
> > + =A0 =A0 =A0 struct circ_buf *xmit =3D &up->port.info->xmit;
> > + =A0 =A0 =A0 xmit->tail =3D (xmit->tail + up->uart_dma.tx_buf_size=
) & \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (UART_XMIT_SIZE - 1);
> > + =A0 =A0 =A0 up->port.icount.tx +=3D up->uart_dma.tx_buf_size;
> > +
> > + =A0 =A0 =A0 if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_write_wakeup(&up->port);
> > +
> > + =A0 =A0 =A0 if (uart_circ_empty(xmit)) {
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&(up->uart_dma.tx_lock));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_stop_tx(&up->port);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_state =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&(up->uart_dma.tx_lock));
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_stop_dma(up->uart_dma.tx_dma_cha=
nnel);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_omap_continue_tx(up);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 up_activity =3D jiffies;
> > + =A0 =A0 =A0 return;
> > +}
> > +
> > +static int serial_omap_probe(struct platform_device *pdev) {
> > + =A0 =A0 =A0 struct uart_omap_port =A0 *up;
> > + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *mem, *irq;
> > + =A0 =A0 =A0 int ret =3D -ENOSPC;
> > + =A0 =A0 =A0 char str[7];
> > +
> > + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
> > + =A0 =A0 =A0 if (!mem) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?=
\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0=
);
> > + =A0 =A0 =A0 if (!irq) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?=
\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 ret =3D (int) request_mem_region(mem->start, (mem->en=
d -
> > mem->start) + 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pdev->dev.driver->name);
> > + =A0 =A0 =A0 if (!ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "memory region al=
ready=20
> claimed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 up =3D kzalloc(sizeof(*up), GFP_KERNEL);
> > + =A0 =A0 =A0 if (up =3D=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 sprintf(up->name, "OMAP UART%d", pdev->id);
> > +
> > + =A0 =A0 =A0 up->pdev =3D pdev;
> > + =A0 =A0 =A0 up->port.dev =3D &pdev->dev;
> > + =A0 =A0 =A0 up->port.type =3D PORT_OMAP;
> > + =A0 =A0 =A0 up->port.iotype =3D UPIO_MEM;
> > + =A0 =A0 =A0 up->port.mapbase =3D mem->start;
> > + =A0 =A0 =A0 up->port.irq =3D irq->start;
> > + =A0 =A0 =A0 up->port.fifosize =3D 64;
> > + =A0 =A0 =A0 up->port.ops =3D &serial_omap_pops;
> > + =A0 =A0 =A0 up->port.line =3D pdev->id - 1;
> > + =A0 =A0 =A0 if ((pdev->id-1) =3D=3D QUART) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.membase =3D=20
> ioremap_nocache(mem->start, 0x16 <<
> > 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.flags =3D UPF_BOOT_AUTOCONF =
| UPF_IOREMAP;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.uartclk =3D QUART_CLK;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.regshift =3D 1;
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.membase =3D (void *) IO_ADDR=
ESS(mem->start);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.flags =3D UPF_BOOT_AUTOCONF;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.uartclk =3D UART_CLK;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.regshift =3D 2;
> > + =A0 =A0 =A0 }
> > +#ifdef CONFIG_PM
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->port.flags |=3D UPF_SHARE_IRQ;
> > +#endif
> > + =A0 =A0 =A0 if ((pdev->id-1) =3D=3D UART1) {
> > +#ifdef CONFIG_SERIAL_OMAP_DMA_UART1
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->use_dma =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_size =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT1_RXDMA_BUFSIZE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timeout =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT1_RXDMA_TIMEOUT;
> > +#endif
> > + =A0 =A0 =A0 } else if ((pdev->id-1) =3D=3D UART2) {
> > +#ifdef CONFIG_SERIAL_OMAP_DMA_UART2
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->use_dma =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_size =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT2_RXDMA_BUFSIZE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timeout =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT2_RXDMA_TIMEOUT;
> > +#endif
> > + =A0 =A0 =A0 } else if ((pdev->id-1) =3D=3D UART3) {
> > +#ifdef CONFIG_SERIAL_OMAP_DMA_UART3
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->use_dma =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_buf_size =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT3_RXDMA_BUFSIZE;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_timeout =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_SERIAL_OMAP_UA=
RT3_RXDMA_TIMEOUT;
> > +#endif
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (up->use_dma) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&(up->uart_dma.tx_lock=
));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&(up->uart_dma.rx_lock=
));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.tx_dma_channel =3D 0xFF;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->uart_dma.rx_dma_channel =3D 0xFF;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (console_detect(str)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\n %s: Invalid console paramt=
er...\n",
> > __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\n %s: UART Driver Init Faile=
d!\n",=20
> __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 fcr[pdev->id - 1] =3D 0;
> > + =A0 =A0 =A0 ui[pdev->id - 1] =3D up;
> > + =A0 =A0 =A0 serial_omap_add_console_port(up);
> > +
> > + =A0 =A0 =A0 ret =3D uart_add_one_port(&serial_omap_reg, &up->port=
);
> > + =A0 =A0 =A0 if (ret !=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
> > +
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, up);
> > + =A0 =A0 =A0 return 0;
> > +do_release_region:
> > + =A0 =A0 =A0 release_mem_region(mem->start, (mem->end - mem->start=
) + 1);
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static int serial_omap_remove(struct platform_device *dev) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D platform_get_drvdata(de=
v);
> > + =A0 =A0 =A0 platform_set_drvdata(dev, NULL);
> > + =A0 =A0 =A0 if (up) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_remove_one_port(&serial_omap_reg=
, &up->port);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(up);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static struct platform_driver serial_omap_driver =3D {
> > + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D serial_omap_probe,
> > + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D serial_omap_remove,
> > +
> > + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D serial_omap_suspend,
> > + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D serial_omap_resume,
> > + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap-uart",
> > + =A0 =A0 =A0 },
> > +};
> > +
> > +int __init serial_omap_init(void)
> > +{
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 ret =3D uart_register_driver(&serial_omap_reg);
> > + =A0 =A0 =A0 if (ret !=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > + =A0 =A0 =A0 ret =3D platform_driver_register(&serial_omap_driver)=
;
> > + =A0 =A0 =A0 if (ret !=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_unregister_driver(&serial_omap_r=
eg);
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +void __exit serial_omap_exit(void)
> > +{
> > + =A0 =A0 =A0 platform_driver_unregister(&serial_omap_driver);
> > + =A0 =A0 =A0 uart_unregister_driver(&serial_omap_reg);
> > +}
> > +
> > +#ifdef DEBUG
> > +static void serial_omap_display_reg(struct uart_port *port) {
> > + =A0 =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port =
*)port;
> > + =A0 =A0 =A0 unsigned int lcr, efr, mcr, dll, dlh, xon1, xon2,=20
> xoff1, xoff2;
> > + =A0 =A0 =A0 unsigned int tcr, tlr, uasr;
> > + =A0 =A0 =A0 DPRINTK("Register dump for UART%d\n", up->pdev->id);
> > + =A0 =A0 =A0 DPRINTK("IER_REG =3D 0x%x\n", serial_in(up, UART_IER)=
);
> > + =A0 =A0 =A0 DPRINTK("IIR_REG =3D 0x%x\n", serial_in(up, UART_IIR)=
);
> > + =A0 =A0 =A0 lcr =3D serial_in(up, UART_LCR);
> > + =A0 =A0 =A0 DPRINTK("LCR_REG =3D 0x%x\n", lcr);
> > + =A0 =A0 =A0 mcr =3D serial_in(up, UART_MCR);
> > + =A0 =A0 =A0 DPRINTK("MCR_REG =3D 0x%x\n", mcr);
> > + =A0 =A0 =A0 DPRINTK("LSR_REG =3D 0x%x\n", serial_in(up, UART_LSR)=
);
> > + =A0 =A0 =A0 DPRINTK("MSR_REG =3D 0x%x\n", serial_in(up, UART_MSR)=
);
> > + =A0 =A0 =A0 DPRINTK("SPR_REG =3D 0x%x\n", serial_in(up, UART_OMAP=
_SPR));
> > + =A0 =A0 =A0 DPRINTK("MDR1_REG =3D 0x%x\n", serial_in(up, UART_OMA=
P_MDR1));
> > + =A0 =A0 =A0 DPRINTK("MDR2_REG =3D 0x%x\n", serial_in(up, UART_OMA=
P_MDR2));
> > + =A0 =A0 =A0 DPRINTK("SCR_REG =3D 0x%x\n", serial_in(up, UART_OMAP=
_SCR));
> > + =A0 =A0 =A0 DPRINTK("SSR_REG =3D 0x%x\n", serial_in(up, UART_OMAP=
_SSR));
> > + =A0 =A0 =A0 DPRINTK("MVR_REG =3D 0x%x\n", serial_in(up, UART_OMAP=
_MVER));
> > + =A0 =A0 =A0 DPRINTK("SYSC_REG =3D 0x%x\n", serial_in(up, UART_OMA=
P_SYSC));
> > + =A0 =A0 =A0 DPRINTK("SYSS_REG =3D 0x%x\n", serial_in(up, UART_OMA=
P_SYSS));
> > + =A0 =A0 =A0 DPRINTK("WER_REG =3D 0x%x\n", serial_in(up, UART_OMAP=
_WER));
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> > + =A0 =A0 =A0 dll =3D serial_in(up, UART_DLL);
> > + =A0 =A0 =A0 dlh =3D serial_in(up, UART_DLM);
> > + =A0 =A0 =A0 efr =3D serial_in(up, UART_EFR);
> > + =A0 =A0 =A0 xon1 =3D serial_in(up, UART_XON1);
> > + =A0 =A0 =A0 xon2 =3D serial_in(up, UART_XON2);
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, efr | UART_EFR_ECB);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, lcr);
> > + =A0 =A0 =A0 serial_out(up, UART_MCR, mcr | UART_MCR_TCRTLR);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> > +
> > + =A0 =A0 =A0 tcr =3D serial_in(up, UART_TI752_TCR);
> > + =A0 =A0 =A0 tlr =3D serial_in(up, UART_TI752_TLR);
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, lcr);
> > + =A0 =A0 =A0 serial_out(up, UART_MCR, mcr);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> > +
> > + =A0 =A0 =A0 xoff1 =3D serial_in(up, UART_XOFF1);
> > + =A0 =A0 =A0 xoff2 =3D serial_in(up, UART_XOFF2);
> > + =A0 =A0 =A0 uasr =3D serial_in(up, UART_OMAP_UASR);
> > +
> > + =A0 =A0 =A0 serial_out(up, UART_EFR, efr);
> > + =A0 =A0 =A0 serial_out(up, UART_LCR, lcr);
> > +
> > +
> > + =A0 =A0 =A0 DPRINTK("DLL_REG =3D 0x%x\n", dll);
> > + =A0 =A0 =A0 DPRINTK("DLH_REG =3D 0x%x\n", dlh);
> > + =A0 =A0 =A0 DPRINTK("EFR_REG =3D 0x%x\n", efr);
> > +
> > + =A0 =A0 =A0 DPRINTK("XON1_ADDR_REG =3D 0x%x\n", xon1);
> > + =A0 =A0 =A0 DPRINTK("XON2_ADDR_REG =3D 0x%x\n", xon2);
> > + =A0 =A0 =A0 DPRINTK("TCR_REG =3D 0x%x\n", tcr);
> > + =A0 =A0 =A0 DPRINTK("TLR_REG =3D 0x%x\n", tlr);
> > +
> > +
> > + =A0 =A0 =A0 DPRINTK("XOFF1_REG =3D 0x%x\n", xoff1);
> > + =A0 =A0 =A0 DPRINTK("XOFF2_REG =3D 0x%x\n", xoff2);
> > + =A0 =A0 =A0 DPRINTK("UASR_REG =3D 0x%x\n", uasr);
> > +}
> > +#endif
> > +
> > +subsys_initcall(serial_omap_init);
> > +module_exit(serial_omap_exit);
> > +
> > +MODULE_DESCRIPTION("OMAP High Speed UART driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:" DRIVER_NAME);
> > +MODULE_AUTHOR("Texas Instruments Inc");
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org More=20
> majordomo info
> > at =A0http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-serial" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
>=20
>=20
> --=20
> -----
> Regards,
> Govindraj.R
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
