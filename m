From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] dspbridge: improve Kconfig
Date: Sun, 16 May 2010 18:46:56 +0300
Message-ID: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53342 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab0EPPrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:08 -0400
Received: by fxm6 with SMTP id 6so2978216fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

The current Kconfig really needed some attention. I have tried to standarize
everything to CONFIG_OMAP_DSP, unfortunately, it seems the dspgateway was using
that. Since that was never mainlined, I removed the dead code that was relying
on it (should move to the dspgateway branch). Besides nowadays dspbridge seems
to be the more likely to be reach mainline.

Also, make some code only useful for debugging or testing configurable.

 1) in production, DEBUG=n BACKTRACE=n
 2) in internal testing, DEBUG=n BACKTRACE=y
 3) in development debugging, DEBUG=y BACKTRACE=y

These apply on top of the deh reorganization patches.

Felipe Contreras (5):
  omap: OMAP_DSP is not in mainline, remove it
  dspbridge: rename BRIDGE to OMAP_DSP
  dspbridge: improve Kconfig
  dspbridge: use CONFIG_OMAP_DSP_DEBUG for debug trace
  dspbridge: add CONFIG_OMAP_DSP_BACKTRACE

 arch/arm/mach-omap2/Makefile                    |    2 +-
 arch/arm/mach-omap2/dspbridge.c                 |    6 +-
 arch/arm/mach-omap2/omap3-iommu.c               |    2 +-
 arch/arm/plat-omap/devices.c                    |   66 +----------------------
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbc.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbll.h     |    2 +
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/gh.h       |    2 +
 arch/arm/plat-omap/include/dspbridge/host_os.h  |    6 +--
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    6 ++-
 arch/arm/plat-omap/include/dspbridge/nldr.h     |    2 +
 arch/arm/plat-omap/include/dspbridge/node.h     |    2 +
 drivers/Makefile                                |    2 +-
 drivers/dsp/bridge/Kconfig                      |   62 +++++++++++----------
 drivers/dsp/bridge/Makefile                     |    2 +-
 drivers/dsp/bridge/core/io_sm.c                 |   30 ++++++-----
 drivers/dsp/bridge/core/tiomap3430_pwr.c        |   30 +++++-----
 drivers/dsp/bridge/core/tiomap_io.c             |    4 +-
 drivers/dsp/bridge/core/ue_deh.c                |   15 +++++-
 drivers/dsp/bridge/core/wdt.c                   |    7 +--
 drivers/dsp/bridge/gen/gh.c                     |    2 +
 drivers/dsp/bridge/pmgr/dbll.c                  |    2 +
 drivers/dsp/bridge/rmgr/drv.c                   |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |   30 +++++-----
 drivers/dsp/bridge/rmgr/nldr.c                  |    2 +
 drivers/dsp/bridge/rmgr/node.c                  |    9 ++--
 drivers/dsp/bridge/rmgr/proc.c                  |    8 ++--
 28 files changed, 139 insertions(+), 170 deletions(-)

