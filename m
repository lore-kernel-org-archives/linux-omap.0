From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
Date: Tue, 1 Sep 2009 19:40:24 +0530
Message-ID: <d6a0f7aa0909010710o13021e7hd186f62195d63cdf@mail.gmail.com>
References: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com>
	 <20090828150545.5cf9dae5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20090828150545.5cf9dae5@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vimal singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 28, 2009 at 7:35 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wro=
te:
>> +#define UART_BASE(uart_no) =A0 =A0 =A0 =A0 =A0 (uart_no =3D=3D UART=
1) ? OMAP_UART1_BASE :\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (uart_no =3D=3D UART2) ? OMAP_UART2_BASE :\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OMAP_UART3_BASE
>
> Would be cleaner if this was simply an array (and probably faster)
>
>> +
>> +#define UART_MODULE_BASE(uart_no) =A0 =A0(UART1 =3D=3D uart_no ? \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 IO_ADDRESS(OMAP_UART1_BASE) :\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (UART2 =3D=3D uart_no ? \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 IO_ADDRESS(OMAP_UART2_BASE) :\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 IO_ADDRESS(OMAP_UART3_BASE)))
>
> Ditto
>
>> +extern unsigned int fcr[MAX_UARTS];
>> +extern char *saved_command_line;
>
> We really don't wang globals floating around with names like fcr - an=
d
> why is saved command line needed when we have module option parsing
> functions ?
>
>
>> +unsigned int fcr[MAX_UARTS];
>> +unsigned long up_activity;
>
> Not acceptable as global names - too big a risk of clashes
>
>
>
>> +static int serial_omap_startup(struct uart_port *port)
>> +{
>> + =A0 =A0 struct uart_omap_port *up =3D (struct uart_omap_port *)por=
t;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 int irq_flags =3D 0;
>> + =A0 =A0 int retval;
>> +
>> + =A0 =A0 /* Zoom2 has GPIO_102 connected to Serial device:
>> + =A0 =A0 =A0* Active High
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (up->port.flags & UPF_IOREMAP)
>> + =A0 =A0 =A0 =A0 =A0 =A0 irq_flags |=3D IRQF_TRIGGER_HIGH;
>
> Don't hijack flags here - especially as a patch is pending that adds =
a
> separate field for IRQ flags to clean that up properly. Build on top =
of
> that fix instead


Can you provide me the link to that patch.

-----
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
