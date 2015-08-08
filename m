From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Sat, 08 Aug 2015 11:32:05 +0200
Message-ID: <55C5CC95.6030901@linutronix.de>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de> <1438977619-15488-2-git-send-email-bigeasy@linutronix.de> <55C54D49.3090406@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C54D49.3090406@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/08/2015 02:28 AM, Peter Hurley wrote:
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index 0340ee6ba970..07a11e0935e4 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -769,7 +771,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
>>  		return;
>>  	}
>>  
>> -	dmaengine_pause(dma->rxchan);
>> +	ret = dmaengine_pause(dma->rxchan);
>> +	if (WARN_ON_ONCE(ret))
>> +		priv->rx_dma_broken = true;
> 
> No offense, Sebastian, but it boggles my mind that anyone could defend this
> as solid api design. We're in the middle of an interrupt handler and the
> slave dma driver is /just/ telling us now that it doesn't implement this
> functionality?!!?

This is the best thing I could come up with. But to be fair: This
happens once _very_ early in the process and is 100% reproducible. The
WARN_ON should trigger user attention.

> The dmaengine api has _so much_ setup and none of it contemplates telling the
> consumer that critical functionality is missing?

Lets say it is a missing feature which was not noticed / required until
now. I have the missing functionality in patch #3. I don't see the
point in adding a lookup API for this feature which has to be
backported stable just to figure out that RX-DMA might not work.
Again: the WARN_ON triggers on the first short RX read _or_ on shutdown
of the port which is not after hours using the port.

> Even dma_get_slave_caps() returns _true_ for cmd_pause support; ok, that
> interface is pointless.
> 
> Rather than losing /critical data/ here, the interrupt handler should just
> busy-wait until dmaengine_tx_status() returns DMA_COMPLETE for the rx_cookie.

This might not happen at all. At 115200 I *never* encouraged this. Once
the FIFO is filled with less than RX-trigger size than the UART sends
the time-out interrupt and the DMA *never* completes. Even if the FIFO
reaches trigger size later. So you have to abort the DMA transfer and
read data manually from the FIFO. That is why the omap enqueues the
RX-transfer upfront (while the FIFO is still empty).

It happens *sometimes* that the UART sends a timeout interrupt and the
DMA transfer just is started and it has been only observed at 3mbaud
(but there were no tests 115200 > x > 3mbaud that I know of).

Therefor I think this is a fair fix without hiding anything.

> Regards,
> Peter Hurley

Sebastian
