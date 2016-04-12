From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Tue, 12 Apr 2016 19:03:02 +0200
Message-ID: <570D2A46.2050106@linutronix.de>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com> <570BED7B.9080803@linutronix.de>
 <570C04C1.40201@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570C04C1.40201@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 10:10 PM, Peter Hurley wrote:
> On 04/11/2016 11:31 AM, Sebastian Andrzej Siewior wrote:
>> On 04/11/2016 07:53 PM, Peter Hurley wrote:
>>> On 04/11/2016 01:18 AM, John Ogness wrote:
>>>> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> On 03/31/2016 01:41 AM, John Ogness wrote:
>>>>>> It has been observed that the TX-DMA can stall
>>>>>
>>>>> Does this happen on any other OMAP part besides am335x?
>>>>> I looked back over the LKML history of this and didn't see
>>>>> any other design implicated in this problem.
>>>>
>>>> I just ran the tests again using 4.6-rc2. I am able to reproduce the
>>>> dma-tx stall with am335x/edma and dra7/sdma.
>>>
>>> I thought we already established sdma was not to be used since
>>> the hardware does not actually support pausing without data loss.
>>
>> This workaround was not invented for sdma but for edma (with am335x).
> 
> According to John above, dra7/sdma requires this workaround.

It was reported by Frans Klaver against am335x
 http://lkml.kernel.org/r/20140908183353.GB4686@ci00147.xsens-tech.local

and I managed to reproduce this with his yocto image on dra7 and am335x:
 http://lkml.kernel.org/r/20140921204100.GA10111@linutronix.de

>>> http://www.spinics.net/lists/linux-serial/msg18503.html
>>
>> This could be fixed. See
>>   http://www.spinics.net/lists/linux-serial/msg18517.html
>>   http://www.spinics.net/lists/linux-serial/msg18531.html
>>
>> rmk was fine with it from what I read. So what is missing is just
>> refurbish the patch (update the comment according to rmk replay) and
>> then we could re-enable DMA again.
> 
> That's hardly all that is required.

well it would enable pause of RX transfers. TX would not work (unless
TI's HW people can confirm that it will).

> 1. edma pause returns an error if the descriptor has already been retired
>    when a pause is attempted. This makes distinguishing between reporting an
>    error for unsupported feature indistinguishable from a transient dma
>    error that can simply be logged.
> 2. The question of a spurious uart interrupt with every dma transaction
>    on am335x is still unanswered.

This is correct. If I remember correctly, the Intel people see the same
thing and I *think* John told me that the Intel manual says that RDI
should be disabled if DMA is used.

> 3. Handling XON/XOFF transmit is mandatory; I don't see a way to do that
>    without pause/resume.
Yes, not doing XON/XOFF with DMA is not good. Using hardware flow
control is one workaround but the user has no chance of knowing that
XON/XOFF has been silently disabled.

You could send the x_char after TX transfer completed. After all you
need to ensure that you have some space in the TX-FIFO. However if you
send a 4KiB of data you might want to send x_char rather sooner than
later. I *think* even with pause the hardware will complete the last
burst before stopping but is probably better than waiting for the 4KiB
to complete.

> 4. Since virt-dma uses tasklets which since 3.8 are no longer serviced
>    in a timely manner, rx dma is unreliable, since it's often kicked out
>    to regular interrupts.

Is this only the delay in omap_dma_callback() (which you don't have
!cyclic) or something else? omap_dma_issue_pending() seems to program
the transfer right away. Oh now I see the same thing in
edma_completion_handler(). Okay but this affects now everyone that
relies on low latency?

> 5. omap dma maintenance is not keeping up with baseline dma.

John switched to cylic mode so he was not effected very much non-pause
problem.

> IOW, omap dma has turned into one big tangle of workarounds.
Most of them are hardware shortcomings. I think disabling RX-DMA due to
missing pause in omap-dma is the only workaround that could be avoided
if the driver would be changed.

> Let's start with making a list of which TI designs need which workarounds.
> 
> *am335x*

I am not sure if the limitations are based on the DMA engine or the

> - requires write to tx fifo to trigger tx dma (ie. OMAP_DMA_TX_KICK
>   workaround necessitating completely different tx dma completion handler)

This one for instance I don't see on BeagleBoard xM / omap36xx and
DRA7x. Both (not affected) use SDMA instead EDMA. It would be
interesting to see if DRA7x is affected once it uses EDMA.

> - requires rx dma already queued before UART data ready interrupt
>   (ie., necessitates completely different irq handler and rx dma completion
>   handler)

true. But is this something that would work for others, too?

> - hangs changing some unknown register if tx dma in progress
>   (ie., this termios change workaround)

I think some registers are the baud-rate registers which pause engine.

> - generates spurious uart interrupt for every rx dma transaction
>   (ie., necessitates acking every UART interrupt, even UART_IIR_NO_INT)
>   _Even with this workaround_, it still generates spurious interrupt warning
>   which shuts off interrupts for several ms while logging the error
>   message to the console, virtually guaranteeing lost data.

as I wrote in my other email I think RDI should be disabled with DMA
according the Intel manual and I *think* someone here reported that
they see the same problem.

> Can any TI design use the baseline 8250 tx dma transaction flow without
> workarounds?  I know the am335x can't; any others?
Am335x. Has edma and so has dm814x. According to the code, dm814x based
HW does not need it, can this be confirmed? Sekhar, TOny?

> Can any TI design use the baseline 8250 rx dma transaction flow without
> workarounds?  Again, I know the am335x can't; any others?

Is dra7 out? Because that one needs to enqueue RX transfers asap. And
omap36xx (aka BeagleBoard-xm) as well. I don't kown anything about
later SoCs (like am437x and so on) but I would assume so.

Sebastian
