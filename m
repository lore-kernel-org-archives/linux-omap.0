From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/6] Regulator: Removing common code for TWL4030 PMIC from various OMAP3 board-evms
Date: Fri,  8 Jan 2010 23:27:28 +0530
Message-ID: <1262973448-32439-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0AHR5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:57:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Based on the discussions and feedback received, this patch set is
created which cleans up various OMAP3-board-evm files and removes
common TWL4030 specific regulator suuplies and init data structs.
These structures are instead placed in a new file - 
board-omap35x-twl4030-pmic.c and are referenced from the board-evm
files depending on the platform requirements. Regulator having specific
supplies or init data structs are not changed in their respective
board-evms.

The main advantages of having one common file for these structures
are redundant code removal, easy maintainability and single copy of 
common structure(s) in case uImage for multiple platforms is built.

Please see the following links for previous discussions:
  http://marc.info/?l=linux-omap&m=125795487111175&w=2
  http://marc.info/?l=linux-omap&m=125795068502904&w=2 

I have tested these patches on OMAP3EVM and the image boots fine. I
have compile-tested them for SDP3430 and all OMAP platforms (using
omap3_defconfig) and the build went fine. If someone can test them
on their hardware, that would be great !!!

Anuj Aggarwal (6):
  Regulator: Creating TWL4030 specific file having supplies & init data
  Regulator: Removing the common supplies and regulator init data
    structs
  Regulator: Use common regulator supplies and init data structs
  Regulator: Modifying Kconfig to choose from the available PMICs
  Regulator: Kconfig modified to select TWL4030 for OMAP3 based
    platforms
  Regulator: Makefile modified to include TWL4030-PMIC specific file

 arch/arm/mach-omap2/Kconfig                      |   20 +++
 arch/arm/mach-omap2/Makefile                     |    1 +
 arch/arm/mach-omap2/board-3430sdp.c              |  146 +++---------------
 arch/arm/mach-omap2/board-cm-t35.c               |   52 ++-----
 arch/arm/mach-omap2/board-igep0020.c             |   26 +---
 arch/arm/mach-omap2/board-ldp.c                  |   26 +---
 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c |  175 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c          |   52 ++-----
 arch/arm/mach-omap2/board-omap3evm.c             |   63 ++------
 arch/arm/mach-omap2/board-omap3pandora.c         |   52 ++-----
 arch/arm/mach-omap2/board-omap3touchbook.c       |   52 ++-----
 arch/arm/mach-omap2/board-overo.c                |   26 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c     |   78 ++--------
 13 files changed, 304 insertions(+), 465 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-twl4030-pmic.c

