From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH V02 0/5] dmaengine: New 'universal' API for requesting channel
Date: Mon, 14 Dec 2015 13:22:15 +0200
Message-ID: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Added Reviewed-by from Andy for patch 1-2, I decided to not add the reviewed-by
  to patch 3 due to the changes since v1
- patch for omap-dma to support passing the filter setup to the core
- dma_request_slave_channel_reason() remeved and it is now defines as
  dma_request_chan()
- Print of warning removed when DT or ACPI lookup fails and we are going to
  Fallback to legacy lookup
- members of struct dma_filter has been revised for simplicity.

Changes since RFC v03:
- No longer RFC
- Dropped the arch/arm/mcah-davinci and daVinci MMC and SPI patches so we don't
  have inter subsystem issues.
- Comments from Andy to patch no 3 has been addressed with the exception of
  moving code over to device_property
- 'struct dma_filter_map' renamed as 'struct dma_slave_map'
- Code documentation added

Changes since RFC v02:
- Using has_acpi_companion() instead ACPI_HANDLE()
- mask matching change within private_candidate()
- Fallback in dma_request_chan() when DT/ACPI lookup fails.
- Rename dma_get_channel() -> find_candidate()
- Arch code changes as suggested by Arnd
- Some documentation updated, more need to be done.

Changes since RFC v01:
- dma_request_chan(); lost the mask parameter
- The new API does not rely on RESOURCE_DMA, instead the dma_slave_map table
  will be used to provide the needed information to the filter function in
  legacy mode
- Extended the example patches to convert most of daVinci to use the new API to
  request the DMA channels.

As it has been discussed in the following thread:
http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487

With this series I have taken a path which would result two new API, which can
be used to convert most of the current users already and with some work all
users might be able to move to this set.
With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
longer needed to be exported to client drivers since the selection of the
correct filter_fn will be done in the core.

So, the first proposal is to have:

struct dma_chan *dma_request_chan(struct device *dev, const char *name);
struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);

The dma_request_chan_by_mask() is to request any channel matching with the
requested capabilities, can be used to request channel for memcpy, memset, xor,
etc where no hardware synchronization is needed.

The dma_request_chan() is to request a slave channel. The dma_request_chan()
will try to find the channel via DT, ACPI or in case if the kernel booted in non
DT/ACPI mode it will use a filter lookup table and retrieves the needed
information from the dma_slave_map provided by the DMA drivers.
This legacy mode needs changes in platform code, in dmaengine drivers and
finally the dmaengine user drivers can be converted:

For each dmaengine driver an array of DMA device, slave and the parameter
for the filter function needs to be added:

static const struct dma_slave_map da830_edma_map[] = {
	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
	{ "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
	{ "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
	{ "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
	{ "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
};

This information is going to be used by the dmaengine driver, so
modification to the platform_data is needed, and the driver map should be
added to the pdata of the DMA driver:

da8xx_edma0_pdata.slave_map = da830_edma_map;
da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);

The DMA driver then needs to configure the needed device -> filter_fn
mapping before it registers with dma_async_device_register() :

ecc->dma_slave.filter_map.map = info->slave_map;
ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
ecc->dma_slave.filter_map.fn = edma_filter_fn;

When neither DT or ACPI lookup is available the dma_request_chan() will
try to match the requester's device name with the filter_map's list of
device names, when a match found it will use the information from the
dma_slave_map to get the channel with the dma_get_channel() internal
function.

Tested on OMAP-L138 (dm850) EVM, with updtaed patches from RFC v03 [1].
Both legacy and DT boot works fine.

[1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122016.html

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: core: Skip mask matching when it is not provided to
    private_candidate
  dmaengine: core: Move and merge the code paths using private_candidate
  dmaengine: core: Introduce new, universal API to request a channel
  dmaengine: edma: Add support for DMA filter mapping to slave devices
  dmaengine: omap-dma: Add support for DMA filter mapping to slave
    devices

 Documentation/dmaengine/client.txt |  23 ++---
 drivers/dma/dmaengine.c            | 172 ++++++++++++++++++++++++++-----------
 drivers/dma/edma.c                 |   4 +
 drivers/dma/omap-dma.c             |   4 +
 include/linux/dmaengine.h          |  51 +++++++++--
 include/linux/omap-dma.h           |   6 ++
 include/linux/platform_data/edma.h |   7 ++
 7 files changed, 191 insertions(+), 76 deletions(-)

-- 
2.6.4
