From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/14] dspbridge: rewrite deh
Date: Sun, 16 May 2010 18:45:51 +0300
Message-ID: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab0EPPqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:10 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

Investigating the MMU fault corruption issue I found a lot of areas of
improvements of the exception handling code.

Moreover, even though the obvious memory corruption is fixed on kernel side,
there are still some rare cases where corruption in user-space might be
possible if some buffers are still mapped. This came up in a discussion with
Fernando Lugo, and we both agreed on a fix (patch #7).

The rest is mostly reorganization.

These apply on top of the MMU fault fix patch.

Felipe Contreras (14):
  dspbridge: deh: refactor into wait_for_timer()
  dspbridge: deh: trivial cleanups
  dspbridge: mmufault: trivial cleanups
  dspbridge: deh: free dummy page immediately
  dspbridge: remove unused code
  dspbridge: mmu: add hw_mmu_tlb_flush_all()
  dspbridge: deh: ensure only tlb #0 is enabled
  dspbridge: deh: refactor in mmu_fault_print_stack()
  dspbridge: deh: remove get_info
  dspbridge: deh: remove err_info
  dspbridge: access deh directly
  dspbridge: move mmufault to deh
  dspbridge: deh: tidying up
  dspbridge: deh: update copyright notice

 arch/arm/plat-omap/include/dspbridge/dbdefs.h  |    1 -
 arch/arm/plat-omap/include/dspbridge/dspdefs.h |   75 -----
 arch/arm/plat-omap/include/dspbridge/dspdeh.h  |   20 +-
 drivers/dsp/bridge/Makefile                    |    2 +-
 drivers/dsp/bridge/core/_deh.h                 |    2 +-
 drivers/dsp/bridge/core/_tiomap.h              |    6 +-
 drivers/dsp/bridge/core/mmu_fault.c            |  141 --------
 drivers/dsp/bridge/core/mmu_fault.h            |   36 --
 drivers/dsp/bridge/core/tiomap3430.c           |   17 +-
 drivers/dsp/bridge/core/ue_deh.c               |  407 +++++++++++-------------
 drivers/dsp/bridge/hw/hw_mmu.c                 |    6 +
 drivers/dsp/bridge/hw/hw_mmu.h                 |    2 +
 drivers/dsp/bridge/pmgr/dev.c                  |   17 +-
 drivers/dsp/bridge/rmgr/node.c                 |    5 +-
 drivers/dsp/bridge/rmgr/proc.c                 |   29 +--
 15 files changed, 215 insertions(+), 551 deletions(-)
 delete mode 100644 drivers/dsp/bridge/core/mmu_fault.c
 delete mode 100644 drivers/dsp/bridge/core/mmu_fault.h

