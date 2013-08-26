From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] DMA: let filter functions of of_dma_simple_xlate possible check of_node
Date: Mon, 26 Aug 2013 20:15:17 +0200
Message-ID: <3565907.5flGSRLgMJ@wuerfel>
References: <1375408800-11789-1-git-send-email-rizhao@nvidia.com> <2811939.DFy94j5OEx@avalon> <20130826141057.GQ2748@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130826141057.GQ2748@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Zhao <rizhao@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Zhao <linuxzsc@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Monday 26 August 2013 19:40:57 Vinod Koul wrote:
> Why does DT need the fliter function in the first place. The DT enabled drivers
> should not even have a filter function...
> 
> The dmaengine core calls the optional filter function. This needs to be
> implemented in driver in order for driver to check if the channel is what it
> needs or not.

You only just merged the dma_get_slave_channel() patch, which allows having
no filter function. Up to Linux-3.11, the filter was always needed but
could be 'static' and only called by the xlate function. Now the xlate
function can pick a channel itself.

> And the selection should be done for the cases where you dont have programmable
> mux in dmac. For programmable ones passing slave_id in dma_slave_config should
> be fine.

I think passing a slave_id from the slave driver is never correct with DT,
since the ID is a property of the system rather than the slave device, so
the driver has no access to it. Drivers have to always take the settings
from DT and ignore what dma_slave_config() sets later.

	Arnd
