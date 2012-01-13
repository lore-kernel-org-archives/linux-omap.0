From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 16:34:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201131606310.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <87hazzquhb.fsf@ti.com> <87lipbp6uq.fsf@ti.com> <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52521 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2AMXeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 18:34:07 -0500
In-Reply-To: <alpine.DEB.2.00.1201131543580.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: govindraj.raja@ti.com, Kevin Hilman <khilman@ti.com>
Cc: NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, t-kristo@ti.com, linux-omap@vger.kernel.org

Hi

just to follow up on this, I think there are some other bugs in this 
formula... maybe someone might want to tackle them.

On Fri, 13 Jan 2012, Paul Walmsley wrote:

>         up->calc_latency = (1000000 * up->port.fifosize) /
>                                 (baud / 8);

One problem is that UARTs generally don't transmit only 8 bits per byte.  
In the most common framing arrangement, 8N1, there are ten bits per byte.  
See for example

    https://en.wikipedia.org/wiki/8-N-1

So that part of this formula will contribute to an underestimation of the 
time it takes to fill the FIFO.  Using 10 data bits per byte adds another 
277 microseconds.

So ideally this formula should change the "8" depending on the number of 
data bits, whether there is a parity bit, and on the number of stop bits.  
The real formula to determine the number of bits per byte should be 
something like:

    bits_per_byte = number of data bits + 1 bit if parity is used + number 
                    of stop bits

Those quantities should all be easily available in 
serial_omap_set_termios().  So then the formula would be:

         up->calc_latency = (1000000 * up->port.fifosize) /
                                 (baud / bits_per_byte);


...

Another issue is that the formula is missing the receive FIFO trigger 
level watermark.  That might contribute to an overestimation of the amount 
of time available for the MPU to service the FIFO.  So rather than using 
simply up->port.fifosize, it should use (up->port.fifosize - 
up.port->rxtrigthres).  up.port->rxtrigthres should be the appropriate 
number derived from the 34xx TRM vZR section 17.4.2.1.2 "Receive FIFO 
Trigger" section - it comes from the UART's TCR register.

So then it would be

         up->calc_latency = 
               (1000000 * (up->port.fifosize - up->port.rxtrigthres)) /
                                 (baud / bits_per_byte);

It seems however that omap-serial.c just hardcodes the rxtrigthres to 0, 
so maybe this is not such a significant issue:

	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);

Ideally the two FIFO thresholds here would be configurable by the UART 
user - especially given that the OMAP UART can be quite deep - 60 bytes.

...

One other issue.  If flow control is enabled, then IMHO, the UART probably 
shouldn't set a wakeup latency constraint at all.  That's because there 
would be no risk of data loss.  Users of the UART might have some 
performance constraints, but those should be set by the UART-using code or 
some system-wide wakeup latency value.

...

As an aside, I wonder how we handle the UART flow control lines during 
chip off-mode?  I assume those would need an appropriate off-mode mux 
value to indicate that the OMAP UART isn't ready; I wonder if we do that?

  
- Paul
