From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Mon, 10 Aug 2015 14:19:37 +0200
Message-ID: <55C896D9.5040300@linutronix.de>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de> <1438977619-15488-2-git-send-email-bigeasy@linutronix.de> <55C890E2.50208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C890E2.50208@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com
Cc: Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On 08/10/2015 01:54 PM, Peter Ujfalusi wrote:
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index 0340ee6ba970..07a11e0935e4 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> @@ -769,7 +771,9 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
>>  		return;
>>  	}
>>  
>> -	dmaengine_pause(dma->rxchan);
>> +	ret = dmaengine_pause(dma->rxchan);
>> +	if (WARN_ON_ONCE(ret))
>> +		priv->rx_dma_broken = true;
> 
> I don't think this is good thing for the stable _and_ for the mainline at the
> same time:
> in stable the rx DMA should not be allowed since the stable kernels does not
> allow pause/resume with omap-dma, so there the rx DMA should be just disabled
> for UART. This change will cause regression since it introduce a WARN_ON_ONCE,
> which will be printed if the user tries to use non working feature.

Okay. We do have pause support in mainline for edma since v4.2-rc1.
This driver can use edma or sdma depending on the configuration. But it
is not yet released. So you suggest remove RX-DMA support completely
from the 8250-omap, mark it stable, and revert that patch once we have
it fixed in sdma?

> In mainline you will eventually going to have pause/resume support so this
> patch will make no sense there.

The way this works is that it has to be fixed upstream before it can be
backported stable. Also Russell made clear (for a good reason) that the
RX problem has to be fixed upstream before he thinks about acking the
SDMA patch.
So if you prefer to instead remove RX-DMA until it is fixed, I am all
yours.


Sebastian
