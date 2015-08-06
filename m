From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Thu, 06 Aug 2015 08:27:20 -0400
Message-ID: <55C352A8.3070102@hurleysoftware.com>
References: <87egjp2r4a.fsf@linutronix.de> <55BAC67E.1010400@hurleysoftware.com> <20150803160937.GA26497@linutronix.de> <55BF980E.20908@hurleysoftware.com> <55BF9CE0.4080107@linutronix.de> <55BFC1BA.5020605@hurleysoftware.com> <55C0A8F4.4010204@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C0A8F4.4010204@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On 08/04/2015 07:58 AM, Sebastian Andrzej Siewior wrote:
> On 08/03/2015 09:32 PM, Peter Hurley wrote:
> 
>>> You mean a function in 8250-dma API which does what I did just here
>>> with the wait_event() and the wake_up in the callback? That way I could
>>> move the termios_wait into the dma struct instead of keeping in the
>>> omap specific part. I am also not sure if OMAP is the only one that may
>>> hang here or the other people just didn't notice it yet.
>>
>> Exactly; and we need to fix DMA wrt x_char anyway.
>>
>> Going back to the dmaengine api, I think something like this might work
>> (as a first approximation):
>>
>> 	dma_sync_wait(dma->txchan, dma->tx_cookie);
>> 	dmaengine_pause(dma->txchan);
>>
>> 	/* remainder of set_termios */
>>
>> 	dmaengine_resume(dma->txchan);
>>
>> We could require 8250 core dma to support pause/resume.
> 
> I would prefer the waitqueue approach.
> You can't do this while holding the port lock. The lock is taken with
> irqs off so may not see the transfer completing.
> Why do you pause the channel? It may not work without an active
> descriptor and a start without "resume" should work. Also you must
> ensure that DMA's complete callback does not start another transfer if
> there is something queued up (that is why I had the tx_running dance).
> I am not sure if a transfer that is active and then paused will not
> trigger the hang bug if we change the termios in between.

I'll look at/test this this weekend, ok?

Regards,
Peter Hurley
