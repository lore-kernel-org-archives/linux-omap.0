From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Mon, 11 Apr 2016 13:10:41 -0700
Message-ID: <570C04C1.40201@hurleysoftware.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570BED7B.9080803@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 11:31 AM, Sebastian Andrzej Siewior wrote:
> On 04/11/2016 07:53 PM, Peter Hurley wrote:
>> On 04/11/2016 01:18 AM, John Ogness wrote:
>>> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> On 03/31/2016 01:41 AM, John Ogness wrote:
>>>>> It has been observed that the TX-DMA can stall
>>>>
>>>> Does this happen on any other OMAP part besides am335x?
>>>> I looked back over the LKML history of this and didn't see
>>>> any other design implicated in this problem.
>>>
>>> I just ran the tests again using 4.6-rc2. I am able to reproduce the
>>> dma-tx stall with am335x/edma and dra7/sdma.
>>
>> I thought we already established sdma was not to be used since
>> the hardware does not actually support pausing without data loss.
> 
> This workaround was not invented for sdma but for edma (with am335x).

According to John above, dra7/sdma requires this workaround.


>> http://www.spinics.net/lists/linux-serial/msg18503.html
> 
> This could be fixed. See
>   http://www.spinics.net/lists/linux-serial/msg18517.html
>   http://www.spinics.net/lists/linux-serial/msg18531.html
> 
> rmk was fine with it from what I read. So what is missing is just
> refurbish the patch (update the comment according to rmk replay) and
> then we could re-enable DMA again.

That's hardly all that is required.

1. edma pause returns an error if the descriptor has already been retired
   when a pause is attempted. This makes distinguishing between reporting an
   error for unsupported feature indistinguishable from a transient dma
   error that can simply be logged.
2. The question of a spurious uart interrupt with every dma transaction
   on am335x is still unanswered.
3. Handling XON/XOFF transmit is mandatory; I don't see a way to do that
   without pause/resume.
4. Since virt-dma uses tasklets which since 3.8 are no longer serviced
   in a timely manner, rx dma is unreliable, since it's often kicked out
   to regular interrupts.
5. omap dma maintenance is not keeping up with baseline dma.


IOW, omap dma has turned into one big tangle of workarounds.

Let's start with making a list of which TI designs need which workarounds.

*am335x*
- requires write to tx fifo to trigger tx dma (ie. OMAP_DMA_TX_KICK
  workaround necessitating completely different tx dma completion handler)
- requires rx dma already queued before UART data ready interrupt
  (ie., necessitates completely different irq handler and rx dma completion
  handler)
- hangs changing some unknown register if tx dma in progress
  (ie., this termios change workaround)
- generates spurious uart interrupt for every rx dma transaction
  (ie., necessitates acking every UART interrupt, even UART_IIR_NO_INT)
  _Even with this workaround_, it still generates spurious interrupt warning
  which shuts off interrupts for several ms while logging the error
  message to the console, virtually guaranteeing lost data.


Can any TI design use the baseline 8250 tx dma transaction flow without
workarounds?  I know the am335x can't; any others?
Can any TI design use the baseline 8250 rx dma transaction flow without
workarounds?  Again, I know the am335x can't; any others?



>> So I'm wondering if we're carrying all this extra DMA complexity
>> and workarounds for just am335x?
>>
> 
> Sebastian
> 
