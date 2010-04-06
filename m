From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/3] DSPBRIDGE: Cleanup hw directory and module parameter
Date: Tue, 6 Apr 2010 12:52:01 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CAF98C62@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0DFRwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:52:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 4fb9fc015cea65dcd47172a8b180f380fe86be46 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 30 Mar 2010 22:03:27 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup hw directory and module parameter

This patches does a clenaup of unused module paremeters and
also a clenaup in hw directory.

Fernando Guzman Lugo (3):
  DSPBRIDGE: remove unused module parameters
  DSPBRIDGE: remove HW_DSPSS_BootModeSet function
  DSPBRIDGE: remove hw_prcm module and related functions

 arch/arm/mach-omap2/dspbridge.c                |    9 +-
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    2 -
 arch/arm/plat-omap/include/dspbridge/host_os.h |    8 +
 drivers/dsp/bridge/Makefile                    |    2 +-
 drivers/dsp/bridge/hw/IPIAccInt.h              |   26 -
 drivers/dsp/bridge/hw/IVA2RegAcM.h             |   26 -
 drivers/dsp/bridge/hw/PRCMAccInt.h             |  303 ------------
 drivers/dsp/bridge/hw/PRCMRegAcM.h             |  615 ------------------------
 drivers/dsp/bridge/hw/hw_dspssC64P.c           |   47 --
 drivers/dsp/bridge/hw/hw_dspssC64P.h           |   37 --
 drivers/dsp/bridge/hw/hw_prcm.c                |  161 ------
 drivers/dsp/bridge/hw/hw_prcm.h                |  156 ------
 drivers/dsp/bridge/rmgr/drv.c                  |   14 -
 drivers/dsp/bridge/rmgr/drv_interface.c        |   24 +-
 drivers/dsp/bridge/wmd/_tiomap.h               |    4 +
 drivers/dsp/bridge/wmd/tiomap3430.c            |  176 +++-----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   57 +--
 drivers/dsp/bridge/wmd/tiomap_io.c             |   15 +-
 18 files changed, 116 insertions(+), 1566 deletions(-)
 delete mode 100644 drivers/dsp/bridge/hw/IPIAccInt.h
 delete mode 100644 drivers/dsp/bridge/hw/IVA2RegAcM.h
 delete mode 100644 drivers/dsp/bridge/hw/PRCMAccInt.h
 delete mode 100644 drivers/dsp/bridge/hw/PRCMRegAcM.h
 delete mode 100644 drivers/dsp/bridge/hw/hw_dspssC64P.c
 delete mode 100644 drivers/dsp/bridge/hw/hw_dspssC64P.h
 delete mode 100644 drivers/dsp/bridge/hw/hw_prcm.c
 delete mode 100644 drivers/dsp/bridge/hw/hw_prcm.h
