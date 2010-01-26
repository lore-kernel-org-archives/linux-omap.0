From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic
Date: Tue, 26 Jan 2010 09:22:21 -0800
Message-ID: <20100126172221.GB17449@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <FCCFB4CDC6E5564B9182F639FC356087030070F293@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54811 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab0AZRWH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 12:22:07 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087030070F293@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Pandita, Vikram <vikram.pandita@ti.com> [100118 17:24]:
> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
> >Lindgren
> >Sent: Friday, January 15, 2010 7:35 PM
> >To: linux-arm-kernel@lists.infradead.org
> >Cc: linux-omap@vger.kernel.org
> >Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
> 
> UART_SCR 		-> this is the scratchpad register 
> UART_OMAP_SCR	-> This is TI-only Supplementary control register
> 
> You probably confused the two (as rightly so since SCR is same name).
> So there is no need to save/restore the UART_SCR register as you have done, see inlined -- 
> 
> >
> >Define arch_decomp_setup() the same way as some other
> >architectures do. Use arch_id to configure the debug uart
> >based on the machine_is by storing it into the uart
> >scratchpad register for DEBUG_LL code to use.
> >
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> <snip>
> >--- a/arch/arm/mach-omap2/serial.c
> >+++ b/arch/arm/mach-omap2/serial.c
> >@@ -161,11 +161,22 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
> > static inline void __init omap_uart_reset(struct omap_uart_state *uart)
> > {
> > 	struct plat_serial8250_port *p = uart->p;
> >+	u8 scratchpad = 0;
> >+
> >+	/*
> >+	 * Save UART1 scratchpad register value for UART1 for DEBUG_LL.
> >+	 * See also include/plat/uncompress.h and include/mach/debug-macro.S.
> >+	 */
> >+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
> >+		scratchpad = serial_read_reg(p, UART_SCR);
> 
> No need to save and restore the UART_SCR register. 
> This never gets used in this function.
> 
> What gets used is UART_OMAP_SCR which is OMAP specific supplimantry control register 
> and not scratchpad.
> 
> >
> > 	serial_write_reg(p, UART_OMAP_MDR1, 0x07);
> > 	serial_write_reg(p, UART_OMAP_SCR, 0x08);
> > 	serial_write_reg(p, UART_OMAP_MDR1, 0x00);
> > 	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
> >+
> >+	if (p->mapbase == OMAP2_UART1_BASE)	/* OMAP2/3/4UART1_BASE */
> >+		serial_write_reg(p, UART_SCR, scratchpad);
> 
> Remove this as well. No need. 

Just to clarify, the uncompress.h code is using the UART_SCR to store the
DEBUG_LL port number based on the machine ID.

The reason this code is not needed is that the earlyprintk code prints
out something already before we get to this code.

If earlyprintk did not print anything before this code, we would need
to save UART_SCR here as the debug serial port gets initialized the first
time something is printed.

Although the code above uses UART_OMAP_SCR and not UART_SCR, it resets
the uart so we lose UART_SCR.

So in any case I've dropped the code above.

Regards,

Tony
