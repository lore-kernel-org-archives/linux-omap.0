From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 6 Jan 2015 14:38:31 +0200
Message-ID: <20150106123830.GD30544@fuloong-minipc.musicnaut.iki.fi>
References: <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
 <20150105231620.GC30544@fuloong-minipc.musicnaut.iki.fi>
 <20150106020122.GA24980@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:47279 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbAFMik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 07:38:40 -0500
Content-Disposition: inline
In-Reply-To: <20150106020122.GA24980@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

Hi,
On Mon, Jan 05, 2015 at 08:01:22PM -0600, Felipe Balbi wrote:
> On Tue, Jan 06, 2015 at 01:16:21AM +0200, Aaro Koskinen wrote:
> > I did some debugging and it seems the "In-band Error"
> > occurs when omap_system_dma_probe() is being run, specifically when
> > the interrupt is enabled. I believe the "DMA" interrupt it's trying
> > set up is completely wrong:
> > 
> >  28:          0      GPIO   2  DMA
> > 
> > GPIO 2?! Where is that coming from?
> 
> heh, it's probably the linux number used ended up mapping to another irq
> domain. Can you add this debugging patch and report dmesg ?

Post-commit:

[    0.208251] omap_dma_system omap_dma_system.0: legacy DMA IRQ 28
[    0.216125] omap-dma-engine 48056000.dma-controller: dmaengine IRQ 22

 22:          5      INTC  13  omap-dma-engine
 28:          0      GPIO   2  DMA

Pre-commit:

[    0.208557] omap_dma_system omap_dma_system.0: legacy DMA IRQ 28
[    0.216461] omap-dma-engine 48056000.dma-controller: dmaengine IRQ 29

 28:          0      INTC  12  DMA
 29:          5      INTC  13  omap-dma-engine

> Note that I need one log post commit and another log pre commit. If any
> of the IRQ numbers change, if means that irq_domain_add_linear() ended
> up changing IRQ start and we would need some trick to grab the correct
> IRQ number again.

So looks like static OMAP_INTC_START cannot be used anymore, but hwmod
data is full of these?

mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c: { .name = "0", .irq = 12 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ0 */

A.
