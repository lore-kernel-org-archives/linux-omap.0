From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC 3/3] serial: 8250_omap: try to avoid IER_RDI with DMA
Date: Wed, 26 Aug 2015 14:42:10 +0530
Message-ID: <55DD82EA.6090300@ti.com>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de> <1439568064-7907-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439568064-7907-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Friday 14 August 2015 09:31 PM, Sebastian Andrzej Siewior wrote:
> It has been observed on DRA7-evm that the UART triggers the interrupt and
> reading IIR says IIR_NO_INT. It seems that we receive data via RX-DMA
> but the interrupt is triggered anyway. I have hardly observed it on
> AM335x and not in *that* quantity. On DRA7-evm with continuous transfers
> at 3MBaud and CPU running at 1.5Ghz it is possible that the IRQ-core will
> close the UART interrupt after "some time" with "nobody cared".
> 
> I've seen that by not enabling IER_RDI those spurious interrupts are not
> triggered. Also it seems that DMA and RDI cause the "timeout interrupt"
> which does not allow RX-DMA to be scheduled even if the FIFO reached the
> programmed RX threshold. However without RDI we don't get a notification
> if we have less than RX threshold bytes in the FIFO.
> This is where we have the rx_dma_wd timer. After programming the RX-DMA
> transfer wait HZ / 4 or 250ms for it to complete. If it does not
> complete in that time span we cancel the DMA transfer and enable RDI.
> RDI will trigger an UART interrupt in case we have bytes in the FIFO.
> Once we read bytes manually from the FIFO we enable RX-DMA again
> (without RDI) with the same 250ms timeout.
> 
> One downside with this approach is that latency sensitive protocols that
> transfer less than 48 bytes will have to wait 250ms to complete.

I guess because of this reason, wlink8 bluetooth connected to TI's DRA7
EVM failed to probe with this patch included. At the least, looks like
this patch needs some tuning.

> 
> Is there maybe a user interface where one could set small or bulk transfers?
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks,
Sekhar
