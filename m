From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: trivial cleanup for enums
Date: Fri, 22 Jan 2010 22:44:28 -0600
Message-ID: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624Ab0AWEeH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 23:34:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove unused enums and replace unrelated enum constants with
defines.

Shivananda Hebbar (2):
  DSPBRIDGE: Remove un-used enums
  DSPBRIDGE: Remove enum definitions and replace with macros

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   11 +++++------
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h  |   18 ++----------------
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   10 +++-------
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    5 ++---
 drivers/dsp/bridge/hw/IPIAccInt.h               |   15 ---------------
 drivers/dsp/bridge/hw/hw_defs.h                 |    8 +++-----
 drivers/dsp/bridge/hw/hw_mmu.c                  |    3 +--
 drivers/dsp/bridge/hw/hw_mmu.h                  |    3 +--
 drivers/dsp/bridge/hw/hw_prcm.c                 |    6 ++----
 drivers/dsp/bridge/pmgr/cmm.c                   |    5 ++---
 drivers/dsp/bridge/wmd/_tiomap.h                |   23 ++---------------------
 drivers/dsp/bridge/wmd/io_sm.c                  |    3 +--
 13 files changed, 25 insertions(+), 87 deletions(-)

