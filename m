From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Wed, 10 Sep 2014 18:56:37 +0200
Message-ID: <541082C5.7040608@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de> <20140908144616.GA22315@ci00147.xsens-tech.local> <20140908151501.GA22584@linutronix.de> <20140908183353.GB4686@ci00147.xsens-tech.local> <540F57E0.8030404@linutronix.de> <20140910141554.GC22315@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140910141554.GC22315@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/10/2014 04:15 PM, Frans Klaver wrote:
> On Tue, Sep 09, 2014 at 09:41:20PM +0200, Sebastian Andrzej Siewior wrote:
>> On 09/08/2014 08:33 PM, Frans Klaver wrote:
>>> Thanks. I'll give it a spin on Wednesday.
>>
>> Could you please pull the upcoming v9 first?
>>
>>  git://git.breakpoint.cc/bigeasy/linux.git uart_v9_pre1
>>
>> This solves a few of my am335x related issues.
> 
> Using v9_pre1, I get a kernel panic in edma_dma_pause() on echan->edesc
> being NULL. I do get data before this happens. This is at high speed,
> high rate. No mention of the irq having too much to do, though. The more
> data I transmit, the more likely this is to occur.

Hmm. This shouldn't happen because if dma->rx_running is set, then
there should be a descriptor to pause.
Could check how this could happen? (and which event tries to do so)

In the meantime, the lower part of [0] should fix the NULL bug.

[0] https://lkml.org/lkml/2014/7/29/506

> I don't currently have the setup to lower the baudrate. I would probably
> need to reproduce this on a beaglebone, instead of our custom board.
> I'll see if I can do that.
> 
> If you need more info, just let me know.

I just pushed uart_v9_pre2 and I will post it once I rebased it on top
Greg's latest.
There was a bug where THRE could be active longer than needed caused a
few not needed interrupts until the FIFO was empty again.

My "less on file" test case did not fail anymore with this.

> Thanks,
> Frans

Sebastian
