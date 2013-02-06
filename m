From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] ARM: dts: Add DT bindings for OMAP SDMA
Date: Wed, 6 Feb 2013 15:03:14 -0600
Message-ID: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56303 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757864Ab3BFVDn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 16:03:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jon-hunter@ti.com>

Adds device-tree bindings from SDMA on OMAP2+ devices. DMA client
bindings are also added for devices that have SPI and MMC bindings
populated. Client binding data is based upon existing HWMOD data for
OMAP and has been checked against OMAP documentation.

Testing includes ...
1. Boot tested on OMAP3430 Beagle board, OMAP4430 Panda board and
   OMAP4460 Panda board with and without device-tree present.
2. Testing of MMC1 with SD card on OMAP3430 Beagle board, OMAP4430
   Panda board and OMAP4460 Panda board with and without device-tree
   present.

Testing branch available here [1].

Series is based upon v3.8-rc6 on top of the following ...
- Vinod's topic/dmaengine_dt branch [2]
- Matt Porter's series "DMA Engine support for AM33XX" [3]
- Matt Porter's series "omap_hsmmc DT DMA Client support" [4]
- Sourav Poddar's series "add omap mcspi device tree data" [5]

[1] https://github.com/jonhunter/linux/commits/dev-dt-dma
[2] http://git.infradead.org/users/vkoul/slave-dma.git/shortlog/refs/heads/topic/dmaengine_dt
[3] http://permalink.gmane.org/gmane.linux.kernel.spi.devel/12508
[4] http://permalink.gmane.org/gmane.linux.ports.arm.omap/93165
[5] http://permalink.gmane.org/gmane.linux.kernel/1435002

Jon Hunter (2):
  ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
  dmaengine: OMAP: Register SDMA controller with Device Tree DMA driver

 .../devicetree/bindings/dma/omap-sdma.txt          |   44 ++++++++++++++++++++
 arch/arm/boot/dts/omap2.dtsi                       |   12 ++++++
 arch/arm/boot/dts/omap3.dtsi                       |   40 ++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   41 ++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   41 ++++++++++++++++++
 drivers/dma/omap-dma.c                             |   31 +++++++++++++-
 6 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt

-- 
1.7.10.4

