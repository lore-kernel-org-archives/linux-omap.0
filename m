From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/13] dmaenigne: edma/ti-crossbar: fixes, new bindings
Date: Wed, 14 Oct 2015 16:12:11 +0300
Message-ID: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
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
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, arnd@arndb.de, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

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
Peter Ujfalusi (13):
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
 drivers/dma/edma.c                                 | 1060 +++++++++++---------
 drivers/dma/ti-dma-crossbar.c                      |  237 ++++-
 include/linux/platform_data/edma.h                 |    3 +
 10 files changed, 1045 insertions(+), 594 deletions(-)

-- 
2.6.1
