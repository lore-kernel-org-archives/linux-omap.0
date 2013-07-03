From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: AM335x: is AUTORTS mode supported ?
Date: Wed, 03 Jul 2013 17:02:44 +0100
Message-ID: <51D44B24.3050407@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

I'm struggling to determine if AUTORTS mode is currently supported in 3.10 ?

I have dug into the source code, and can see various references to the relevant bits
in the various UART registers, but I'm at a lose as to how to actually *enable* the
mode !!

In drivers/tty/omap-serial.c serial_omap_set_termios() we have:-

	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
		/* Enable AUTORTS and AUTOCTS */
		up->efr |= UART_EFR_CTS | UART_EFR_RTS;

		/* Ensure MCR RTS is asserted */
		up->mcr |= UART_MCR_RTS;
	} else {
		...
	}

So it looks like I need to set the CRTSCTS and UPF_HARD_FLOW flags.

>From userspace, I've tried:-

$ stty -F /dev/ttyO2 crtscts

But I've not idea how to enable UPF_HARD_FLOW !?!

Can anyone point me in the right direction ?

Cheers
Mark J.
