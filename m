From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/14] dmaenigne: edma/ti-crossbar: fixes, new bindings
Date: Fri, 16 Oct 2015 10:17:58 +0300
Message-ID: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Comments in the memcpy optimization patch extended
- The crossbar patch has been improved:
 - debug prints changed
 - fallback xbar parameters now type specific as the fallback values for DRA7
   are not valid for AM33xx crossbar.
- New patch for Kconfig to select the crossbar in case the eDMA is used on OMAP
  platforms

This series depends on the eDMA driver merger series (v5) [1].

The first two patch is to improve the memcpy functionality by removing the
alignment constraint and speed optimization (memcpy speed is up from ~3MB/s to
~15MB/s).

The rest of the series consits of smaller cleanup patches and the new DT binding
implementation for the eDMA3 and the crossbar found in am33xx/am43xx.

The new DT binding was needed for several reasons:
- the original binding was 'Documentating' the Linux driver functionality.
- the use of multiple ti,hwmod properties in the binding need to be removed. In
  recent kernels we have kernel warning printed because of this.
- No way to set queue priorities
- No way to fix the memcpy issue [2]
- Missing infrastructure to deal with multi core usage (ARM + DSP)
- eDMA behind of a crossbar was not safe to use - it could be hacked to work.

While some of these issues migh have been fixed with the old binding by adding
new properties all along, but the TPCC and TPTC separation (to fix the hwmod
warning and to be able to have better power management) and the need to be able
to select TC to execute the given channel demanded new compatible for the eDMA3
components.

[1] http://www.spinics.net/lists/arm-kernel/msg452373.html

[2] memcpy issue with the old stack
ever since the eDMA got support via dmaengine and the memcpy was enabled it has
been mostly broken and worked by luck only.
The root of the issue was that the channels for the memcpy was taken from the
same pool as the slave channels. Since in eDMA a channel number is wired to be
used with the same event number (HW request) this had it's faults. With
dmaengine the driver will always be asked for a channel since the channel
selection for any channel is done in the dmaengine layer.
The whole magic of builing the unused channel list and stuff did not help:
Let assume that in DT we have users for channel 0,1,2,3,10,11.
The eDMA driver would mark these channels as used - which means they are HW
syncronized. If we have drivers enabled which uses channel 0,1,10,11 and some
driver request for a channel for memcpy, it will get the channel 2 and when this
memcpy channel is used it would have been assumed to be HW triggered, so the
memcpy would not work at all. There were no way to fix this within the old
driver stack and with the old bindings.

I'm maintaining this (and other patches) in my linux-next-wip branch if someone
wants to try it out w/o needing to hunt for patches:
https://github.com/omap-audio/linux-audio.git peter/linux-next-wip 

Regards,
Peter
---
Peter Ujfalusi (14):
  dmaengine: edma: Remove alignment constraint for memcpy
  dmaengine: edma: Optimize memcpy operation
  dmaengine: edma: Simplify function parameter list for channel
    operations
  dmaengine: edma: Correct PaRAM access function names (_parm_ to
    _param_)
  dmaengine: edma: Merge map_dmach_to_queue into assign_channel_eventq
  dmaengine: edma: Get qDMA channel information from HW also
  dmaengine: edma: Refactor the dma device and channel struct
    initialization
  dmaengine: edma: Do not allocate memory for edma_rsv_info in case of
    DT boot
  dmaengine: edma: Merge the of parsing functions
  dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx
  dmaengine: Kconfig: edma: Select TI_DMA_CROSSBAR in case of ARCH_OMAP
  dmaengine: edma: New device tree binding
  ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
  ARM: DTS: am437x: Use the new DT bindings for the eDMA3

 .../devicetree/bindings/dma/ti-dma-crossbar.txt    |   15 +-
 Documentation/devicetree/bindings/dma/ti-edma.txt  |  117 ++-
 arch/arm/boot/dts/am335x-evm.dts                   |    9 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   11 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   96 +-
 arch/arm/boot/dts/am4372.dtsi                      |   82 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    9 +-
 drivers/dma/Kconfig                                |    1 +
 drivers/dma/edma.c                                 | 1066 +++++++++++---------
 drivers/dma/ti-dma-crossbar.c                      |  251 ++++-
 include/linux/platform_data/edma.h                 |    3 +
 11 files changed, 1060 insertions(+), 600 deletions(-)

-- 
2.6.1
