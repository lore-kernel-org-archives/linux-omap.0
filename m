From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 00/11] arm:omap:am33xx: Add basic voltage, power, clock & HWMOD data
Date: Sun, 20 Nov 2011 22:49:04 +0530
Message-ID: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37429 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab1KTRTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Nov 2011 12:19:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch series adds support for AM335X basic voltage, power,
clock and HWMOD data to existing OMAP framework.
Care has been taken while adding new API's to make sure that
we don't duplicate the code, and API's being added only
wherever required (where we didn't had any option).

The main purpose of this patch-series is to get early feedback &
review comments from list.

NOTE: Also please note that, most of the files are auto-generated
using HW data base and then modified based on latest kernel changes &
bug fixes.

For further information on AM33XX family of devices, please
refer to below links,

Official website -
http://www.ti.com/product/am3359

Link to Public TRM -
http://www.ti.com/lit/ug/spruh73a/spruh73a.pdf

This patch series has beed created on top of linux-omap/master +
AM33XX baseport patches submitted previously.
Link to AM335X Baseport patches -

http://www.spinics.net/lists/linux-omap/msg60088.html
http://www.spinics.net/lists/linux-omap/msg60087.html
http://www.spinics.net/lists/linux-omap/msg60090.html
http://www.spinics.net/lists/linux-omap/msg60089.html

Testing -
	- These patches has been tested on OMAP3EVM to make sure
	 nothing has been broken.
	- Patches has also been tested on AM335X EVM
	(with few additional patches).
	- All the patches can be accessible from,
http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=summary am335x-staging

Afzal Mohammed (6):
  arm:omap:am33xx: Add voltage domain data
  arm:omap:am33xx: Integrate voltage domain
  arm:omap:am33xx: Add power domain data
  arm:omap:am33xx: Integrate powerdomain to OMAP power framework
  arm:omap:am33xx: Add Clock & clockdomain data
  arm:omap:am33xx: Integrate clock & clockdomain to OMAP clock
    framework

Vaibhav Hiremath (5):
  arm:omap:am33xx: Add irq, dma and module base addr to SoC header
    files
  arm:omap:am33xx: Add HWMOD data
  arm:omap:am33xx: Integrate AM33XX hwmods to omap HWMOD framework
  ARM:omap:am33xx: Add clock control api's
  arm:omap:am33xx: Add am335x support in generic omap_hwmod

 arch/arm/mach-omap2/Makefile                  |    9 +
 arch/arm/mach-omap2/clock33xx.c               |   82 +
 arch/arm/mach-omap2/clock33xx.h               |   40 +
 arch/arm/mach-omap2/clock33xx_data.c          | 1936 +++++++++++++++++++
 arch/arm/mach-omap2/clock3xxx_data.c          |    5 +-
 arch/arm/mach-omap2/clockdomain.h             |    1 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c    |   18 +-
 arch/arm/mach-omap2/clockdomains33xx_data.c   |  223 +++
 arch/arm/mach-omap2/cm-regbits-33xx.h         |  683 +++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.c             |   34 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h             |    6 +
 arch/arm/mach-omap2/cm33xx.c                  |   51 +
 arch/arm/mach-omap2/cm33xx.h                  |  390 ++++
 arch/arm/mach-omap2/cminst33xx.c              |  311 ++++
 arch/arm/mach-omap2/cminst33xx.h              |   63 +
 arch/arm/mach-omap2/io.c                      |    5 +
 arch/arm/mach-omap2/omap_hwmod.c              |   42 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c    | 2474 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |    4 +-
 arch/arm/mach-omap2/powerdomain33xx.c         |  155 ++
 arch/arm/mach-omap2/powerdomains33xx_data.c   |  115 ++
 arch/arm/mach-omap2/prm-regbits-33xx.h        |  357 ++++
 arch/arm/mach-omap2/prm33xx.h                 |  123 ++
 arch/arm/mach-omap2/prminst33xx.c             |   74 +
 arch/arm/mach-omap2/prminst33xx.h             |   25 +
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   37 +
 arch/arm/plat-omap/include/plat/am33xx.h      |   40 +
 arch/arm/plat-omap/include/plat/dma-33xx.h    |   85 +
 arch/arm/plat-omap/include/plat/dma.h         |    1 +
 arch/arm/plat-omap/include/plat/irqs-33xx.h   |  143 ++
 arch/arm/plat-omap/include/plat/irqs.h        |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/include/plat/serial.h      |    5 +
 34 files changed, 7525 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock33xx.c
 create mode 100644 arch/arm/mach-omap2/clock33xx.h
 create mode 100644 arch/arm/mach-omap2/clock33xx_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/cm33xx.c
 create mode 100644 arch/arm/mach-omap2/cm33xx.h
 create mode 100644 arch/arm/mach-omap2/cminst33xx.c
 create mode 100644 arch/arm/mach-omap2/cminst33xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/prminst33xx.c
 create mode 100644 arch/arm/mach-omap2/prminst33xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/dma-33xx.h
 create mode 100644 arch/arm/plat-omap/include/plat/irqs-33xx.h

