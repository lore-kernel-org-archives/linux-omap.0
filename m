From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 29 Mar 2012 04:26:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203290356190.2788@utopia.booyaka.com>
References: <WC20120322110946.6413AA@terrafix.co.uk> <87r4wka6bf.fsf@ti.com> <WC20120326134115.9815DF@terrafix.co.uk> <87haxaq3ua.fsf@ti.com> <CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com> <878viln2t5.fsf@ti.com>
 <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com> <WC20120328153855.621724@terrafix.co.uk> <87vcloipow.fsf@ti.com> <WC20120329083556.20174D@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55779 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab2C2K0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 06:26:40 -0400
In-Reply-To: <WC20120329083556.20174D@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "Raja\\, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, neilb@suse.de

Hello Joe,

thanks for reporting this.  Some thoughts -- really just pure speculation 
-- but I hope some of it might be useful for you...

On Thu, 29 Mar 2012, Joe Woodward wrote:

> After digging a bit further I found that the problem isn't lost characters or character corruption at all...
> 
> The UART is actually at 430KBaud (not 900KBaud as I mentioned earlier).

430Kbps?  Could you confirm this?  OMAP UARTs don't support that rate as 
far as I know - the closest is 460Kbps (OMAP34xx TRM vZR Table 17-1 "UART 
Mode Baud Rates, Divisor Values, and Error Rates).  If one was desperate, 
it might be possible to get 430Kbps by tweaking other parts of the clock 
tree though...

> The data received is very bursty (i.e. sets of messages every second or 
> so), containing a sync sequence to indicate a start of packet.
> 
> The received bytes should be: 0x01, 0x52, 0x41 ....rest of packet.
> 
> This works 100% of the time on 3.2, but on 3.3 I sometimes (but not always) get: 0x01, 0x00, 0x52, 0x41.
> 
> i.e. there is a NULL/0x00 inserted after the first character.

Is this on the serial console, or on a non-console serial port?

Looking at drivers/tty/serial/omap-serial.c:receive_chars(), I wonder if 
the driver is somehow reading bytes from the RX FIFO when it's empty.  
It's unclear to me how this could happen.  But you might want to try doing 
an LSR read right before entering the loop in 
drivers/tty/serial/omap-serial.c:receive_chars().  In stock v3.3, this 
would mean adding

		lsr = serial_in(up, UART_LSR);

at line 190 of drivers/tty/serial/omap-serial.c.


You might also try the DMA path as an experiment.  This will totally wedge 
power management due to an insanely low timer expiration in that path, but 
at least might help narrow the problem down.  To do so with a quick hack, 
you could set omap_serial_default_info.dma_enabled to true instead of 
false at arch/arm/mach-omap2/serial.c:76.


And one other thing to try: does the behavior change if you set uart_debug 
to true at arch/arm/mach-omap2/serial.c:278 ?


- Paul
