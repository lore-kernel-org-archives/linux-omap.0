From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Mon, 11 Apr 2016 20:31:23 +0200
Message-ID: <570BED7B.9080803@linutronix.de>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
 <570BE48F.60801@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <570BE48F.60801@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 07:53 PM, Peter Hurley wrote:
> On 04/11/2016 01:18 AM, John Ogness wrote:
>> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 03/31/2016 01:41 AM, John Ogness wrote:
>>>> It has been observed that the TX-DMA can stall
>>>
>>> Does this happen on any other OMAP part besides am335x?
>>> I looked back over the LKML history of this and didn't see
>>> any other design implicated in this problem.
>>
>> I just ran the tests again using 4.6-rc2. I am able to reproduce the
>> dma-tx stall with am335x/edma and dra7/sdma.
> 
> I thought we already established sdma was not to be used since
> the hardware does not actually support pausing without data loss.

This workaround was not invented for sdma but for edma (with am335x).

> http://www.spinics.net/lists/linux-serial/msg18503.html

This could be fixed. See
  http://www.spinics.net/lists/linux-serial/msg18517.html
  http://www.spinics.net/lists/linux-serial/msg18531.html

rmk was fine with it from what I read. So what is missing is just
refurbish the patch (update the comment according to rmk replay) and
then we could re-enable DMA again.

> So I'm wondering if we're carrying all this extra DMA complexity
> and workarounds for just am335x?
> 

Sebastian
