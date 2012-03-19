From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 14:06:34 +0000
Message-ID: <201203191406.35064.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120317094059.7C2333E08E2@localhost> <4F6734DD.3020203@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58005 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964937Ab2CSOGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 10:06:42 -0400
In-Reply-To: <4F6734DD.3020203@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Monday 19 March 2012, Nicolas Ferre wrote:
> > This _xlate is nearly useless as a generic API.  It solves the problem for
> > the specific case where the driver is hard-coded to know which DMA engine
> > to talk to, but since the returned data doesn't provide any context, it
> > isn't useful if there are multiple DMA controllers to choose from.
> 
> You mean, if there is no DMA controller phandle specified in the
> property? I think that it is not the purpose of this API to choose a DMA
> controller, Nor to provide a channel. The only purpose of this API is to
> give a HW request to be used by a DMA slave driver. This slave should
> already have a channel to use and a controller to talk to.

I don't think there is consensus on this point. I would expect that
the device driver requests the channel with the same operation as
passing the request data.

Contrast the two ways this is done in atmel-mci.c and mmci.c:

==== atmel ====
/* interface between platform and driver */
struct at_dma_slave {
        struct device           *dma_dev;
        dma_addr_t              tx_reg;
        dma_addr_t              rx_reg;
        enum at_dma_slave_width reg_width;
        u32                     cfg;
        u32                     ctrla;
};
struct mci_dma_data {
        struct at_dma_slave     sdata;
};
#define slave_data_ptr(s)       (&(s)->sdata)
#define find_slave_dev(s)       ((s)->sdata.dma_dev)

/* in atmel-mci.c */
static bool atmci_filter(struct dma_chan *chan, void *slave)
{
        struct mci_dma_data     *sl = slave;

        if (sl && find_slave_dev(sl) == chan->device->dev) {
                chan->private = slave_data_ptr(sl);
                return true;
        } else {
                return false;
        }
}
static bool atmci_configure_dma(struct atmel_mci *host)
{
	...
	host->dma.chan = dma_request_channel(mask, atmci_filter, pdata->dma_slave);
	...
}

==== mmci ====
/* in drivers/dma/ste_dma40.c, others in pl330.c, coh901318.c, ... */
bool stedma40_filter(struct dma_chan *chan, void *data)
{               
        struct stedma40_chan_cfg *info = data;
        struct d40_chan *d40c = container_of(chan, struct d40_chan, chan);
        int err;                
        
        err = d40_validate_conf(d40c, info);
        if (!err)
                d40c->dma_cfg = *info;
        d40c->configured = true;
        
        return err == 0;
}
EXPORT_SYMBOL(stedma40_filter);

/* in mmci.h */
struct mmci_platform_data {
	...
        bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
        void *dma_rx_param;
        void *dma_tx_param;
};

/* in mmci.c */
static void __devinit mmci_dma_setup(struct mmci_host *host)
{
	...
        host->dma_rx_channel = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
	...
}

====

Whatever we come up with obviously needs to work with both drivers.
I think we will end up with something closer to the second one, except
that the dma parameters do not come from platform_data but from the
#dma-request property, which also identifies the controller and channel.

	Arnd
