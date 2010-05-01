From: Ivan Gomez Castellanos <ivan.gomez@ti.com>
Subject: [PATCH 00/11] DSPBRIDGE: Remove code and comments refering to other OS
Date: Fri, 30 Apr 2010 19:45:40 -0500
Message-ID: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56919 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672Ab0EAAwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 20:52:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, Ivan Gomez Castellanos <ivan.gomez@ti.com>

As this code is generic to Linux, this patch series replaces code
and comments thar refers to other OS.

Ivan Gomez Castellanos (10):
  DSPBRIDGE: Rename wmd_dev_context structure by bridge_dev_context
  DSPBRIDGE: Rename the device context handle variables
  DSPBRIDGE: Rename variables and structures which contain "wmd"
  DSPBRIDGE: Rename functions which contain "wmd" and remove unused
    prototypes
  DSPBRIDGE: Replace code containing "WMD"
  DSPBRIDGE: Replace code containing "wcd"
  DSPBRIDGE: Rename "wmd" directory by "core"
  DSPBRIDGE: Rename files that refer to Windows OS
  DSPBRIDGE: Append the content of _dcd.h into dspapi.h
  DSPBRIDGE: Rename header file guard macros that cointain WMD or WCD

Omar Ramirez Luna (1):
  DSPBRIDGE: Remove OS specific comments

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |    4 +-
 arch/arm/plat-omap/include/dspbridge/cfg.h         |   23 ---
 arch/arm/plat-omap/include/dspbridge/dev.h         |   49 +++---
 arch/arm/plat-omap/include/dspbridge/devdefs.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/drvdefs.h     |    2 +-
 .../dspbridge/{wcdioctl.h => dspapi-ioctl.h}       |    8 +-
 .../include/dspbridge/{_dcd.h => dspapi.h}         |   61 ++++---
 .../include/dspbridge/{wmdchnl.h => dspchnl.h}     |   10 +-
 .../include/dspbridge/{wmd.h => dspdefs.h}         |   50 +++---
 .../include/dspbridge/{wmddeh.h => dspdeh.h}       |   10 +-
 .../include/dspbridge/{wmdio.h => dspio.h}         |   10 +-
 .../include/dspbridge/{wmdioctl.h => dspioctl.h}   |   48 +++---
 .../include/dspbridge/{wmdmsg.h => dspmsg.h}       |   10 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h     |   12 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h       |   16 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h         |    2 +-
 arch/arm/plat-omap/include/dspbridge/wcd.h         |   36 ----
 drivers/dsp/bridge/Makefile                        |   12 +-
 drivers/dsp/bridge/{wmd => core}/_cmm.h            |    0
 drivers/dsp/bridge/{wmd => core}/_deh.h            |    5 +-
 drivers/dsp/bridge/{wmd => core}/_msg_sm.h         |    0
 drivers/dsp/bridge/{wmd => core}/_tiomap.h         |   18 +--
 drivers/dsp/bridge/{wmd => core}/_tiomap_mmu.h     |    2 +-
 drivers/dsp/bridge/{wmd => core}/_tiomap_pwr.h     |   26 ++--
 drivers/dsp/bridge/{wmd => core}/_tiomap_util.h    |    2 +-
 drivers/dsp/bridge/{wmd => core}/chnl_sm.c         |   14 +-
 drivers/dsp/bridge/{wmd => core}/io_sm.c           |  164 +++++++++---------
 drivers/dsp/bridge/{wmd => core}/mmu_fault.c       |   10 +-
 drivers/dsp/bridge/{wmd => core}/mmu_fault.h       |    0
 drivers/dsp/bridge/{wmd => core}/msg_sm.c          |    2 +-
 drivers/dsp/bridge/{wmd => core}/tiomap3430.c      |  185 ++++++++++----------
 drivers/dsp/bridge/{wmd => core}/tiomap3430_pwr.c  |   25 ++--
 drivers/dsp/bridge/{wmd => core}/tiomap_io.c       |   10 +-
 drivers/dsp/bridge/{wmd => core}/tiomap_io.h       |   12 +-
 drivers/dsp/bridge/{wmd => core}/ue_deh.c          |   22 ++--
 drivers/dsp/bridge/{wmd => core}/wdt.c             |    2 +-
 drivers/dsp/bridge/pmgr/chnlobj.h                  |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                      |   90 +++++-----
 drivers/dsp/bridge/pmgr/{wcd.c => dspapi.c}        |   64 ++++----
 drivers/dsp/bridge/pmgr/ioobj.h                    |    5 +-
 drivers/dsp/bridge/pmgr/msg.c                      |    2 +-
 drivers/dsp/bridge/pmgr/msgobj.h                   |    2 +-
 drivers/dsp/bridge/rmgr/disp.c                     |    2 +-
 drivers/dsp/bridge/rmgr/drv.c                      |    6 +-
 drivers/dsp/bridge/rmgr/drv_interface.c            |    6 +-
 drivers/dsp/bridge/rmgr/dspdrv.c                   |   16 +-
 drivers/dsp/bridge/rmgr/node.c                     |   25 ++--
 drivers/dsp/bridge/rmgr/proc.c                     |   50 +++---
 drivers/dsp/bridge/rmgr/pwr.c                      |   36 ++--
 drivers/dsp/bridge/rmgr/strm.c                     |    2 +-
 50 files changed, 565 insertions(+), 607 deletions(-)
 rename arch/arm/plat-omap/include/dspbridge/{wcdioctl.h => dspapi-ioctl.h} (99%)
 rename arch/arm/plat-omap/include/dspbridge/{_dcd.h => dspapi.h} (78%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdchnl.h => dspchnl.h} (94%)
 rename arch/arm/plat-omap/include/dspbridge/{wmd.h => dspdefs.h} (96%)
 rename arch/arm/plat-omap/include/dspbridge/{wmddeh.h => dspdeh.h} (94%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdio.h => dspio.h} (91%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdioctl.h => dspioctl.h} (54%)
 rename arch/arm/plat-omap/include/dspbridge/{wmdmsg.h => dspmsg.h} (93%)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/wcd.h
 rename drivers/dsp/bridge/{wmd => core}/_cmm.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_deh.h (89%)
 rename drivers/dsp/bridge/{wmd => core}/_msg_sm.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap.h (95%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_mmu.h (94%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_pwr.h (70%)
 rename drivers/dsp/bridge/{wmd => core}/_tiomap_util.h (94%)
 rename drivers/dsp/bridge/{wmd => core}/chnl_sm.c (99%)
 rename drivers/dsp/bridge/{wmd => core}/io_sm.c (92%)
 rename drivers/dsp/bridge/{wmd => core}/mmu_fault.c (93%)
 rename drivers/dsp/bridge/{wmd => core}/mmu_fault.h (100%)
 rename drivers/dsp/bridge/{wmd => core}/msg_sm.c (99%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap3430.c (91%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap3430_pwr.c (96%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap_io.c (97%)
 rename drivers/dsp/bridge/{wmd => core}/tiomap_io.h (88%)
 rename drivers/dsp/bridge/{wmd => core}/ue_deh.c (95%)
 rename drivers/dsp/bridge/{wmd => core}/wdt.c (99%)
 rename drivers/dsp/bridge/pmgr/{wcd.c => dspapi.c} (97%)

