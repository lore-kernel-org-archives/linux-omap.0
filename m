From: Peter Hurley <peter@hurleysoftware.com>
Subject: omap uart + dma issues (Re: [PATCH] tty: serial: 8250_omap: do not
 defer termios changes)
Date: Tue, 12 Apr 2016 17:00:22 -0700
Message-ID: <570D8C16.1010702@hurleysoftware.com>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/12/2016 10:03 AM, Sebastian Andrzej Siewior wrote:
> On 04/11/2016 10:10 PM, Peter Hurley wrote:
>> On 04/11/2016 11:31 AM, Sebastian Andrzej Siewior wrote:
>>> On 04/11/2016 07:53 PM, Peter Hurley wrote:
>>>> On 04/11/2016 01:18 AM, John Ogness wrote:
>>>>> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>>> On 03/31/2016 01:41 AM, John Ogness wrote:
>>>>>>> It has been observed that the TX-DMA can stall

[...]

>>>> http://www.spinics.net/lists/linux-serial/msg18503.html
>>>
>>> This could be fixed. See
>>>   http://www.spinics.net/lists/linux-serial/msg18517.html
>>>   http://www.spinics.net/lists/linux-serial/msg18531.html
>>>
>>> rmk was fine with it from what I read. So what is missing is just
>>> refurbish the patch (update the comment according to rmk replay) and
>>> then we could re-enable DMA again.
>>
>> That's hardly all that is required.
> 
> well it would enable pause of RX transfers.

I'm not totally convinced of that.

Does a RX timeout ensure that sdma won't try to complete the transaction
if more rx data arrives between the raising of the rx timeout interrupt
and the pausing of rx transaction?

My guess is not, which will result in lost data in normal operation.


> TX would not work (unless TI's HW people can confirm that it will).
> 
>> 1. edma pause returns an error if the descriptor has already been retired
>>    when a pause is attempted. This makes distinguishing between reporting an
>>    error for unsupported feature indistinguishable from a transient dma
>>    error that can simply be logged.

Also, this error is reported during normal operation, which is bogus.
The h/w descriptor has completed but the completion handler has not yet been
called, so the "error" is expected.

Which, laughably, is the same error code (-EINVAL) omap-dma uses to "creatively"
report it doesn't actually support pause/resume, despite what dma_get_slave_caps()
reports.

[ split spurious uart interrupts, XON/XOFF transmit, rx dma flow, and code
  code maintenance to separate email discussion ]


>> IOW, omap dma has turned into one big tangle of workarounds.
>
> Most of them are hardware shortcomings.

Totally agree. But at some point, working around h/w becomes prohibitive;
maybe not for a vendor tree, but for mainline, yes.


> I think disabling RX-DMA due to missing pause in omap-dma is the only
> workaround that could be avoided if the driver would be changed.
> 
>> Let's start with making a list of which TI designs need which workarounds.
>>
>> *am335x*
> 
> I am not sure if the limitations are based on the DMA engine or the
> 
>> - requires write to tx fifo to trigger tx dma (ie. OMAP_DMA_TX_KICK
>>   workaround necessitating completely different tx dma completion handler)
> 
> This one for instance I don't see on BeagleBoard xM / omap36xx and
> DRA7x. Both (not affected) use SDMA instead EDMA.

Ok.
A goal here would be to use serial8250_tx_dma() for these designs
(the delayed restore workaround makes that not possible right now though).

> It would be interesting to see if DRA7x is affected once it uses EDMA.

Agree; because if this problem is limited to the am335x then maybe
tx dma isn't worth doing for that design.


[ cut to "8250 dma issues" ]

[ cut to my 1st reply      ]


>> - generates spurious uart interrupt for every rx dma transaction
>>   (ie., necessitates acking every UART interrupt, even UART_IIR_NO_INT)
>>   _Even with this workaround_, it still generates spurious interrupt warning
>>   which shuts off interrupts for several ms while logging the error
>>   message to the console, virtually guaranteeing lost data.
> 
> as I wrote in my other email I think RDI should be disabled with DMA


I'll test to see if disabling RDI eliminates the UART_IIR_NO_INT spurious
interrupts.

> according the Intel manual and I *think* someone here reported that
> they see the same problem.

Let's confirm with the Intel folks that this is true, which would argue
for using the omap-style rx dma flow.



>> Can any TI design use the baseline 8250 tx dma transaction flow without
>> workarounds?  I know the am335x can't; any others?
>
> Am335x. Has edma and so has dm814x. According to the code, dm814x based
> HW does not need it, can this be confirmed? Sekhar, TOny?

Slight misunderstanding; what I mean is what TI designs can actually use
serial8250_tx_dma()?

Right now, it seems both am335x and dra7 require omap_8250_tx_dma
(for the delayed_restore workaround and the direct write to tx fifo to
kick tx dma).

[ Assume that the UART_CAP_RPM functionality is added to serial8250_tx_dma() ]



>> Can any TI design use the baseline 8250 rx dma transaction flow without
>> workarounds?  Again, I know the am335x can't; any others?
> 
> Is dra7 out? Because that one needs to enqueue RX transfers asap. And
> omap36xx (aka BeagleBoard-xm) as well. I don't kown anything about
> later SoCs (like am437x and so on) but I would assume so.

Same misunderstanding but I get what you're saying; to your knowledge
all the TI designs require the omap-style rx dma transaction flow
(ie., submit transaction before data is received, and resubmit with each
completed transaction).

One thing that I wonder about then is the initial condition when
the port is first opened; what if data is being received then?
