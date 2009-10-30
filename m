From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 0/9] MIPI HSI device support for OMAP platforms
Date: Fri, 30 Oct 2009 10:59:59 +0100
Message-ID: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742AbZJ3J6z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 05:58:55 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9U9x0g8011273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 04:59:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>

This is an RFC for a series of patch to add the support of MIPI HSI and SSI
devices to OMAP platforms.
The patch includes the HSI device driver and the device files for MIPI HSI and
SSI.

The driver is made of 2 distinct modules:
 - omap_hsi: is the Low-Level Driver (or hardware driver). It provides a
   kernel functional interface, to be used by other kernel modules and
   abstracts the HW.
   This part of the patch is based on Nokia SSI driver, already submitted as
   RFC by Carlos Chinea [1].
 - hsi-char: is a char device driver proposing a user-space interface for
   using the HSI and relies on omap_hsi.
   This part of the patch is based on a development from Andras Domokos.
The intent is to propose a single HSI driver that can support MIPI HSI 1.1 as
well as previous implementations (SSI) for OMAP platforms (OMAP3 / OMAP4).

The driver core functionalities are there and ready for review. The following
updates will come in the following weeks / months:
 - Clocks and Power Management support for OMAP4 platform (HSI device file)
 - HSI-char interface documentation

Validation: The driver is validated on 3430 SDP (with a HW loopback on the SSI
device), and is being validated on 4430 Virtio platform (MIPI HSI device).

[1] http://lwn.net/Articles/301918/

Thanks for your comments!

Sebastien JAN

Sebastien Jan (9):
  HSI: Low Level Driver interface
  HSI: Low Level Driver core
  HSI: Low Level Driver device management
  HSI: Low Level Driver debugfs support
  HSI: Low Level Driver documentation
  HSI: character driver interface
  HSI: character driver low level interface
  HSI: HSI device support
  HSI: SSI device support and integration on 3430SDP platform

 Documentation/hsi/hsi.txt             |  319 ++++++++++++++++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c   |   12 +
 arch/arm/mach-omap2/hsi.c             |  497 +++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |   17 +
 arch/arm/mach-omap2/ssi.c             |  530 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/hsi.h |  432 ++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   10 +
 drivers/Kconfig                       |    2 +
 drivers/Makefile                      |    1 +
 drivers/hsi/Kconfig                   |   58 +++
 drivers/hsi/Makefile                  |   17 +
 drivers/hsi/hsi-char.c                |  526 ++++++++++++++++++++++++++
 drivers/hsi/hsi-char.h                |   31 ++
 drivers/hsi/hsi-if.c                  |  642 ++++++++++++++++++++++++++++++++
 drivers/hsi/hsi-if.h                  |   65 ++++
 drivers/hsi/hsi_driver.c              |  644 ++++++++++++++++++++++++++++++++
 drivers/hsi/hsi_driver.h              |  308 +++++++++++++++
 drivers/hsi/hsi_driver_bus.c          |  182 +++++++++
 drivers/hsi/hsi_driver_debugfs.c      |  486 ++++++++++++++++++++++++
 drivers/hsi/hsi_driver_dma.c          |  469 +++++++++++++++++++++++
 drivers/hsi/hsi_driver_fifo.c         |  289 +++++++++++++++
 drivers/hsi/hsi_driver_gpio.c         |   79 ++++
 drivers/hsi/hsi_driver_if.c           |  657 +++++++++++++++++++++++++++++++++
 drivers/hsi/hsi_driver_int.c          |  339 +++++++++++++++++
 include/linux/hsi_char.h              |   71 ++++
 include/linux/hsi_driver_if.h         |  180 +++++++++
 27 files changed, 6865 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hsi/hsi.txt
 create mode 100644 arch/arm/mach-omap2/hsi.c
 create mode 100644 arch/arm/mach-omap2/ssi.c
 create mode 100644 arch/arm/plat-omap/include/mach/hsi.h
 create mode 100644 drivers/hsi/Kconfig
 create mode 100644 drivers/hsi/Makefile
 create mode 100644 drivers/hsi/hsi-char.c
 create mode 100644 drivers/hsi/hsi-char.h
 create mode 100644 drivers/hsi/hsi-if.c
 create mode 100644 drivers/hsi/hsi-if.h
 create mode 100644 drivers/hsi/hsi_driver.c
 create mode 100644 drivers/hsi/hsi_driver.h
 create mode 100644 drivers/hsi/hsi_driver_bus.c
 create mode 100644 drivers/hsi/hsi_driver_debugfs.c
 create mode 100644 drivers/hsi/hsi_driver_dma.c
 create mode 100644 drivers/hsi/hsi_driver_fifo.c
 create mode 100644 drivers/hsi/hsi_driver_gpio.c
 create mode 100644 drivers/hsi/hsi_driver_if.c
 create mode 100644 drivers/hsi/hsi_driver_int.c
 create mode 100644 include/linux/hsi_char.h
 create mode 100644 include/linux/hsi_driver_if.h

