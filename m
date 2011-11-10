From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Thu, 10 Nov 2011 23:10:34 +0530
Message-ID: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38733 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab1KJRlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 12:41:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch set adds support for AM335x device having
Cortex-A8 MPU.

Official website - http://www.ti.com/product/am3359

AM335X is treated as another OMAP3 variant, where,
along with existing cpu class OMAP34XX, new cpu class AM33XX is created
and the respective type is AM335X, which is newly added device in
the family.
This means, cpu_is_omap34xx(), cpu_is_am33xx() and
cpu_is_am335x() checks return success for AM335X.

Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.


Changes from V3:
	- Common platform patch has already been accepted and available
	  under linux-omap/soc and linux-omap/master branch.
	- Clean-up where cpu_is_xxxx instances are being used and patches
	  has been submitted to the list.
	- These patches have been created on top of cleanup patches -
		http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58276.html
		http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58277.html
	- Based on Tony's request, rebased patches against linux-omap/fixes
	  (+ common platform patch).

Changes from V2(RFC):
	- Rebased against Paul's OMAP_CHIP* cleanup patches
		git://git.pwsan.com/linux-2.6_omap_chip_remove_cleanup_3.2

Changes from V1(RFC):
	- Created separate cpu/SoC class for AM33XX family of devices,
	  due to all known facts. This is been mentioned in main-chain
		https://patchwork.kernel.org/patch/1056312/
	- BUG Fix in debug-macro.S, which was leading to build failure.
		 https://patchwork.kernel.org/patch/1056302/

Afzal Mohammed (3):
  arm:omap:am33xx: Update common OMAP machine specific sources
  arm:omap:am33xx: Add AM335XEVM machine support
  arm:omap:am33xx: Add low level debugging support

 arch/arm/mach-omap2/Kconfig                    |    5 ++++
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-am3517evm.c          |   21 ++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c           |    3 ++
 arch/arm/mach-omap2/common.c                   |   21 ++++++++++++++++
 arch/arm/mach-omap2/id.c                       |    6 ++++
 arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++-
 arch/arm/mach-omap2/io.c                       |   31 ++++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c                   |    4 +-
 arch/arm/mach-omap2/timer.c                    |    2 +
 arch/arm/plat-omap/include/plat/am33xx.h       |   25 +++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h       |    4 +++
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/io.h           |   20 +++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h     |    2 +
 arch/arm/plat-omap/include/plat/serial.h       |    4 +++
 arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++
 arch/arm/plat-omap/io.c                        |    5 ++++
 18 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h

