From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] omap_device implementation, and HSMMC example
Date: Fri, 05 Jun 2009 04:30:37 -0600
Message-ID: <20090605102716.13544.65328.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39494 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbZFEKbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:31:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

This patch series implements the first public version of the
omap_device code.  The basic point of this code is to extend the
platform_device code with some features that are suited to OMAP code.
Most of these features concern device initialization, resource enumeration,
and power management.  

The series consists of the core code and data structures, along
with an example HSMMC conversion for OMAP2430 and OMAP34xx.

The omap_device code is initially intended for use with OMAP2+
chips.  It depends on the omap_hwmod patch series posted earlier -- each 
omap_device structure is connected to one or more omap_hwmod structures.

A slightly different approach is perhaps best in the long run;
either to extend platform_device with subarchitecture-specific
hooks to call these functions perhaps along the lines of Magnus
Damm's recent proposal, or to replace platform_device/platform_bus with 
an omap_device/omap_bus layer.

More detailed descriptions are found in each individual patch
description.

Boot-tested on OMAP3 Beagle and 3430SDP.  Compile-tested on 2430SDP and
N800.  The code has only been lightly tested, so there are likely to be
bugs -- patches and other feedback are welcome and solicited.


- Paul

---

omap_device
   text    data     bss     dec     hex filename
3417637  194016  104080 3715733  38b295 vmlinux.omap3beagle.orig
3420233  194016  104080 3718329  38bcb9 vmlinux.omap3beagle

Paul Walmsley (3):
      OMAP2/3 MMC: initial conversion to omap_device
      OMAP: MMC (core): split device registration by OMAP variant
      OMAP2/3/4 core: create omap_device layer


 arch/arm/mach-omap1/devices.c                 |   41 ++
 arch/arm/mach-omap2/devices.c                 |  104 +++-
 arch/arm/mach-omap2/mmc-twl4030.c             |   12 
 arch/arm/plat-omap/Makefile                   |    6 
 arch/arm/plat-omap/devices.c                  |   50 --
 arch/arm/plat-omap/include/mach/mmc.h         |   11 
 arch/arm/plat-omap/include/mach/omap_device.h |  140 +++++
 arch/arm/plat-omap/omap_device.c              |  654 +++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c                 |   99 ++--
 9 files changed, 974 insertions(+), 143 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/omap_device.h
 create mode 100644 arch/arm/plat-omap/omap_device.c

