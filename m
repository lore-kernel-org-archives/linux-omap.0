From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] dspbridge: miscellaneous fixes and cleanups
Date: Sun, 16 May 2010 18:44:58 +0300
Message-ID: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:52300 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0EPPpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:45:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359655fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:45:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

A few trivial patches. The important one is the fix to build when MCBSP is
disabled.

Felipe Contreras (4):
  dspbridge: fix build when OMAP_MCBSP=n
  dspbridge: dev: fix dev_create_device()
  dspbridge: remove _tiomap_mmu.h
  dspbridge: remove _tiomap_util.h

 drivers/dsp/bridge/core/_tiomap_mmu.h    |   41 --------------
 drivers/dsp/bridge/core/_tiomap_util.h   |   43 --------------
 drivers/dsp/bridge/core/dsp-clock.c      |    6 ++
 drivers/dsp/bridge/core/mmu_fault.c      |    1 -
 drivers/dsp/bridge/core/tiomap3430.c     |   89 ++++++++++--------------------
 drivers/dsp/bridge/core/tiomap3430_pwr.c |    3 +-
 drivers/dsp/bridge/core/ue_deh.c         |    1 -
 drivers/dsp/bridge/pmgr/dev.c            |   22 ++++---
 8 files changed, 49 insertions(+), 157 deletions(-)
 delete mode 100644 drivers/dsp/bridge/core/_tiomap_mmu.h
 delete mode 100644 drivers/dsp/bridge/core/_tiomap_util.h

