From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH]: Adding support for omap-serail driver
Date: Fri, 28 Aug 2009 15:05:45 +0100
Message-ID: <20090828150545.5cf9dae5@lxorguk.ukuu.org.uk>
References: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751229AbZH1OEh@vger.kernel.org>
In-Reply-To: <ce9ab5790908280649n77765dedm9161316a181b6a07@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> +#define UART_BASE(uart_no)		(uart_no == UART1) ? OMAP_UART1_BASE :\
> +					(uart_no == UART2) ? OMAP_UART2_BASE :\
> +					 OMAP_UART3_BASE

Would be cleaner if this was simply an array (and probably faster)

> +
> +#define UART_MODULE_BASE(uart_no)	(UART1 == uart_no ? \
> +						IO_ADDRESS(OMAP_UART1_BASE) :\
> +					(UART2 == uart_no ? \
> +						IO_ADDRESS(OMAP_UART2_BASE) :\
> +						IO_ADDRESS(OMAP_UART3_BASE)))

Ditto

> +extern unsigned int fcr[MAX_UARTS];
> +extern char *saved_command_line;

We really don't wang globals floating around with names like fcr - and
why is saved command line needed when we have module option parsing
functions ?


> +unsigned int fcr[MAX_UARTS];
> +unsigned long up_activity;

Not acceptable as global names - too big a risk of clashes



> +static int serial_omap_startup(struct uart_port *port)
> +{
> +	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +	unsigned long flags;
> +	int irq_flags = 0;
> +	int retval;
> +
> +	/* Zoom2 has GPIO_102 connected to Serial device:
> +	 * Active High
> +	 */
> +	if (up->port.flags & UPF_IOREMAP)
> +		irq_flags |= IRQF_TRIGGER_HIGH;

Don't hijack flags here - especially as a patch is pending that adds a
separate field for IRQ flags to clean that up properly. Build on top of
that fix instead



> +	if (up->port.flags & UPF_FOURPORT) {
> +		unsigned int icp;
> +		/*
> +		 * Enable interrupts on the AST Fourport board
> +		 */
> +		icp = (up->port.iobase & 0xfe0) | 0x01f;
> +		outb_p(0x80, icp);
> +		(void) inb_p(icp);
> +	}

Can you really have an AST 4port built into an OMAP - I think all the
UPF_FOURPORT code can go



Looks basically sound otherwise
