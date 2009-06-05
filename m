From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/8] implement omap_hwmod core, plus HSMMC example
Date: Fri, 05 Jun 2009 04:19:20 -0600
Message-ID: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47666 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZFEKUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

This patch series implements the first public version of the
omap_hwmod hardware module layer.  It manages on-chip hardware IP
blocks, and provides a means for defining their integration
properties to the rest of the chip.  Some of the major goals here
are to collect all IP block integration data into one place, and
to put devices in a known state at boot.

As an exemplar, this series also implements the basic omap_hwmod
structures for HSMMC1/2/3 on OMAP2430 and OMAP34xx.

The omap_hwmod code is initially intended for use with OMAP2+
chips.  The goal is to auto-generate these structures for OMAP4
from a TI hardware database export.  OMAP2/3 structures will
probably have to be filled in by hand.

The series starts with several prerequisite patches.  OMAP1 and OMAP2
MMC core initialization code is split from plat-omap/devices.c into
mach-omap1/devices.c and mach-omap2/devices.c.  Several clock
framework fixes are also required.  Finally the omap_hwmod code
and header file are created; they are integrated with the system boot
process, and then the MMC example files are added.

More detailed descriptions are found in each individual patch
description.

Boot-tested on OMAP3 Beagle and 3430SDP.  Compile-tested on 2430SDP and
N800.

Comments welcome and solicited.


- Paul

---

   text    data     bss     dec     hex filename
3411061  192960  104048 3708069  3894a5 vmlinux.omap3beagle.old
3417637  194016  104080 3715733  38b295 vmlinux.omap3beagle

Paul Walmsley (8):
      OMAP2430/34xx HSMMC: add basic omap_hwmod entries for OMAP2430/34xx
      OMAP: omap_hwmod: call omap_hwmod initialization at boot
      OMAP2/3/4: create omap_hwmod layer
      OMAP2/3/4 PRCM: add module IDLEST wait code
      OMAP clock: associate MPU clocks with the mpu_clkdm
      OMAP2/3 clock: ensure each clock has a unique name
      OMAP clock: add omap_clk_get_by_name()
      OMAP2/3 board-*.c files: read bootloader configuration earlier


 arch/arm/mach-omap2/Makefile                 |    9 
 arch/arm/mach-omap2/board-2430sdp.c          |   19 
 arch/arm/mach-omap2/board-3430sdp.c          |   20 
 arch/arm/mach-omap2/board-apollon.c          |   20 
 arch/arm/mach-omap2/board-generic.c          |   14 
 arch/arm/mach-omap2/board-h4.c               |   20 
 arch/arm/mach-omap2/board-ldp.c              |   20 
 arch/arm/mach-omap2/board-omap2evm.c         |   20 
 arch/arm/mach-omap2/board-omap3beagle.c      |   24 
 arch/arm/mach-omap2/board-omap3evm.c         |   14 
 arch/arm/mach-omap2/board-omap3pandora.c     |   18 
 arch/arm/mach-omap2/board-overo.c            |   18 
 arch/arm/mach-omap2/board-rx51.c             |    4 
 arch/arm/mach-omap2/board-zoom2.c            |   18 
 arch/arm/mach-omap2/clock24xx.h              |   52 -
 arch/arm/mach-omap2/clock34xx.h              |   61 +
 arch/arm/mach-omap2/cm.c                     |   70 +
 arch/arm/mach-omap2/cm.h                     |    4 
 arch/arm/mach-omap2/cm4xxx.c                 |   68 +
 arch/arm/mach-omap2/io.c                     |   19 
 arch/arm/mach-omap2/omap_hwmod.c             | 1522 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420.h        |  140 ++
 arch/arm/mach-omap2/omap_hwmod_2430.h        |  285 +++++
 arch/arm/mach-omap2/omap_hwmod_34xx.h        |  399 +++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h       |    8 
 arch/arm/mach-omap2/serial.c                 |    6 
 arch/arm/plat-omap/clock.c                   |   27 
 arch/arm/plat-omap/include/mach/clock.h      |    1 
 arch/arm/plat-omap/include/mach/l4_3xxx.h    |   24 
 arch/arm/plat-omap/include/mach/mmc.h        |    8 
 arch/arm/plat-omap/include/mach/omap_hwmod.h |  436 +++++++
 arch/arm/plat-omap/include/mach/serial.h     |    6 
 32 files changed, 3197 insertions(+), 177 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2420.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2430.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/plat-omap/include/mach/l4_3xxx.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap_hwmod.h

