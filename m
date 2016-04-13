From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: omap uart + dma issues (Re: [PATCH] tty: serial: 8250_omap: do
 not defer termios changes)
Date: Wed, 13 Apr 2016 16:41:23 +0530
Message-ID: <570E295B.2030708@ti.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
 <570C04C1.40201@hurleysoftware.com> <570D2A46.2050106@linutronix.de>
 <570D8C16.1010702@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570D8C16.1010702@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 13 April 2016 05:30 AM, Peter Hurley wrote:

>>> - generates spurious uart interrupt for every rx dma transaction
>>>   (ie., necessitates acking every UART interrupt, even UART_IIR_NO_INT)
>>>   _Even with this workaround_, it still generates spurious interrupt warning
>>>   which shuts off interrupts for several ms while logging the error
>>>   message to the console, virtually guaranteeing lost data.
>>
>> as I wrote in my other email I think RDI should be disabled with DMA
> 
> 
> I'll test to see if disabling RDI eliminates the UART_IIR_NO_INT spurious
> interrupts.
> 
>> according the Intel manual and I *think* someone here reported that
>> they see the same problem.
> 
> Let's confirm with the Intel folks that this is true, which would argue
> for using the omap-style rx dma flow.

Andy Shevchenko pointed this out here: https://lkml.org/lkml/2016/2/23/588

Regards,
Sekhar
