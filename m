From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_omap: provide complete custom startup &
 shutdown callbacks
Date: Sun, 31 May 2015 16:19:24 +0900
Message-ID: <20150531071924.GB9051@kroah.com>
References: <20150520200735.GA7790@linutronix.de>
 <55647DF8.4030209@hurleysoftware.com>
 <20150526160926.GE16525@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41230 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758309AbbEaHWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 May 2015 03:22:33 -0400
Content-Disposition: inline
In-Reply-To: <20150526160926.GE16525@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.com, tony@atomide.comm, nm@ti.com, linux-serial@vger.kernel.org

On Tue, May 26, 2015 at 09:09:26AM -0700, Tony Lindgren wrote:
> * Peter Hurley <peter@hurleysoftware.com> [150526 07:14]:
> > On 05/20/2015 04:07 PM, Sebastian Andrzej Siewior wrote:
> > > The currently in-use port->startup and port->shutdown are "okay". The
> > > startup part for instance does the tiny omap extra part and invokes
> > > serial8250_do_startup() for the remaining pieces. The workflow in
> > > serial8250_do_startup() is okay except for the part where UART_RX is
> > > read without a check if there is something to read. I tried to
> > > workaround it in commit 0aa525d11859 ("tty: serial: 8250_core: read only
> > > RX if there is something in the FIFO") but then reverted it later in
> > > commit ca8bb4aefb9 ("serial: 8250: Revert "tty: serial: 8250_core: read
> > > only RX if there is something in the FIFO"").
> > > 
> > > This is the second attempt to get it to work on older OMAPs without
> > > breaking other chips this time
> > > Peter Hurley suggested to pull in the few needed lines from
> > > serial8250_do_startup() and drop everything else that is not required
> > > including making it simpler like using just request_irq() instead the
> > > chain handler like it is doing now.
> > > So lets try that.
> > 
> > Thanks, Sebastian.
> > 
> > Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> 
> Can we please get this into the v4.1-rc series?
> 
> It fixes the following:
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a000                                                       
> ...                                                                                                                           
> [<c04217e8>] (mem_serial_in) from [<c0425480>] (serial8250_do_startup+0xe4/0x694)
> [<c0425480>] (serial8250_do_startup) from [<c0427e48>] (omap_8250_startup+0x70/0x144)
> [<c0427e48>] (omap_8250_startup) from [<c0425a54>] (serial8250_startup+0x24/0x30)
> [<c0425a54>] (serial8250_startup) from [<c04208e4>] (uart_startup.part.14+0x8c/0x1a0)
> [<c04208e4>] (uart_startup.part.14) from [<c0420fec>] (uart_open+0xd8/0x134)
> [<c0420fec>] (uart_open) from [<c0403e50>] (tty_open+0xdc/0x5e0)
> [<c0403e50>] (tty_open) from [<c018f008>] (chrdev_open+0xac/0x188)

This is a "big" patch to come so late in the -rc cycle.  It's been
broken since 4.0, so it can't be _that_ important of a thing if no one
has been screaming about it :)

Are you willing to justify this to Linus as to why it should go in now?

thanks,

greg k-h
