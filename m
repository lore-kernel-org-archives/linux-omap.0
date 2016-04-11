From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Mon, 11 Apr 2016 10:53:19 -0700
Message-ID: <570BE48F.60801@hurleysoftware.com>
References: <8737r7ght7.fsf@linutronix.de>
 <570339E8.6010808@hurleysoftware.com> <87y48kftip.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y48kftip.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/2016 01:18 AM, John Ogness wrote:
> On 2016-04-05, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 03/31/2016 01:41 AM, John Ogness wrote:
>>> It has been observed that the TX-DMA can stall
>>
>> Does this happen on any other OMAP part besides am335x?
>> I looked back over the LKML history of this and didn't see
>> any other design implicated in this problem.
> 
> I just ran the tests again using 4.6-rc2. I am able to reproduce the
> dma-tx stall with am335x/edma and dra7/sdma.

I thought we already established sdma was not to be used since
the hardware does not actually support pausing without data loss.

http://www.spinics.net/lists/linux-serial/msg18503.html


So I'm wondering if we're carrying all this extra DMA complexity
and workarounds for just am335x?


> Note: To achieve the stall, both the delayed_restore and the
>       rx_dma_broken features of the mainline 8250_omap driver needed to
>       be removed.
> 
> John Ogness
> 
