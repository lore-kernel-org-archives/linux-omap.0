From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Mon, 11 Apr 2016 10:18:22 +0200
Message-ID: <87y48kftip.fsf@linutronix.de>
References: <8737r7ght7.fsf@linutronix.de>
	<570339E8.6010808@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/31/2016 01:41 AM, John Ogness wrote:
>> It has been observed that the TX-DMA can stall
>
> Does this happen on any other OMAP part besides am335x?
> I looked back over the LKML history of this and didn't see
> any other design implicated in this problem.

I just ran the tests again using 4.6-rc2. I am able to reproduce the
dma-tx stall with am335x/edma and dra7/sdma.

Note: To achieve the stall, both the delayed_restore and the
      rx_dma_broken features of the mainline 8250_omap driver needed to
      be removed.

John Ogness
