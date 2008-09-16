From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH 0/5] RFC: OMAP Synchronous Serial Interface (SSI) driver
Date: Tue, 16 Sep 2008 17:30:00 +0300
Message-ID: <1221575400.6315.227.camel@groo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47755 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYIPOac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 10:30:32 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GEUFeC025969
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 17:30:28 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi guys !

I'm working on adding support for Nokia HSPA modems to OMAP.

Please consider integrating the following patch set into the
linux-omap tree. The patch set implements a generic device driver
for the OMAP Synchronous Serial Interface. 

The Synchronous Serial Interface (SSI) is a high speed communication
interface that is used for connecting OMAP to a cellular modem engine.

The patch set is based on linux-omap 2.6.27-rc6.

Any comments will be appreciated.

Br,
Carlos

 Documentation/arm/OMAP/ssi/board-ssi.c.example       |  216 +++++++
 Documentation/arm/OMAP/ssi/ssi                       |  233 +++++++
 arch/arm/plat-omap/include/mach/ssi/ssi_gdd_reg.h    |  145 ++++
 arch/arm/plat-omap/include/mach/ssi/ssi_reg_common.h |   73 ++
 arch/arm/plat-omap/include/mach/ssi/ssi_ssr_reg.h    |   56 +
 arch/arm/plat-omap/include/mach/ssi/ssi_sst_reg.h    |   65 ++
 arch/arm/plat-omap/include/mach/ssi/ssi_sys_reg.h    |  108 +++
 drivers/misc/Kconfig                                 |    2 
 drivers/misc/Makefile                                |    2 
 drivers/misc/ssi/Kconfig                             |   20 
 drivers/misc/ssi/Makefile                            |   11 
 drivers/misc/ssi/ssi_driver.c                        |  572 +++++++++++++++++++
 drivers/misc/ssi/ssi_driver.h                        |  228 +++++++
 drivers/misc/ssi/ssi_driver_bus.c                    |  218 +++++++
 drivers/misc/ssi/ssi_driver_dma.c                    |  461 +++++++++++++++
 drivers/misc/ssi/ssi_driver_if.c                     |  374 ++++++++++++
 drivers/misc/ssi/ssi_driver_int.c                    |  296 +++++++++
 include/linux/ssi_driver_if.h                        |  138 ++++
 18 files changed, 3213 insertions(+), 5 deletions(-)



