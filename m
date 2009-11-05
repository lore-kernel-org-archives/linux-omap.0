From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/5] Regulator: Moving regulator f/w code from board-evm to
Date: Thu,  5 Nov 2009 22:08:59 +0530
Message-ID: <1257439139-27223-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47246 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757155AbZKEQjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

This patch set cleans the board-omap3evm.c file by moving the regulator f/w
specific code to board-omap35x-pmic.c. This newly created file will have
board-specific information for OMAP3/AM3517 EVMs and TI PMICs like TWL4030/
TPS65950, TPS65023, TPS65073 etc. Since we are going to have so many possible
combinations like OMAP3 + TWL4030, OMAP3 + TPS65023, AM3517 + TPS65023, the
new PMIC specific file is created.

Supply names used for TWL4030 are simplified and directly related to the
consumers, MMC driver is modified to reflect this. Other consumer drivers
need to be modified to acccomodate this change.

Anuj Aggarwal (5):
  Regulator: Removing regulator f/w related code from board-omap3evm.c
  Regulator: Creating regulator hookup file for OMAP3 platforms
  Regulator: Changing Kconfig / Makefile for OMAP3 PMIC file
  Regulator: Adding OMAP3EVM/TWL4030 specific code in
    board-omap35x-pmic.c
  Regulator: Renaming the supplies used in MMC driver

 arch/arm/mach-omap2/Kconfig              |    8 ++
 arch/arm/mach-omap2/Makefile             |    3 +-
 arch/arm/mach-omap2/board-omap35x-pmic.c |  148 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c     |   55 ++---------
 arch/arm/mach-omap2/mmc-twl4030.c        |    6 +-
 5 files changed, 170 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.c

