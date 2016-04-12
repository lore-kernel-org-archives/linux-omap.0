From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Tue, 12 Apr 2016 11:42:48 -0700
Message-ID: <570D41A8.3050706@hurleysoftware.com>
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
>>>>>>
>>>>>> Does this happen on any other OMAP part besides am335x?
>>>>>> I looked back over the LKML history of this and didn't see
>>>>>> any other design implicated in this problem.
>>>>>
>>>>> I just ran the tests again using 4.6-rc2. I am able to reproduce the
>>>>> dma-tx stall with am335x/edma and dra7/sdma.
>>>>
>>>> I thought we already established sdma was not to be used since
>>>> the hardware does not actually support pausing without data loss.
>>>
>>> This workaround was not invented for sdma but for edma (with am335x).
>>
>> According to John above, dra7/sdma requires this workaround.
> 
> It was reported by Frans Klaver against am335x
>  http://lkml.kernel.org/r/20140908183353.GB4686@ci00147.xsens-tech.local
> 
> and I managed to reproduce this with his yocto image on dra7 and am335x:
>  http://lkml.kernel.org/r/20140921204100.GA10111@linutronix.de

[...]

>> - hangs changing some unknown register if tx dma in progress
>>   (ie., this termios change workaround)
> 
> I think some registers are the baud-rate registers which pause engine.

Let's back up here and focus on just this problem for now.

Since this is observable on dra7/sdma, then it's not related to
the OMAP_DMA_TX_KICK problem. IOW, dropping tx dma support for am335x
does not make this go away, which is what I was asking.

Now, if the DLL/DLH/MDR1 register writes are causing dma to stall,
then skipping those if they're unchanged should fix this, and then
pause/terminating in-progress DMA if any of these registers are being
written would be acceptable since some data loss is to be expected
when changing the baud rate without waiting.
