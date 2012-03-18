From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 22:12:00 +0000
Message-ID: <201203182212.00769.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120318204421.759F23E07BF@localhost> <201203182158.10957.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64452 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab2CRWMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 18:12:14 -0400
In-Reply-To: <201203182158.10957.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

On Sunday 18 March 2012, Arnd Bergmann wrote:
> > 
> > Is dma_find_device() a new function?  How does it look up the dma
> > device?
> 
> Yes, it would be similar to the proposed function in Benoit's patch
> 

Well, actually we would not even need a new list with all the devices,
it can simply become

/* must be called with dma_list_mutex held */
static struct dma_device *dma_find_device(struct of_node *node)
{
	struct dma_device *device;
	
	list_for_each_entry(device, &dma_device_list, global_node) {
		if (device->dev.of_node == node)
			break;
	}
	return device;
}

Given that dma_device_list is most likely be a very short list, this will
be a fast operation.

	Arnd
