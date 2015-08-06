From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Thu, 06 Aug 2015 15:59:34 +0200
Message-ID: <55C36846.8010104@linutronix.de>
References: <87egjp2r4a.fsf@linutronix.de> <55BAC67E.1010400@hurleysoftware.com> <20150803160937.GA26497@linutronix.de> <55BF980E.20908@hurleysoftware.com> <55BF9CE0.4080107@linutronix.de> <55BFC1BA.5020605@hurleysoftware.com> <55C0A8F4.4010204@linutronix.de> <55C352A8.3070102@hurleysoftware.com> <55C3539F.4070403@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C3539F.4070403@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 08/06/2015 02:31 PM, Sebastian Andrzej Siewior wrote:

Hi Peter,

>> I'll look at/test this this weekend, ok?
> 
> Sure. I'm currently re-spinning the patches so have everything in
> proper pieces. While at it I will take a look at x_char.

So now that I actually look at it. If I read this right, we never send
the x_char if the TX-DMA never fails to do its job. The comment above
uart_send_xchar() says it is high priority. What do you suggest, wait
until the transfer completes, send the x_char _or_ pause the transfer
send that byte and then send the byte?
In both cases we have to wait until for the FIFO-empty interrupt to
make sure we don't overrun that TX-FIFO.

I *think* waiting until the transfer completes would be simpler but it
is not necessarily high priority.

>> Regards,
>> Peter Hurley

Sebastian
