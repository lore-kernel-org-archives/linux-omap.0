From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH V4 0/5] ARM: OMAP: HOST: TLL driver implementation
Date: Mon, 16 Jul 2012 19:01:06 +0530
Message-ID: <1342445471-18704-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50812 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611Ab2GPNbW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 09:31:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

The TLL (Transceiver Less Link) is an separate IP block, independent of
the host controller. Basically this TLL operates like USB PHY which allows
the user to connect two USB transceiver interfaces together directly
without the use of differential transceivers in omap3 and later chips.
The TLL configuration is removed from the UHH driver and implemented as
a seperate platform driver. Now, the UHH driver configures the TLL
through API's exported by the TLL platform driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>

In v4:
    - rebased on top of linux kernel version 3.5.rc7
    - reworked as per the comments given by Paul Walmsley <paul@pwsan.com>

In v3:
  - rebased on top V3 of Russ dill's patch
       'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
       fixes an issue where the ULPI PHYs were not held in reset
       while initializing the EHCI controller
	http://permalink.gmane.org/gmane.linux.usb.general/65988
      
  - rebased on top of patch 
    OMAP: USB : Fix the EHCI enumeration and core retention issue
     http://permalink.gmane.org/gmane.linux.usb.general/66239

In V2:
    - covered review comments from linux omap and usb community
    - rebased on top Russ dill's patch
       'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue'
       fixes an issue where the ULPI PHYs were not held in reset
       while initializing the EHCI controller

Keshava Munegowda (5):
  ARM: OMAP: Add the USB TLL clocks device name
  ARM: OMAP: USB: HOST TLL platform driver
  ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
  ARM: OMAP: USB: Remove TLL specific code from USB HS core driver
  ARM: OMAP: Remove older device name of the USB TLL clocks

 arch/arm/mach-omap2/clock3xxx_data.c  |    8 +-
 arch/arm/mach-omap2/clock44xx_data.c  |    4 +-
 arch/arm/mach-omap2/usb-host.c        |   31 ++-
 arch/arm/plat-omap/include/plat/usb.h |    7 +
 drivers/mfd/Kconfig                   |    2 +-
 drivers/mfd/Makefile                  |    2 +-
 drivers/mfd/omap-usb-host.c           |  238 ++---------------
 drivers/mfd/omap-usb-tll.c            |  471 +++++++++++++++++++++++++++++++++
 8 files changed, 523 insertions(+), 240 deletions(-)
 create mode 100644 drivers/mfd/omap-usb-tll.c

-- 
1.7.9.5

