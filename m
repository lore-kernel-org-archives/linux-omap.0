From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Wed, 24 Sep 2014 09:53:46 +0200
Message-ID: <20140924075346.GB19565@linutronix.de>
References: <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <5421A7F7.3070109@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5421A7F7.3070109@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

* Peter Hurley | 2014-09-23 13:03:51 [-0400]:

>readline() does this; it 'saves' the caller's termios, sets termios
>for non-canonical reads, reads one char, and 'restores' the caller's
>termios.

interresting, thanks. I guess I would need to opimize this a little so
the baudrate isn't going to 0 and back to the requested baudrate.

>The tty core calls the driver's wait_until_sent() method before changi=
ng
>the termios (if TCSADRAIN is used for tcsetattr(), which I think for r=
eadline()
>it does).

The interresting difference is that when I take the yocto RFS and chroo=
t
into from Debian then I don't this problem. Not sure if this is really
readline or something else=E2=80=A6

>But DMA is cheating if the UART driver's tx_empty() method is saying t=
he
>transmitter is empty while TX DMA is still running.
This shouldn't be the case. But I will check this once I able to.
After TX-DMA is done, "xmit->tail" is updated and port.icount.tx is
incremented. At this time the TX FIFO is still full (up to 64 bytes) an=
d
I set UART_IER_THRI to wait until TX FIFO is empty so I can disable
runtime-pm. Therefore I would assume LSR does not say BOTH_EMPTY until
the FIFO is empty.

>Regards,
>Peter Hurley

Sebastian
