From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/9] ARM: dts: Various OMAP2+ device-tree updates
Date: Fri, 8 Mar 2013 11:27:24 -0600
Message-ID: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49617 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146Ab3CHR1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:27:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.

The DMA, PMU and OMAP3430 SDP board changes have been sent before
individually but re-sending here as a complete series for v3.10.

This is based upon v3.9-rc1 and the OMAP3 GPMC binding from Florian
Vaussard [1] and OMAP5 DT SPI patch from Felipe Balbi [2].

[1] https://patchwork.kernel.org/patch/2057111/
[2] https://patchwork.kernel.org/patch/2134711/

Jon Hunter (9):
  ARM: OMAP2+: Prepare for device-tree PMU support
  ARM: dts: OMAP2+: Add PMU nodes
  ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
  ARM: dts: OMAP3: Add support for OMAP3430 SDP board
  ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
  ARM: dts: Add OMAP3430 SDP flash memory bindings
  ARM: dts: Add OMAP2 gpio bindings
  ARM: dts: OMAP3+: Correct gpio #interrupts-cells property
  ARM: dts: OMAP3: Add reg and interrupt properties for gpio

 .../devicetree/bindings/dma/omap-sdma.txt          |   51 +++++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/omap2.dtsi                       |   17 +++
 arch/arm/boot/dts/omap2420.dtsi                    |   55 ++++++++
 arch/arm/boot/dts/omap2430.dtsi                    |   66 +++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   70 +++++++++-
 arch/arm/boot/dts/omap3430-sdp.dts                 |  141 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda-es.dts               |    2 +
 arch/arm/boot/dts/omap4.dtsi                       |   64 ++++++++-
 arch/arm/boot/dts/omap4460.dtsi                    |   18 +++
 arch/arm/boot/dts/omap5.dtsi                       |   68 ++++++++--
 arch/arm/mach-omap2/pmu.c                          |   14 +-
 12 files changed, 544 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/omap-sdma.txt
 create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap4460.dtsi

-- 
1.7.10.4

