From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 14:35:45 +0200
Message-ID: <55C4A621.4050102@linutronix.de>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <20150807105546.GL7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807105546.GL7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 12:55 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 10:41:57AM +0200, Sebastian Andrzej Siewior wrote:
>> This DMA driver is used by 8250-omap on DRA7-evm. There is one
>> requirement that is to pause a transfer. This is currently used on the RX
>> side. It is possible that the UART HW aborted the RX (UART's RX-timeout)
>> but the DMA controller starts the transfer shortly after.
>> Before we can manually purge the FIFO we need to pause the transfer,
>> check how many bytes it already received and terminate the transfer
>> without it making any progress.
>>
>> >From testing on the TX side it seems that it is possible that we invoke
>> pause once the transfer has completed which is indicated by the missing
>> CCR_ENABLE bit but before the interrupt has been noticed. In that case the
>> interrupt will come even after disabling it.
> 
> How do you cope with the OMAP DMA hardware clearing its FIFO when you
> pause it?

I don't

> The problem is that on mem-to-device transfers, the DMA hardware can
> prefetch some data from memory into its FIFO before the device wants
> the data.  If you then disable the channel, the hardware clears the
> FIFO.
> 
> It is unspecified whether the hardware updates the source address in
> this case, or by how much.  So it's pretty hard to undo the prefetching
> in software.
> 
> The net result is: data loss.
> 
> This is why I explicitly did not implement pause/resume for non-cyclic
> channels.

Right now the 820-omap (8250-dma in general, too but they don't use
this driver) pause only the RX transfer in an error condition. This
means it is only device-to-mem transfer. I only mentioned the TX
transfer here since this was easier to test.

When I first tested the 8250_omap + DMA on EDMA it seemed that once the
UART hardware triggered an time-out interrupt the DMA transfer _never_
started. Based on this I could just cancel the transfer since the
RX-DMA and assume zero bytes were transfer. Therefore I ignored the
lack of pause support in EDMA.
Things were fine until someone used 3mbaud instead 115200. Its been
observed that at this speed the UART triggers the time-out interrupt
and the DMA transfer just started. Without the support for pause
we lost some bytes here and once pause support was added the problem
was gone. Now I've been chasing another bug on Dra7 which uses this
driver and the lack of pause support is a candidate for my current
problem. So at this point, things can't get worse if we pause a
transfer and the hardware reported the wrong number of received bytes.
The situation can improve if we get the correct number :)
The 8250_omap does not pause the TX/RX transfer for the fun of it. As I
said, on the TX side we avoid it and on the RX side the transfer is only
paused if we receive an error interrupt (= no way out).

Sebastian
