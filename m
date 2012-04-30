From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 0/2] of: Add generic device tree DMA helpers
Date: Mon, 30 Apr 2012 16:16:27 -0500
Message-ID: <1335820587-28679-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652Ab2D3VQz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 17:16:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>

From: Jon Hunter <jon-hunter@ti.com>

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
to add some basic helpers to retrieve a DMA controller device_node and the
DMA request/channel information.

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/12022
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/73622

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Jon Hunter (2):
  of: Add generic device tree DMA helpers
  of: selftest/dma: Add selftest for new DT DMA

 Documentation/devicetree/bindings/dma/dma.txt |   47 ++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts        |    2 +
 arch/arm/boot/dts/omap4-panda.dts             |    2 +
 arch/arm/boot/dts/testcases/tests-dma.dtsi    |   32 ++++
 arch/arm/boot/dts/testcases/tests.dtsi        |    1 +
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  203 +++++++++++++++++++++++++
 drivers/of/selftest.c                         |  118 ++++++++++++++
 include/linux/of_dma.h                        |   35 +++++
 9 files changed, 441 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 arch/arm/boot/dts/testcases/tests-dma.dtsi
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

-- 
1.7.5.4

