From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 10:58:59 -0700
Message-ID: <20121030175856.GK11908@atomide.com>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
 <20121030162727.GG11908@atomide.com>
 <20121030172707.GB3993@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39449 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759668Ab2J3R7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 13:59:06 -0400
Content-Disposition: inline
In-Reply-To: <20121030172707.GB3993@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [121030 10:34]:
> Hi,
> 
> On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > > > 
> > > > MMC is dependent on EDMA-DMA conversion patches from Matt, which he has 
> > > > already submitted to the list recently. So MMC support will come along with
> > > > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it goes.
> > 
> > This is a bogus dependency, the MMC driver needs to also work
> > without DMA.
> 
> heh, too bad driver errors out when it doesn't find DMA channels :-)

It should just print a warning instead and continue.
 
> 1869         host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &rx_req);
> 1870         if (!host->rx_chan) {
> 1871                 dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> 1872                 ret = -ENXIO;
> 1873                 goto err_irq;
> 1874         }
> 1875 
> 1876         host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &tx_req);
> 1877         if (!host->tx_chan) {
> 1878                 dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> 1879                 ret = -ENXIO;
> 1880                 goto err_irq;
> 1881         }
> 
> in fact, if DMAENGINE isn't enabled, this won't even compile due to
> omap_dma_filter_fn() right ?

It should, CONFIG_DMADEVICES is optional. If it does not compile,
then there's a bug somewhere.

Regards,

Tony
