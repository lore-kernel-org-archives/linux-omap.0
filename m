From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] serial: 8250_omap: provide complete custom startup &
 shutdown callbacks
Date: Mon, 18 May 2015 15:06:44 -0700
Message-ID: <20150518220643.GK10274@atomide.com>
References: <20150518164720.GA29261@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51949 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbbERWGq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 May 2015 18:06:46 -0400
Content-Disposition: inline
In-Reply-To: <20150518164720.GA29261@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [150518 09:48]:
> The currently in-use port->startup and port->shutdown are "okay". The
> startup part for instance does the tiny omap extra part and invokes
> serial8250_do_startup() for the remaining pieces. The workflow in
> serial8250_do_startup() is okay except for the part where UART_RX is
> read without a check if there is something to read. I tried to
> workaround it in commit 0aa525d1 ("tty: serial: 8250_core: read only
> RX if there is something in the FIFO") but then reverted it later in
> commit ca8bb4aefb9 ("serial: 8250: Revert "tty: serial: 8250_core: read
> only RX if there is something in the FIFO"").
> 
> This is the second attempt to get it to work on older OMAPs without
> breaking other chips this time :)
> Peter Hurley suggested to pull in the few needed lines from
> serial8250_do_startup() and drop everything else that is not required
> including makeing it simpler like using just request_irq() instead the
> chain handler like it is doing now.
> So lets try that.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Peter is this what you had in mind? If so I will repost it without the
> RFC. And I think tony would like a stable + fixes tag for it.

Yes please, this fixes an oops for omaps in v4.1-rc series:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a000                                                         
...                                                                                                                             
[<c04217e8>] (mem_serial_in) from [<c0425480>] (serial8250_do_startup+0xe4/0x694)                                               
[<c0425480>] (serial8250_do_startup) from [<c0427e48>] (omap_8250_startup+0x70/0x144)                                           
[<c0427e48>] (omap_8250_startup) from [<c0425a54>] (serial8250_startup+0x24/0x30)                                               
[<c0425a54>] (serial8250_startup) from [<c04208e4>] (uart_startup.part.14+0x8c/0x1a0)                                           
[<c04208e4>] (uart_startup.part.14) from [<c0420fec>] (uart_open+0xd8/0x134)                                                    
[<c0420fec>] (uart_open) from [<c0403e50>] (tty_open+0xdc/0x5e0)                                                                
[<c0403e50>] (tty_open) from [<c018f008>] (chrdev_open+0xac/0x188)    

Fixes: ca8bb4aefb93 ("serial: 8250: Revert "tty: serial: 8250_core:
read only RX if there is something in the FIFO"")
Tested-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
