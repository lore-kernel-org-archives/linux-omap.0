From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 06:17:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB6361E@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com> <20121030162727.GG11908@atomide.com>
 <20121030172707.GB3993@arwen.pp.htv.fi> <20121030175856.GK11908@atomide.com>
 <20121030185102.GC4804@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2KFGRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 01:17:31 -0500
In-Reply-To: <20121030185102.GC4804@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 31, 2012 at 00:21:02, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Oct 30, 2012 at 10:58:59AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [121030 10:34]:
> > > Hi,
> > > 
> > > On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> > > > * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > > > > > 
> > > > > > MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
> > > > > > already submitted to the list recently. So MMC support will come along with
> > > > > > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.
> > > > 
> > > > This is a bogus dependency, the MMC driver needs to also work
> > > > without DMA.
> > > 
> > > heh, too bad driver errors out when it doesn't find DMA channels :-)
> > 
> > It should just print a warning instead and continue.
> >  
> > > 1869         host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
> > > 1870         if (!host->rx_chan) {
> > > 1871                 dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> > > 1872                 ret = -ENXIO;
> > > 1873                 goto err_irq;
> > > 1874         }
> > > 1875 
> > > 1876         host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
> > > 1877         if (!host->tx_chan) {
> > > 1878                 dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> > > 1879                 ret = -ENXIO;
> > > 1880                 goto err_irq;
> > > 1881         }
> > > 
> > > in fact, if DMAENGINE isn't enabled, this won't even compile due to
> > > omap_dma_filter_fn() right ?
> > 
> > It should, CONFIG_DMADEVICES is optional. If it does not compile,
> > then there's a bug somewhere.
> 
> you're right, there's a static inline nop for when we don't have omap
> dma engine driver compiled.
> 
> nevermind.
> 

Did anybody tried polling mode MMC support on OMAP devices in the past?

Thanks,
Vaibhav

> -- 
> balbi
> 

