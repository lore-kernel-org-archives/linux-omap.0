From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V02 3/5] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Mon, 14 Dec 2015 21:04:09 +0800
Message-ID: <201512142130.g8eZzCT6%fengguang.wu@intel.com>
References: <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450092140-31602-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kbuild-all@01.org, vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Peter,

[auto build test WARNING on slave-dma/next]
[also build test WARNING on v4.4-rc5 next-20151214]

url:    https://github.com/0day-ci/linux/commits/Peter-Ujfalusi/dmaengine-core-Skip-mask-matching-when-it-is-not-provided-to-private_candidate/20151214-192521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/dma/dmaengine.c:715:23-30: ERROR: PTR_ERR applied after initialization to constant on line 703

vim +715 drivers/dma/dmaengine.c

   697	 *
   698	 * Returns pointer to appropriate DMA channel on success or an error pointer.
   699	 */
   700	struct dma_chan *dma_request_chan(struct device *dev, const char *name)
   701	{
   702		struct dma_device *d, *_d;
 > 703		struct dma_chan *chan = NULL;
   704	
   705		/* If device-tree is present get slave info from here */
   706		if (dev->of_node)
   707			chan = of_dma_request_slave_channel(dev->of_node, name);
   708	
   709		/* If device was enumerated by ACPI get slave info from here */
   710		if (has_acpi_companion(dev) && !chan)
   711			chan = acpi_dma_request_slave_chan_by_name(dev, name);
   712	
   713		if (chan) {
   714			/* Valid channel found or requester need to be deferred */
 > 715			if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
   716				return chan;
   717		}
   718	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
