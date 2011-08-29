From: <hvaibhav@ti.com>
Subject: [RFC PATCH-V2 0/4] Introducing TI's New SoC/board AM335XEVM
Date: Mon, 29 Aug 2011 18:16:12 +0530
Message-ID: <1314621976-25750-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab1H2Mqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 08:46:31 -0400
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch set adds support for AM335x device having
Cortex-A8 MPU.

AM335X is treated as another OMAP3 variant, where,
along with existing cpu class OMAP34XX, new cpu class AM33XX is created
and the respective type is AM335X, which is newly added device in the family.
This means, cpu_is_omap34xx(), cpu_is_am33xx() and
cpu_is_am335x() checks return success for AM335X.

Currently submitting this patch series as a RFC (V2), to initiate the
discussion on the approach we have chosen for AM335x device support.
Based on the feedback, will submit the final version of patch series
immediately.

This patch series is created on top of linux-omap/master and
Hemant's TI814X patches submitted recently.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53457.html

Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.

Changes from V1:
  - Created separate cpu/SoC class for AM33XX family of devices,
    due to all known facts. This is been mentioned in main-chain

      https://patchwork.kernel.org/patch/1056312/

  - BUG Fix in debug-macro.S, which was leading to build failure.

      https://patchwork.kernel.org/patch/1056302/

Afzal Mohammed (4):
  AM335X: Update common omap platform files
  AM335X: Update common OMAP machine specific sources
  AM335X: Create board support and enable build for AM335XEVM
  AM335X: Add low level debugging support

 arch/arm/mach-omap2/Kconfig                    |   10 ++++
 arch/arm/mach-omap2/Makefile                   |    2 +
 arch/arm/mach-omap2/board-am335xevm.c          |   57 ++++++++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c           |    3 +
 arch/arm/mach-omap2/common.c                   |   16 +++++++
 arch/arm/mach-omap2/id.c                       |    6 +++
 arch/arm/mach-omap2/include/mach/debug-macro.S |   22 +++++++++
 arch/arm/mach-omap2/io.c                       |   25 ++++++++++
 arch/arm/plat-omap/include/plat/am33xx.h       |   25 ++++++++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    1 +
 arch/arm/plat-omap/include/plat/common.h       |    1 +
 arch/arm/plat-omap/include/plat/cpu.h          |   23 ++++++++++
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/io.h           |   20 ++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h     |    2 +
 arch/arm/plat-omap/include/plat/serial.h       |    4 ++
 arch/arm/plat-omap/include/plat/uncompress.h   |    6 +++
 arch/arm/plat-omap/io.c                        |    3 +
 19 files changed, 228 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am335xevm.c
 create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h

