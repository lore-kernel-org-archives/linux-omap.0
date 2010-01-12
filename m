From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCHv2 0/4] Regulator: OMAP: Removing common code for TWL4030 from OMAP3- board-evms
Date: Tue, 12 Jan 2010 14:43:45 +0530
Message-ID: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab0ALJN4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 04:13:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Sending version 2 of this patch set after taking all those comments. First
series can be found at:
  http://marc.info/?l=linux-omap&m=126297346131188&w=2

This patch set is created to clean up various OMAP3-board-evm files
and remove common TWL4030 specific regulator suplies and init data
structs. These structures are instead placed in a new generic file -
twl4030-pmic.c - and are referenced from the OMAP3 board-evm
files depending on the platform requirements. Regulator having specific
supplies or init data structs are not changed in their respective
board-evms.

The main advantages of having one common file for these structures
are redundant code removal, easy maintainability and single copy of 
common structure(s) in case uImage for multiple platforms is built.

Anuj Aggarwal (4):
  Regulator: OMAP: Creating TWL4030 file having supplies & init data
  Regulator: OMAP:Modifying Kconfig/Makefile to choose from available
    PMICs
  Regulator: OMAP: Kconfig modified to select TWL4030 for
    OMAP3-platforms
  Regulator: OMAP: Use common regulator supplies and init data structs

 arch/arm/mach-omap2/Kconfig                  |   20 +++
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-3430sdp.c          |  135 ++------------------
 arch/arm/mach-omap2/board-cm-t35.c           |   47 +------
 arch/arm/mach-omap2/board-igep0020.c         |   24 +---
 arch/arm/mach-omap2/board-ldp.c              |   24 +---
 arch/arm/mach-omap2/board-omap3beagle.c      |   47 +------
 arch/arm/mach-omap2/board-omap3evm.c         |   47 +------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   47 +------
 arch/arm/mach-omap2/board-overo.c            |   23 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   71 +----------
 arch/arm/mach-omap2/twl4030-pmic.c           |  175 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl4030-pmic.h           |   34 +++++
 13 files changed, 277 insertions(+), 418 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 create mode 100644 arch/arm/mach-omap2/twl4030-pmic.c
 create mode 100644 arch/arm/mach-omap2/twl4030-pmic.h

