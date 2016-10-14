From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH RESEND v3] dma: omap-dma: add support for pause of
 non-cyclic transfers
Date: Fri, 14 Oct 2016 10:31:59 +0530
Message-ID: <611e51ba-f484-0545-35e0-6f8e3885cf50@ti.com>
References: <20161010120755.26153-1-vigneshr@ti.com>
 <46582bda-321f-47a6-d7d5-a27cbdd7f363@ti.com>
 <d1eb15e4-7d8f-e2c0-0e27-580d3e41ac4e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d1eb15e4-7d8f-e2c0-0e27-580d3e41ac4e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org



On Thursday 13 October 2016 03:37 PM, Peter Ujfalusi wrote:
> On 10/10/16 17:12, Peter Ujfalusi wrote:
>> On 10/10/16 15:07, Vignesh R wrote:
>>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>
>>> This DMA driver is used by 8250-omap on DRA7-evm. There is one
>>> requirement that is to pause a transfer. This is currently used on the RX
>>> side. It is possible that the UART HW aborted the RX (UART's RX-timeout)
>>> but the DMA controller starts the transfer shortly after.
>>> Before we can manually purge the FIFO we need to pause the transfer,
>>> check how many bytes it already received and terminate the transfer
>>> without it making any progress.
>>>
>>> From testing on the TX side it seems that it is possible that we invoke
>>> pause once the transfer has completed which is indicated by the missing
>>> CCR_ENABLE bit but before the interrupt has been noticed. In that case the
>>> interrupt will come even after disabling it.
>>>
>>> The AM572x manual says that we have to wait for the CCR_RD_ACTIVE &
>>> CCR_WR_ACTIVE bits to be gone before programming it again here is the
>>> drain loop. Also it looks like without the drain the TX-transfer makes
>>> sometimes progress.
>>>
>>> One note: The pause + resume combo is broken because after resume the
>>> the complete transfer will be programmed again. That means the already
>>> transferred bytes (until the pause event) will be sent again. This is
>>> currently not important for my UART user because it does only pause +
>>> terminate.
>>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Can you resend the patch with corrected subject line?
> dmaengine: omap-dma: ....
> 

Sent v4 in reply to the patch fixing up the subject. Thanks!

-- 
Regards
Vignesh
