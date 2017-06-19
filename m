From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: 8250_omap: Fix race b/w dma completion and
 RX timeout
Date: Mon, 19 Jun 2017 10:42:41 +0530
Message-ID: <f3905c42-74e2-5897-43f3-a0ffe2991c73@ti.com>
References: <20170617135224.31675-1-vigneshr@ti.com>
 <1497710243.22624.150.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497710243.22624.150.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org



On Saturday 17 June 2017 08:07 PM, Andy Shevchenko wrote:
> On Sat, 2017-06-17 at 19:22 +0530, Vignesh R wrote:
>> DMA RX completion handler for UART is called from a tasklet and hence
>> may be delayed depending on the system load. In meanwhile, there may
>> be
>> RX timeout interrupt which can get serviced first before DMA RX
>> completion handler is executed for the completed transfer.
>> omap_8250_rx_dma_flush() which is called on RX timeout interrupt makes
>> sure that the DMA RX buffer is pushed and then the FIFO is drained and
>> also queues a new DMA request. But, when DMA RX completion handler
>> executes, it will erroneously flush the currently queued DMA transfer
>> which sometimes results in data corruption and double queueing of DMA
>> RX
>> requests.
>>
>> Fix this by checking whether RX completion is for the currently queued
>> transfer or not. And also hold port lock when in DMA completion to
>> avoid
>> race wrt RX timeout handler preempting it.
> 
> 
>>  static void __dma_rx_complete(void *param)
>>  {
>> -	__dma_rx_do_complete(param);
>> -	omap_8250_rx_dma(param);
>> +	struct uart_8250_port *p = param;
>> +	struct uart_8250_dma *dma = p->dma;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&p->port.lock, flags);
>> +
>> +	/*
>> +	 * If the completion is for the current cookie then handle
>> it,
>> +	 * else a previous RX timeout flush would have already pushed
>> +	 * data from DMA buffers, so exit.
>> +	 */
> 
>> +	if (dma->rx_cookie != dma->rxchan->completed_cookie) {
> 
> Wouldn't be better to call DMAEngine API for that?
> dmaengine_tx_status() I suppose

Yeah, will update the patch. Thanks!



-- 
Regards
Vignesh
