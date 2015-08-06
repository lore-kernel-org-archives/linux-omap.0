From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Thu, 06 Aug 2015 14:22:32 -0400
Message-ID: <55C3A5E8.4030506@hurleysoftware.com>
References: <87egjp2r4a.fsf@linutronix.de> <55BAC67E.1010400@hurleysoftware.com> <20150803160937.GA26497@linutronix.de> <55BF980E.20908@hurleysoftware.com> <55BF9CE0.4080107@linutronix.de> <55BFC1BA.5020605@hurleysoftware.com> <55C0A8F4.4010204@linutronix.de> <55C352A8.3070102@hurleysoftware.com> <55C3539F.4070403@linutronix.de> <55C36846.8010104@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C36846.8010104@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 08/06/2015 09:59 AM, Sebastian Andrzej Siewior wrote:
> On 08/06/2015 02:31 PM, Sebastian Andrzej Siewior wrote:
> 
> Hi Peter,
> 
>>> I'll look at/test this this weekend, ok?
>>
>> Sure. I'm currently re-spinning the patches so have everything in
>> proper pieces. While at it I will take a look at x_char.
> 
> So now that I actually look at it. If I read this right, we never send
> the x_char if the TX-DMA never fails to do its job.

That's what I saw too; almost all the dma drivers are broken wrt x_char.
The amba-pl011 driver gets it right.

> The comment above uart_send_xchar() says it is high priority.

'High' priority is meant relative to previously written data which has
not yet been sent.

> What do you suggest, wait
> until the transfer completes, send the x_char _or_ pause the transfer
> send that byte and then send the byte?

'Better' would be sending the x_char when the current dma transfer
completes. However, it will probably have /some/ impact on what line
rates software flow control can be used. Worst case @ 115Kbaud is 35ms
delay in sending.

'Best' would be pausing the dma and sending the byte. However, I'm not
even sure if this is possible on OMAP; the TRM is woefully under-documented
in that regard.

> In both cases we have to wait until for the FIFO-empty interrupt to
> make sure we don't overrun that TX-FIFO.
> 
> I *think* waiting until the transfer completes would be simpler but it
> is not necessarily high priority.

I agree; this is what we should do first because someone might want it
for backports.

Regards,
Peter Hurley
