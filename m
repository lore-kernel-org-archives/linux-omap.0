From: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Subject: [PATCH 00/13] Remove mem.c and mem.h files
Date: Thu, 8 Apr 2010 18:42:00 -0500
Message-ID: <818EF96F5A7CC84789DD014773DB09548F6481C9@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43239 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933934Ab0DHXmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 19:42:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From a848b2a9b48c020a3928e8f334632662a2213b43 Mon Sep 17 00:00:00 2001
From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Date: Thu, 8 Apr 2010 17:52:59 -0500
Subject: [PATCH 00/13] Remove mem.c and mem.h files

The intend of these patches is to remove mem.c and mem.h files, since the
drivers/dsp/bridge/services directory is going to be eliminated.

A cleanup of dw_signature is also provided. Signature checking is not
necessary, it does not make any improvements to a pointer check.

Ivan Gomez Castellanos (13):
  DSPBRIDGE: Replace mem_calloc() by kzalloc() or __vmalloc()
  DSPBRIDGE: Replace mem_alloc() by kmalloc()
  DSPBRIDGE: Moving functions from mem.c to drv.c
  DSPBRIDGE: Moving macros from mem.h to drv.h
  DSPBRIDGE: Remove mem_init and mem_exit functions
  DSPBRIDGE: Replace MEM_ALLOC_OBJECT macro by kzalloc function
  DSPBRIDGE: Replace MEM_FREE_OBJECT macro by kfree function
  DSPBRIDGE: Check pointer instead of using MEM_IS_VALID_HANDLE macro
  DSPBRIDGE: Remove mem.c and mem.h files
  DSPBRIDGE: Remove CHNL_IS_VALID_MGR and CHNL_IS_VALID_CHNL
  DSPBRIDGE: Remove IS_VALID_HANDLE function and macro
  DSPBRIDGE: Remove dw_signature field from structures
  DSPBRIDGE: Remove signature definitions used for object validation

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 -
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    4 -
 arch/arm/plat-omap/include/dspbridge/drv.h      |  111 +++++++++
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 -
 arch/arm/plat-omap/include/dspbridge/mem.h      |  280 -----------------------
 arch/arm/plat-omap/include/dspbridge/memdefs.h  |    7 -
 arch/arm/plat-omap/include/dspbridge/msgdefs.h  |    2 -
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   29 ---
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    2 +-
 drivers/dsp/bridge/Makefile                     |    2 +-
 drivers/dsp/bridge/gen/gs.c                     |    6 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    7 +-
 drivers/dsp/bridge/pmgr/chnlobj.h               |    9 -
 drivers/dsp/bridge/pmgr/cmm.c                   |   65 ++---
 drivers/dsp/bridge/pmgr/cod.c                   |    5 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |   95 ++++-----
 drivers/dsp/bridge/pmgr/dev.c                   |   92 +++-----
 drivers/dsp/bridge/pmgr/dmm.c                   |   18 +-
 drivers/dsp/bridge/pmgr/io.c                    |    1 -
 drivers/dsp/bridge/pmgr/ioobj.h                 |    1 -
 drivers/dsp/bridge/pmgr/msg.c                   |    5 +-
 drivers/dsp/bridge/pmgr/msgobj.h                |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |   29 ++--
 drivers/dsp/bridge/rmgr/dbdcd.c                 |   46 ++--
 drivers/dsp/bridge/rmgr/disp.c                  |   27 +--
 drivers/dsp/bridge/rmgr/drv.c                   |  199 ++++++++++++++---
 drivers/dsp/bridge/rmgr/drv_interface.c         |    2 +-
 drivers/dsp/bridge/rmgr/dspdrv.c                |    1 -
 drivers/dsp/bridge/rmgr/mgr.c                   |   25 +--
 drivers/dsp/bridge/rmgr/nldr.c                  |   75 +++----
 drivers/dsp/bridge/rmgr/node.c                  |  149 ++++++-------
 drivers/dsp/bridge/rmgr/proc.c                  |   70 +++---
 drivers/dsp/bridge/rmgr/rmm.c                   |   36 ++--
 drivers/dsp/bridge/rmgr/strm.c                  |   50 ++---
 drivers/dsp/bridge/services/clk.c               |    3 -
 drivers/dsp/bridge/services/mem.c               |  270 ----------------------
 drivers/dsp/bridge/services/reg.c               |    3 -
 drivers/dsp/bridge/services/regsup.c            |    9 +-
 drivers/dsp/bridge/services/services.c          |   11 +-
 drivers/dsp/bridge/wmd/_deh.h                   |    3 -
 drivers/dsp/bridge/wmd/_msg_sm.h                |    4 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |   55 ++---
 drivers/dsp/bridge/wmd/io_sm.c                  |   41 ++--
 drivers/dsp/bridge/wmd/mmu_fault.c              |    5 +-
 drivers/dsp/bridge/wmd/msg_sm.c                 |   56 ++---
 drivers/dsp/bridge/wmd/tiomap3430.c             |   10 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |    3 -
 drivers/dsp/bridge/wmd/tiomap_io.c              |    1 -
 drivers/dsp/bridge/wmd/ue_deh.c                 |   17 +-
 49 files changed, 710 insertions(+), 1238 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/mem.h
 delete mode 100644 drivers/dsp/bridge/services/mem.c

