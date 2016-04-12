From: Peter Hurley <peter@hurleysoftware.com>
Subject: 8250 dma issues ( was Re: [PATCH] tty: serial: 8250_omap: do not
 defer termios changes)
Date: Tue, 12 Apr 2016 16:20:22 -0700
Message-ID: <570D82B6.2090506@hurleysoftware.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
 <570C04C1.40201@hurleysoftware.com> <570D2A46.2050106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570D2A46.2050106@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[ +to Heikki, Andy ]

On 04/12/2016 10:03 AM, Sebastian Andrzej Siewior wrote:
> On 04/11/2016 10:10 PM, Peter Hurley wrote:
>> On 04/11/2016 11:31 AM, Sebastian Andrzej Siewior wrote:
>>> On 04/11/2016 07:53 PM, Peter Hurley wrote:

[ elided parts not relevant to shared 8250 dma discussion ]

>> 2. The question of a spurious uart interrupt with every dma transaction
>>    on am335x is still unanswered.
> 
> This is correct. If I remember correctly, the Intel people see the same
> thing and I *think* John told me that the Intel manual says that RDI
> should be disabled if DMA is used.

Not sure we're talking about the same thing here?

I mean the 100000 UART_IIR_NO_INTs that trigger irq disable, for which
John submitted a patch to ack these. I've never seen any discussion
regarding this problem on intel platforms.

An *extra* 6000+ interrupts/sec. for no purpose is bad.


>> 3. Handling XON/XOFF transmit is mandatory; I don't see a way to do that
>>    without pause/resume.
>
> Yes, not doing XON/XOFF with DMA is not good. Using hardware flow
> control is one workaround but the user has no chance of knowing that
> XON/XOFF has been silently disabled.
> 
> You could send the x_char after TX transfer completed. After all you
> need to ensure that you have some space in the TX-FIFO. However if you
> send a 4KiB of data you might want to send x_char rather sooner than
> later. I *think* even with pause the hardware will complete the last
> burst before stopping but is probably better than waiting for the 4KiB
> to complete.

Yeah, it doesn't need to be the very next byte but a better effort should
be made. 4k is lot of scroll-by.


>> 4. Since virt-dma uses tasklets which since 3.8 are no longer serviced
>>    in a timely manner, rx dma is unreliable, since it's often kicked out
>>    to regular interrupts.
> 
> Is this only the delay in omap_dma_callback() (which you don't have
> !cyclic) or something else? omap_dma_issue_pending() seems to program
> the transfer right away. Oh now I see the same thing in
> edma_completion_handler(). Okay but this affects now everyone that
> relies on low latency?

Well, the real problem is that only one rx buffer is being used serially,
first filled by the dma h/w, then emptied by the driver, then resubmitted.
This creates a gap of time between the dma h/w completion interrupt and
the resubmission where data loss is possible (and happens).

In the omap8250 rx dma flow:

1. Submit 1st rx dma transaction
2. h/w finishes 1st rx dma transaction
3. * schedule completion handler * which may be delayed significant
   amount of time ( > 1ms )
4. data still arriving at uart
5. completion handler eventually runs but too late, so the
   2nd rx dma transaction is not submitted in time to prevent data
   loss.

This rx dma flow creates a hard deadline starting at step 3 and ending at
step 5 above that Linux won't meet.

The normal 8250 dma flow has a similar gap but it seems to be less
frequent, probably because of the disparity in rx buffer size
(4k vs. 48 bytes)

In the 8250 rx dma flow:

1. Receive rx interrupt, submit 1st rx dma transaction
2. h/w finishes 1st rx dma transaction
3. * schedule completion handler * which may be delayed significant
   amount of time ( > 1ms )
4. data still arriving at uart, more rx interrupts received but
   rx_running == T so no add'l transaction scheduled
5. completion handler eventually runs but too late, so the
   2nd rx dma transaction is not submitted in time to prevent data
   loss.

Instead, both platforms should use a ping-pong scheme (or more generally
a ring of buffers): initially submit multiple rx buffers which allows
the dmaengine driver to start immediately on next buffer instead of
waiting for resubmission. Not sure if this will work though, haven't
really experimented with it at all yet.

But that's why I'd like to bring the two implementations closer, so that
maybe both can be replaced with a single rx dma transaction flow.
[ And perhaps extending tty buffer to perform direct fill, skipping the
  buffer copy ]



>> 5. omap dma maintenance is not keeping up with baseline dma.
> 
> John switched to cylic mode so he was not effected very much non-pause
> problem.

But the issue here is mainline, so it's still a problem.
[ FWIW, my main issue with John's approach was the excessive buffering. ]


[ On omap workarounds: ]
>> - requires rx dma already queued before UART data ready interrupt
>>   (ie., necessitates completely different irq handler and rx dma completion
>>   handler)
> 
> true. But is this something that would work for others, too?

Good point, I don't see why not.
Let's find out what the Intel guys think?
