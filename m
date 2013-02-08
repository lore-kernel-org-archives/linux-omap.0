From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 0/2] ARM: dts: Add DT bindings for OMAP SDMA
Date: Thu, 7 Feb 2013 19:05:04 -0600
Message-ID: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45115 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759682Ab3BHBFa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 20:05:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jon-hunter@ti.com>

Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
bindings are also added for devices that have SPI and MMC bindings
populated. Client binding data is based upon existing HWMOD data for
OMAP and has been checked against OMAP documentation.

Please note that the underlying (legacy) OMAP SDMA driver has not been
ported over to DT and this still needs to be done. However, this allows
DMA clients to look-up the DMA resource information via device-tree.

Testing includes ...
1. Boot tested on OMAP3430 Beagle board, OMAP4430 Panda board and
   OMAP4460 Panda board with and without device-tree present.
2. Testing of MMC1 with SD card on OMAP3430 Beagle board, OMAP4430
   Panda board and OMAP4460 Panda board with and without device-tree
   present.

Testing branch available here [1].

Series is based upon Tony Lindgren's omap-for-v3.9/multiplatform-v2
branch [2] on top of the following ...
- Vinod's topic/dmaengine_dt branch [3]
- Matt Porter's series "DMA Engine support for AM33XX" [4]
- Matt Porter's series "omap_hsmmc DT DMA Client support" [5]
- Sourav Poddar's series "add omap mcspi device tree data" [6]

V2 changes:
- Updated to Tony's omap-for-v3.9/multiplatform-v2 branch to pull in
  DMA changes for v3.9
- Added comma to omap_dma_driver structure as pointed out by Arnd.
- Updated OMAP SDMA DT binding compatible strings to indicate which
  devices are bit compatible with each other with respect to the SDMA
  controller. Grant had mentioned in the past that he wants the
  compatible string to be based upon a particular device and not
  something generic like "ti,omap-sdma".

[1] https://github.com/jonhunter/linux/commits/dev-dt-dma
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v3.9/multiplatform-v2
[3] http://git.infradead.org/users/vkoul/slave-dma.git/shortlog/refs/heads/topic/dmaengine_dt
[4] http://permalink.gmane.org/gmane.linux.kernel.spi.devel/12508
[5] http://permalink.gmane.org/gmane.linux.ports.arm.omap/93165
[6] http://permalink.gmane.org/gmane.linux.kernel/1435002

Jon Hunter (2):
  ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
  dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver

 .../devicetree/bindings/dma/omap-sdma.txt          |   51 ++++++++++++++++++++
 arch/arm/boot/dts/omap2.dtsi                       |   12 +++++
 arch/arm/boot/dts/omap3.dtsi                       |   40 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++
 arch/arm/mach-omap2/dma.c                          |    4 ++
 drivers/dma/omap-dma.c                             |   37 +++++++++++++-
 7 files changed, 224 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt

-- 
1.7.10.4

