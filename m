From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Mon, 01 Sep 2014 15:31:56 +0200
Message-ID: <5404754C.8080809@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-6-git-send-email-bigeasy@linutronix.de> <20140818134643.GA32400@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58873 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaIANcI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 09:32:08 -0400
In-Reply-To: <20140818134643.GA32400@xps8300>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 08/18/2014 03:46 PM, Heikki Krogerus wrote:
> On Fri, Aug 15, 2014 at 07:42:33PM +0200, Sebastian Andrzej Siewior w=
rote:
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/seria=
l/8250/8250_core.c
>> index cc90c19..ab003b6 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -264,6 +264,12 @@ static const struct serial8250_config uart_conf=
ig[] =3D {
>>  		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>>  		.flags		=3D UART_CAP_FIFO | UART_CAP_AFE,
>>  	},
>> +	[PORT_OMAP_16750] =3D {
>> +		.name		=3D "OMAP",
>> +		.fifo_size	=3D 64,
>> +		.tx_loadsz	=3D 64,
>> +		.flags		=3D UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
>> +	},
>=20
> I don't think you need this. Reasons below...

=46or those it works. However I have to this value to something because
it can't stay PORT_UNKNOWN. So for now I took PORT_8250 because it is
not used anywhere in the code. The only side effect of this is that I
can't specify the name. I can live with this=85

>=20
>>  	[PORT_TEGRA] =3D {
>>  		.name		=3D "Tegra",
>>  		.fifo_size	=3D 32,
>> @@ -1390,6 +1396,8 @@ static void serial8250_stop_rx(struct uart_por=
t *port)
>>  	serial8250_rpm_get(up);
>> =20
>>  	up->ier &=3D ~UART_IER_RLSI;
>> +	if (port->type =3D=3D PORT_OMAP_16750)
>> +		up->ier &=3D ~UART_IER_RDI;
>=20
> I don't see any reason why this could not be always cleared regardles=
s
> of the type:
>=20
>         up->ier &=3D ~(UART_IER_RLSI | UART_IRE_RDI);
>=20

I remember you brought that up recently asking Alan if it is okay doing
so. Since it looks sane to revert that bit on RX-stop, I will drop that
omap check here.

> [cut]
>=20
> Since you are not calling serial8250_do_set_termios, 8250_core.c newe=
r
> overrides the FCR set in this driver. However, if the FCR is a
> problem, since Yoshihiro added the member for it to struct
> uart_8250_port (commit aef9a7bd9), just make it possible for the prob=
e
> drivers to provide also it's value:
>=20
>  static int
>=20
> So instead of using PORT_OMAP_16750:
>         up.port.type =3D PORT_16750;
>         up.capabilities =3D UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_S=
LEEP;
>=20
> and the fcr if needed.
>         up.fcr =3D ...
>=20

That fcr value looks nice so I can't drop my private copy of it.  But
this FCR works different for RX trigger (the way it is used). Which
means to support user configurable RX-level I would need to overwrite
that callback. However since PORT_8250 does not supply any FCR values,
I can just ignore it for now.

>> +	up.port.iotype =3D UPIO_MEM32;
>> +	up.port.flags =3D UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_T=
YPE |
>> +		UPF_SOFT_FLOW | UPF_HARD_FLOW;
>> +	up.port.private_data =3D priv;
>> +
>> +	up.port.regshift =3D 2;
>> +	up.port.fifosize =3D 64;
>=20
> You don't need to set the fifosize unless you want to replace the
> value you get from uart_config array.
Since you made me drop my uart_config array entry I keep this and add
the other values, too

>> +	up.port.set_termios =3D omap_8250_set_termios;
>> +	up.port.pm =3D omap_8250_pm;
>> +	up.port.startup =3D omap_8250_startup;
>> +	up.port.shutdown =3D omap_8250_shutdown;
>> +	up.port.throttle =3D omap_8250_throttle;
>> +	up.port.unthrottle =3D omap_8250_unthrottle;
>> +
>> +	if (pdev->dev.of_node) {
>> +		up.port.line =3D of_alias_get_id(pdev->dev.of_node, "serial");
>> +		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +				&up.port.uartclk);
>> +		priv->wakeirq =3D irq_of_parse_and_map(pdev->dev.of_node, 1);
>> +	} else {
>> +		up.port.line =3D pdev->id;
>> +	}
>> +
>> +	if (up.port.line < 0) {
>> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
>> +				up.port.line);
>> +		return -ENODEV;
>> +	}
>> +	if (!up.port.uartclk) {
>> +		up.port.uartclk =3D DEFAULT_CLK_SPEED;
>> +		dev_warn(&pdev->dev,
>> +				"No clock speed specified: using default: %d\n",
>> +				DEFAULT_CLK_SPEED);
>> +	}
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +	up.capabilities |=3D UART_CAP_RPM;
>> +#endif
>=20
> By setting this here, you will not get the capabilities from the
> uart_config[type].flags if runtime PM is enabled in any case, right?

Yes. It was not plan to behave like this and is fixed, thanks.

> [cut]
>=20
>> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8=
250/Makefile
>> index 36d68d0..4bac392 100644
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_SERIAL_8250_HUB6)		+=3D 8250_hub6.o
>>  obj-$(CONFIG_SERIAL_8250_FSL)		+=3D 8250_fsl.o
>>  obj-$(CONFIG_SERIAL_8250_DW)		+=3D 8250_dw.o
>>  obj-$(CONFIG_SERIAL_8250_EM)		+=3D 8250_em.o
>> +obj-$(CONFIG_SERIAL_8250_OMAP)		+=3D 8250_omap.o
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/s=
erial_core.h
>> index 5820269..74f9b11 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -54,7 +54,8 @@
>>  #define PORT_ALTR_16550_F32 26	/* Altera 16550 UART with 32 FIFOs *=
/
>>  #define PORT_ALTR_16550_F64 27	/* Altera 16550 UART with 64 FIFOs *=
/
>>  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs=
 */
>> -#define PORT_MAX_8250	28	/* max port ID */
>> +#define PORT_OMAP_16750	29	/* TI's OMAP internal 16C750 compatible =
UART */
>> +#define PORT_MAX_8250	29	/* max port ID */
>=20
> So in this case I see no reason for new type.

gone.

>=20
> Cheers,
>=20


Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
