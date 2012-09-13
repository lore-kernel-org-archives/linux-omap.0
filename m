From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 0/2] of: Add generic device tree DMA helpers
Date: Thu, 13 Sep 2012 17:00:27 -0500
Message-ID: <1347573629-21299-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab2IMWBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 18:01:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2] to add
some basic device-tree helpers to retrieve a DMA controller device_node and the
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
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>

Jon Hunter (2):
  of: Add generic device tree DMA helpers
  dmaengine: add helper function to request a slave DMA channel

 Documentation/devicetree/bindings/dma/dma.txt |   62 +++++++
 drivers/dma/dmaengine.c                       |   16 ++
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  215 +++++++++++++++++++++++++
 include/linux/dmaengine.h                     |    6 +
 include/linux/of_dma.h                        |   45 ++++++
 6 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

-- 
1.7.9.5

