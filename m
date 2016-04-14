From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: 8250 dma issues ( was Re: [PATCH] tty: serial: 8250_omap: do not
 defer termios changes)
Date: Thu, 14 Apr 2016 10:54:40 -0700
Message-ID: <570FD960.707@hurleysoftware.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
 <570C04C1.40201@hurleysoftware.com> <570D2A46.2050106@linutronix.de>
 <570D82B6.2090506@hurleysoftware.com>
 <20160414160706.4c316d38@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160414160706.4c316d38@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/14/2016 08:07 AM, One Thousand Gnomes wrote:
>>>> 3. Handling XON/XOFF transmit is mandatory; I don't see a way to do that
>>>>    without pause/resume.  
>>>
>>> Yes, not doing XON/XOFF with DMA is not good. Using hardware flow
>>> control is one workaround but the user has no chance of knowing that
>>> XON/XOFF has been silently disabled.
> 
> You can clear the bits in the termios when the termios is set and the
> application *should* interpret that as not supported. I doubt many
> applications do for the XON/XOFF case. Equally you can just say that soft
> flow control turns off DMA or reduces buffering depending upon the data
> rate. We have plenty of hardware in the kernel that is more optimal in
> some configurations than others.
> 
> This also shouldn't be about whether 4K is a lot - it's about time to
> respond. Thus the _time_ latency of getting the ^S/^Q out is what matters
> at higher rates. At low speed (1200-9600 etc) you want to be able to
> respond within a few characters because the chances are the device the
> other end is not very bright.

Currently, tcflow(TCIOFF/TCION) ignores the flow control modes and always
sends XON/XOFF, so disabling DMA based on flow control mode won't work.


>>> the transfer right away. Oh now I see the same thing in
>>> edma_completion_handler(). Okay but this affects now everyone that
>>> relies on low latency?  
>>
>> Well, the real problem is that only one rx buffer is being used serially,
>> first filled by the dma h/w, then emptied by the driver, then resubmitted.
>> This creates a gap of time between the dma h/w completion interrupt and
>> the resubmission where data loss is possible (and happens).
> 
> Most low latency users are concerned about the latency between transmit
> and receive.

Sebastian really confused this problem by relating it to low latency.
That's not the problem.

The problem is that softirqs and tasklets are not reliable bottom halves
anymore, because since 3.8 they don't always run when interrupts are
re-enabled. They can now be deferred to the lowest priority process,
ksoftirqd.

For a uart trying not to overrun a 64-byte fifo at 3Mbaud creates a hard
213us deadline for the uart driver to give the dmaengine driver the
_next_ RX buffer to fill. Right now, the 8250 driver is only using 1
RX buffer, so until the DMA completion handler runs (in tasklet), the
8250 driver doesn't supply the dmaengine driver a new one.



> The usual case is windowless protocols like firmware
> downloaders. For higher speed that tends to be driven by the DMA
> timeouts, for lower baud rates you can perhaps mitigate this by using
> chains of very small buffers or just turning off DMA just as we turn off
> some of the FIFOs at very low speed ?
> 
>> But that's why I'd like to bring the two implementations closer, so that
>> maybe both can be replaced with a single rx dma transaction flow.
>> [ And perhaps extending tty buffer to perform direct fill, skipping the
>>   buffer copy ]
> 
> For the general case what IMHO is needed is probably not a direct fill of
> the tty buffer (which is surprisingly locking hard - we used to have one
> but it was broken) but rather a fastpath around it. With the specific
> exception of N_TTY I think every single other line discipline we have is
> capable of accepting a pointer and length to a block of data that ceases
> to be valid the moment the function returns. All the networking ones
> certainly are and it would speed up the usual culprits (3G modems over
> USB, bluetooth over onboard 3.3v uart etc). 
> 
> So a way to call
> 
> 	port->fast_rx(data, flags, len);
> 
> with a rule that you never mix fast and tty buffers, and with an atomic
> swap of port->fast_rx between tty_buffer queueing logic, discard and
> ldisc->fast_rx pointers done when the ldisc is set or changes.

Yes, that's one possible alternative. The drawback is that makes
testing more difficult, but maybe the tradeoff would be worth it.

Regards,
Peter Hurley


> There are very few cases where n_tty is the one that needs the optimized
> path: uucp died a long time ago 8)
> 
> Alan
> 
