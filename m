From: "S, Venkatraman" <svenkatr@ti.com>
Subject: RE: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor autoloading
 feature
Date: Tue, 1 Sep 2009 18:30:49 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0037CE4831F@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C0037CE47C07@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA616D46@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbZIANBD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 09:01:03 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA616D46@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Santosh, 

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Monday, August 31, 2009 11:41 PM
> To: S, Venkatraman; linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor 
> autoloading feature

> > 
> > 2) Pause / resume of transfers
> >        A transfer can be paused after a descriptor set has been 
> > loaded, provided the 'pause bit' is set in the linked list element.
> > An ongoing transfer cannot be paused. If the 'pause bit' is set, 
> > transfer is not started after loading the register set from memory.
> > Such a transfer can be resumed later.
> Would it be good if we move this description just above those 
> APIs. Even though this information is good to be here but 
> later once merged, this would go in commit history.
> Somebody reading code also would benefit from this info. I 
> leave that decision to you.

Agreed partly. Consistent with rest of the source tree,
 I don't like to fit a complete user guide in here.
But I'll repost the patch with some brief API comments.

> > 3) Descriptor types
> >        3 possible configurations of descriptors (initialized as linked 
> > list elements) are possible. Type 1 provides the maximum flexibility, 
> > which contains most register definitions of a DMA logical channel. 
> > Fewer options are present in type 2. Type 3 can just modify 
> > source/destinations address of transfers. In all transfers, unmodified 
> > registers settings are maintained for the next transfer.
> 
> This information too should be in source code somewhere.

Ditto

> > +int omap_request_dma_sglist(int dev_id, const char *dev_name,
> > +	void (*callback) (int channel_id, u16 ch_status, void *data),
> > +	int *listid, int nelem, struct omap_dma_sglist_node **elems) {
> > +	struct omap_dma_list_config_params *lcfg;
> > +	struct omap_dma_sglist_node *desc;
> > +	int dma_lch;
> > +	int rc, i;
> > +
> > +	if (unlikely((dma_caps0_status & 
> DMA_CAPS_SGLIST_SUPPORT) == 0)) {
> > +		printk(KERN_ERR "omap DMA: sglist feature not 
> supported\n");
> > +		return -EPERM;
> > +	}
> Don't you need this check in all exported Descriptor API's ?
> 

Just adds clutter. The request_* API is the first one to be called,
and the driver above has to respect the error code and not make 
further configuration requests.
 If not, it is  equally likely on OMAP4 and the check would pass, but create havoc.
Short answer: Can't defend against poor programming.
Perhaps a omap_dma_is_sg_capable() API is needed ? That doesn't scale for
all the drivers & capabilities. Please comment.

> > +	if (unlikely(nelem <= 2)) {
> > +		printk(KERN_ERR "omap DMA: Need >2 elements in 
> the list\n");
> > +		return -EINVAL;
> > +	}
> > +	rc = omap_request_dma(dev_id, dev_name,
> > +			  callback, NULL, &dma_lch);
> > +	if (rc < 0) {
> > +		printk(KERN_ERR "omap_dma_list: Request failed 
> %d\n", rc);
> > +		return rc;
> > +	}
> > +	*listid = dma_lch;
> > +	dma_chan[dma_lch].state = DMA_CH_NOTSTARTED;
> You have updated channel status here but below allocations 
> can still fail.
> Safer is to update this once all allocation and variable 
> population done.

It doesn't matter. It's the earliest possible state, that seems to apply to 
a unconfigured channel as well.

> >  extern void omap_set_dma_priority(int lch, int dst_port, int 
> > priority);  extern int omap_request_dma(int dev_id, const char 
> > *dev_name, @@ -656,6 +739,21 @@ extern int 
> > omap_modify_dma_chain_params(int chain_id,  extern int 
> > omap_dma_chain_status(int chain_id);  #endif
> 
> > +extern int omap_request_dma_sglist(int dev_id, const char *dev_name,
> > +		void (*callback) (int channel_id, u16 ch_status, void *data),
> > +		int *listid, int nelem, struct omap_dma_sglist_node **elems);
> With this code callback after fewer nodes is not supported right ?

I suppose you mean the interrupt callback. 
The controller & the interrupt management are clever enough to call back when
you have set a pause in the middle.
A fine grained control is available if the DMA user provides a TYPE 1 descriptor.
Not usually needed - it beats the purpose of providing a list.
