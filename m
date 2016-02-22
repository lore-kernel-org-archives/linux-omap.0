From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] serial: omap: robustify for high speed transfers
Date: Mon, 22 Feb 2016 11:38:18 -0800
Message-ID: <20160222193818.GT21163@atomide.com>
References: <87lh7hrjsg.fsf@linutronix.de>
 <56A66FCB.1000507@hurleysoftware.com>
 <87y4b85onp.fsf@linutronix.de>
 <56B15603.80807@hurleysoftware.com>
 <87wpqbihel.fsf@linutronix.de>
 <20160211210050.GY19432@atomide.com>
 <874md0yd81.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874md0yd81.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* John Ogness <john.ogness@linutronix.de> [160222 07:30]:
> Hi Tony,
> 
> On 2016-02-11, Tony Lindgren <tony@atomide.com> wrote:
> >> At these speeds, nearly every DMA interrupt is accompanied by a
> >> spurious UART interrupt. So, sadly, the interrupts are doubled.
> >> 
> >> It is on my TODO list to verify if the spurious UART interrupts
> >> exactly match the recently added [0] spurious interrupt detection in
> >> omap-intc.
> >
> > If you're seeing spurious interrupts you may want try adding
> > a flush of posted write at the end of the 8250_omap interrupt
> > handler. Basically read back some register from the 8250. This
> > has fixed so far pretty much all the spurious IRQ issues for
> > omaps using the drivers/irqchip/irq-omap-intc.c, meaning omap3
> > and am335x and ti81xx variants too most likely.
> 
> I have done significant testing with this using linux-next-20160219. The
> only changes I made were to disable the "rx_dma_broken" feature so that
> DMA would definately be used. I created a simple test where I send 48000
> bytes at 230400bps over UART from one device to another. Several
> different target devices and configurations were used to test the RX-DMA
> feature of the 8250_omap. The expected result is 1000 DMA interrupts and
> 0 UART interrupts.
> 
> With the am335x (Beaglebone Black, eDMA engine) I see 1000 DMA
> interrupts and 1000 spurious UART interrupts. The spurious UART
> interrupts arrive 30-50us _before_ the DMA interrupts. Always.
> 
> If I disable UART timeout interrupts (RDI), the same test generates no
> spurious UART interrupts. Only 1000 DMA interrupts.
> 
> I ran the same test using a dra7 board (sDMA engine) as the target
> device. RDI was enabled. Here I see no spurious interrupts.
> 
> I modified the dra7 device tree to use the eDMA engine with the
> UART. RDI was enabled. Here I also see no spurious interrupts.
> 
> The dra7 uses a different interrupt controller (irq-gic instead of
> irq-omap-intc), which probably explains why dra7+edma+rdi works
> correctly.
> 
> I tried adding various and multiple register reads at the end of the
> interrupt handlers, but this made no difference. What is interesting is
> the fact that the spurious UART interrupt always _preceeds_ the DMA
> interrupt and by a significant yet relatively consistent amount
> (30-50us). Even the very first DMA interrupt is preceeded by the
> spurious interrupt. It is as if the UART timeout logic is triggering
> because it does not notice that the eDMA is pulling the data from the
> FIFO. But only when the irq-omap-intc in involved.
> 
> Tony, if you have any futher ideas, I'd be happy to try them out.
> 
> Summary: If DMA is ever going to be re-enabled for am335x/8250_omap,
> then it will be necessary to return IRQ_HANDLED for the spurious UART
> interrupts that will preceed each DMA-RX completion interrupt.

Well thanks for checking, sounds like this is some UART specific
issue. I guess one more thing you could try is adding a read backs
to the functions staring the DMA transfers and see if that makes
any difference.

Regards,

Tony
