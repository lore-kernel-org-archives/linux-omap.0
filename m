From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP: UART: fix full-fifo write abort
Date: Wed, 27 Jan 2010 23:13:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C09C5C78@dbde02.ent.ti.com>
References: <1264588584-13301-1-git-send-email-santosh.shilimkar@ti.com>
 <20100127173249.GC23505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51314 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0A0RnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 12:43:22 -0500
In-Reply-To: <20100127173249.GC23505@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

Thanks Tony.
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, January 27, 2010 11:03 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Woodruff, Richard; Ghorai, Sukumar
> Subject: Re: [PATCH] OMAP: UART: fix full-fifo write abort
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100127 02:34]:
> > This patch is addition to the already merged commit on non-empty
> > uart fifo read abort. "ce13d4716a276f4331d78ba28a5093a63822ab95"
> >
> > OMAP3630 and OMAP4430 UART IP blocks have a restriction on TX FIFO
> > too. If you try to write to the tx fifo when it is full, the system aborts.
> >
> > This can be easily reproducible by not suppressing interconnect errors or
> > long duartion testing where continous prints over console from multiple
> > threads . This patch is addressing the issue by ensuring that write is
> > not issued while fifo is full. A timeout is added to avoid any hang
> > on fifo-full for 10 mS which is unlikely case.
> >
> > Patch is validated on OMAP3630 and OMAP4 SDP.
> 
> Can you do this as needed based on the FIFO interrupt?
Fifo-interrupt based case is already handled in generic driver.
Kernel prints will still use non-interrupt mode which can still create the issue.

At least performance use cases like MODEM, BT can make use of DMA based UART transfer 
where this limitation won't be there.  
> 
> > Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > CC: Ghorai Sukumar <s-ghorai@ti.com>
> > ---
> >  arch/arm/mach-omap2/serial.c |   30 ++++++++++++++++++++++++++++--
> >  1 files changed, 28 insertions(+), 2 deletions(-)
> >
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> 
> <snip>
> 
> > +static void serial_out_override(struct uart_port *up, int offset, int value)
> > +{
> > +	unsigned int status, tmout = 10000;
> > +
> > +	/* Wait up to 10ms for the character(s) to be sent. */
> > +	do {
> > +		status = __serial_read_reg(up, UART_LSR);
> > +		if (--tmout == 0)
> > +			break;
> > +		udelay(1);
> > +	} while (!(status & UART_LSR_THRE));
> > +
> > +	__serial_write_reg(up, offset, value);
> 
> Do you really want to have a udelay on every TX?
> 
> How about:
> 
> 	status = __serial_read_reg(up, UART_LSR);
> 	while (!(status & UART_LSR_THRE)) {
> 
> 		if (--tmout == 0)
> 			break;
> 
> 		udelay(1);
> 		status = __serial_read_reg(up, UART_LSR);
> 	}
> 	__serial_write_reg(up, offset, value);
This is good. Will fix this.
