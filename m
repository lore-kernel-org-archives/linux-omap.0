From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250: Revert "tty: serial: 8250_core: read only
 RX if there is something in the FIFO"
Date: Tue, 12 May 2015 13:25:50 -0700
Message-ID: <20150512202550.GH15563@atomide.com>
References: <54DBB531.2030504@hurleysoftware.com>
 <20150211200313.GE2531@atomide.com>
 <54DBBE9E.90104@hurleysoftware.com>
 <54DC6832.3070507@linutronix.de>
 <54DCD584.3010500@hurleysoftware.com>
 <20150212192333.GA18882@linutronix.de>
 <54DD053A.8060905@hurleysoftware.com>
 <20150213185115.GF5482@linutronix.de>
 <20150213231519.GF8670@n2100.arm.linux.org.uk>
 <20150215173216.GA8660@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150215173216.GA8660@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Nicolas Schichan <nschichan@freebox.fr>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [150215 09:35]:
> This reverts commit 0aa525d11859c1a4d5b78fdc704148e2ae03ae13.
> 
> The conditional RX-FIFO read seems to cause spurious interrupts and we
> see just:
> |serial8250: too much work for irq29
> 
> The previous behaviour was "default" for decades and Marvell's 88f6282 SoC
> might not be the only that relies on it. Therefore the Omap fix is
> reverted for now.
> 
> Fixes: 0aa525d11859 ("tty: serial: 8250_core: read only RX if there is
> something in the FIFO")
> Reported-By: Nicolas Schichan <nschichan@freebox.fr>
> Debuged-By: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> * Russell King - ARM Linux | 2015-02-13 23:15:19 [+0000]:
> 
> >On Fri, Feb 13, 2015 at 07:51:16PM +0100, Sebastian Andrzej Siewior wrote:
> >> Something like this maybe?
> >
> >My personal feeling is that as 0aa525d11859 was wrong, it should be
> >reverted and this should be another attempt to fix the problem.  In
> >other words, there should be two patches, one a revert of the previously
> >known bad commit and this one having another go at it.
> >
> >I feel that would be a better approach, since then we don't end up
> >with this change building on a previously know buggy change.  It
> >would also make the changes to this solution from the previous,
> >known-to-work-for-decades code more obvious.
> 
> Okay. So here is the revert.

After the revert looks like now we get the following on omaps with
8250.. Do you have a fix available somewhere on top of your revert?

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a000
...
[<c04217e8>] (mem_serial_in) from [<c0425480>] (serial8250_do_startup+0xe4/0x694)
[<c0425480>] (serial8250_do_startup) from [<c0427e48>] (omap_8250_startup+0x70/0x144)
[<c0427e48>] (omap_8250_startup) from [<c0425a54>] (serial8250_startup+0x24/0x30)
[<c0425a54>] (serial8250_startup) from [<c04208e4>] (uart_startup.part.14+0x8c/0x1a0)
[<c04208e4>] (uart_startup.part.14) from [<c0420fec>] (uart_open+0xd8/0x134)
[<c0420fec>] (uart_open) from [<c0403e50>] (tty_open+0xdc/0x5e0)
[<c0403e50>] (tty_open) from [<c018f008>] (chrdev_open+0xac/0x188)
...

Regards,

Tony
