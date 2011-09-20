From: Deepthy Ravi <deepthy.ravi@ti.com>
Subject: [PATCH 0/5] OMAP3EVM: Add support for MT9T111 sensor
Date: Tue, 20 Sep 2011 20:26:47 +0530
Message-ID: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, mchehab@infradead.org, tony@atomide.com, hvaibhav@ti.com, linux-media@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.i
Cc: linux-omap@vger.kernel.org, Deepthy Ravi <deepthy.ravi@ti.com>
List-Id: linux-omap@vger.kernel.org

This patchset
	-adds support for MT9T111 sensor on omap3evm.
	Currently the sensor driver supports only
	VGA resolution.
	-enables MT9T111 sensor in omap2plus_defconfig.

This is applied on top of the following patchset
http://www.spinics.net/lists/linux-media/msg37270.html 
which adds YUYV input support for OMAP3ISP.
---

Deepthy Ravi (2):
  ispccdc: Configure CCDC_SYN_MODE register for     UYVY8_2X8 and
    YUYV8_2X8 formats
  omap2plus_defconfig: Enable omap3isp and MT9T111     sensor drivers

Vaibhav Hiremath (3):
  omap3evm: Enable regulators for camera interface
  [media] v4l: Add mt9t111 sensor driver
  omap3evm: Add Camera board init/hookup file

 arch/arm/configs/omap2plus_defconfig        |   10 +
 arch/arm/mach-omap2/Makefile                |    5 +
 arch/arm/mach-omap2/board-omap3evm-camera.c |  185 ++++
 arch/arm/mach-omap2/board-omap3evm.c        |   25 +
 drivers/media/video/Kconfig                 |    7 +
 drivers/media/video/Makefile                |    1 +
 drivers/media/video/mt9t111.c               |  793 ++++++++++++++++
 drivers/media/video/mt9t111_reg.h           | 1367 +++++++++++++++++++++++++++
 drivers/media/video/omap3isp/ispccdc.c      |   11 +-
 include/media/mt9t111.h                     |   45 +
 10 files changed, 2446 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3evm-camera.c
 create mode 100644 drivers/media/video/mt9t111.c
 create mode 100644 drivers/media/video/mt9t111_reg.h
 create mode 100644 include/media/mt9t111.h
