From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/9] dspbridge cleanup patches
Date: Mon, 23 Nov 2009 18:50:21 -0600
Message-ID: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56907 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320AbZKXApI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Following patches are cleanups, removing history of files,
tab spacing and also remove DPC layer.

Omar Ramirez Luna (8):
  DSPBRIDGE: trivial checkpatch fixes
  DSPBRIDGE: Fix multiline macros to use do while
  DSPBRIDGE: Use _IOxx macro to define ioctls
  DSPBRIDGE: trivial cleanup and indentation for io_sm
  DSPBRIDGE: Remove DPC, create, destroy and schedule wrappers
  DSPBRIDGE: Remove main DPC wrapper for IO and MMUfault
  DSPBRIDGE: Remove DPC module from SERVICES layer
  DSPBRIDGE: Remove DPC object structure
  DSPBRIDGE: trivial file history cleanup

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |   47 +-
 arch/arm/plat-omap/include/dspbridge/_dcd.h        |   40 +-
 arch/arm/plat-omap/include/dspbridge/brddefs.h     |   20 +-
 arch/arm/plat-omap/include/dspbridge/cfg.h         |   50 +-
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h     |   27 +-
 arch/arm/plat-omap/include/dspbridge/chnl.h        |   45 +-
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h     |   30 +-
 arch/arm/plat-omap/include/dspbridge/chnldefs.h    |   26 +-
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h    |   33 +-
 arch/arm/plat-omap/include/dspbridge/clk.h         |   11 +-
 arch/arm/plat-omap/include/dspbridge/cmm.h         |   66 +-
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h     |   20 +-
 arch/arm/plat-omap/include/dspbridge/cod.h         |   58 +-
 arch/arm/plat-omap/include/dspbridge/dbc.h         |   40 +-
 arch/arm/plat-omap/include/dspbridge/dbdcd.h       |   26 +-
 arch/arm/plat-omap/include/dspbridge/dbdcddef.h    |   27 +-
 arch/arm/plat-omap/include/dspbridge/dbdefs.h      |   61 +-
 arch/arm/plat-omap/include/dspbridge/dbg.h         |   25 +-
 arch/arm/plat-omap/include/dspbridge/dbl.h         |   14 -
 arch/arm/plat-omap/include/dspbridge/dbldefs.h     |   12 -
 arch/arm/plat-omap/include/dspbridge/dbll.h        |   15 +-
 arch/arm/plat-omap/include/dspbridge/dblldefs.h    |   11 -
 arch/arm/plat-omap/include/dspbridge/dbtype.h      |   21 +-
 arch/arm/plat-omap/include/dspbridge/dehdefs.h     |   14 +-
 arch/arm/plat-omap/include/dspbridge/dev.h         |   64 +-
 arch/arm/plat-omap/include/dspbridge/devdefs.h     |   15 +-
 arch/arm/plat-omap/include/dspbridge/disp.h        |   31 +-
 arch/arm/plat-omap/include/dspbridge/dispdefs.h    |   14 +-
 arch/arm/plat-omap/include/dspbridge/dmm.h         |   18 +-
 arch/arm/plat-omap/include/dspbridge/dpc.h         |  167 ---
 arch/arm/plat-omap/include/dspbridge/drv.h         |   48 +-
 arch/arm/plat-omap/include/dspbridge/drvdefs.h     |   13 +-
 arch/arm/plat-omap/include/dspbridge/dspdrv.h      |   33 +-
 .../plat-omap/include/dspbridge/dynamic_loader.h   |    2 -
 arch/arm/plat-omap/include/dspbridge/errbase.h     |   37 +-
 arch/arm/plat-omap/include/dspbridge/gb.h          |   10 +-
 arch/arm/plat-omap/include/dspbridge/getsection.h  |   21 +-
 arch/arm/plat-omap/include/dspbridge/gh.h          |    8 -
 arch/arm/plat-omap/include/dspbridge/gs.h          |   15 +-
 arch/arm/plat-omap/include/dspbridge/gt.h          |   30 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h     |   10 -
 arch/arm/plat-omap/include/dspbridge/io.h          |   21 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h       |   46 +-
 arch/arm/plat-omap/include/dspbridge/iodefs.h      |   13 +-
 arch/arm/plat-omap/include/dspbridge/ldr.h         |   34 +-
 arch/arm/plat-omap/include/dspbridge/list.h        |   36 +-
 arch/arm/plat-omap/include/dspbridge/mbx_sh.h      |   25 +-
 arch/arm/plat-omap/include/dspbridge/mem.h         |   78 +-
 arch/arm/plat-omap/include/dspbridge/memdefs.h     |   16 +-
 arch/arm/plat-omap/include/dspbridge/mgr.h         |   32 +-
 arch/arm/plat-omap/include/dspbridge/mgrpriv.h     |   14 +-
 arch/arm/plat-omap/include/dspbridge/msg.h         |   24 +-
 arch/arm/plat-omap/include/dspbridge/msgdefs.h     |   15 +-
 arch/arm/plat-omap/include/dspbridge/nldr.h        |   29 +-
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h    |   14 +-
 arch/arm/plat-omap/include/dspbridge/node.h        |   48 +-
 arch/arm/plat-omap/include/dspbridge/nodedefs.h    |   16 +-
 arch/arm/plat-omap/include/dspbridge/nodepriv.h    |   23 +-
 arch/arm/plat-omap/include/dspbridge/ntfy.h        |   22 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |   47 +-
 arch/arm/plat-omap/include/dspbridge/procpriv.h    |   13 +-
 arch/arm/plat-omap/include/dspbridge/pwr.h         |   19 -
 arch/arm/plat-omap/include/dspbridge/pwr_sh.h      |   12 +-
 arch/arm/plat-omap/include/dspbridge/reg.h         |   35 +-
 arch/arm/plat-omap/include/dspbridge/rmm.h         |   26 +-
 arch/arm/plat-omap/include/dspbridge/rms_sh.h      |   34 +-
 arch/arm/plat-omap/include/dspbridge/rmstypes.h    |   15 +-
 arch/arm/plat-omap/include/dspbridge/services.h    |   17 +-
 arch/arm/plat-omap/include/dspbridge/std.h         |   48 -
 arch/arm/plat-omap/include/dspbridge/strm.h        |   41 +-
 arch/arm/plat-omap/include/dspbridge/strmdefs.h    |   14 +-
 arch/arm/plat-omap/include/dspbridge/sync.h        |   40 +-
 arch/arm/plat-omap/include/dspbridge/utildefs.h    |   16 +-
 arch/arm/plat-omap/include/dspbridge/uuidutil.h    |   16 +-
 arch/arm/plat-omap/include/dspbridge/wcd.h         |   49 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h    |  198 ++---
 arch/arm/plat-omap/include/dspbridge/wmd.h         |   57 +-
 arch/arm/plat-omap/include/dspbridge/wmdchnl.h     |   29 +-
 arch/arm/plat-omap/include/dspbridge/wmddeh.h      |   30 +-
 arch/arm/plat-omap/include/dspbridge/wmdio.h       |   24 +-
 arch/arm/plat-omap/include/dspbridge/wmdioctl.h    |   26 +-
 arch/arm/plat-omap/include/dspbridge/wmdmsg.h      |   27 +-
 drivers/dsp/bridge/Makefile                        |    3 +-
 drivers/dsp/bridge/dynload/cload.c                 |   17 +-
 drivers/dsp/bridge/dynload/dlclasses_hdr.h         |    2 -
 drivers/dsp/bridge/dynload/dload_internal.h        |   46 +-
 drivers/dsp/bridge/dynload/doff.h                  |   75 +-
 drivers/dsp/bridge/dynload/getsection.c            |    2 -
 drivers/dsp/bridge/dynload/header.h                |   20 +-
 drivers/dsp/bridge/dynload/module_list.h           |   98 +-
 drivers/dsp/bridge/dynload/params.h                |  205 ++--
 drivers/dsp/bridge/dynload/reloc.c                 |   43 +-
 drivers/dsp/bridge/dynload/reloc_table.h           |   55 +-
 drivers/dsp/bridge/dynload/reloc_table_c6000.c     |    7 +-
 drivers/dsp/bridge/dynload/tramp.c                 |   18 +-
 drivers/dsp/bridge/dynload/tramp_table_c6000.c     |   24 +-
 drivers/dsp/bridge/gen/_gt_para.c                  |   24 +-
 drivers/dsp/bridge/gen/gb.c                        |   17 +-
 drivers/dsp/bridge/gen/gh.c                        |    5 -
 drivers/dsp/bridge/gen/gs.c                        |   20 +-
 drivers/dsp/bridge/gen/gt.c                        |   16 +-
 drivers/dsp/bridge/gen/uuidutil.c                  |   20 +-
 drivers/dsp/bridge/hw/EasiGlobal.h                 |    8 +-
 drivers/dsp/bridge/hw/GlobalTypes.h                |  157 ++--
 drivers/dsp/bridge/hw/IPIAccInt.h                  |    7 +-
 drivers/dsp/bridge/hw/IVA2RegAcM.h                 |    6 +-
 drivers/dsp/bridge/hw/MLBAccInt.h                  |  118 +-
 drivers/dsp/bridge/hw/MLBRegAcM.h                  |  319 +++---
 drivers/dsp/bridge/hw/MMUAccInt.h                  |  100 +-
 drivers/dsp/bridge/hw/MMURegAcM.h                  |  416 ++++----
 drivers/dsp/bridge/hw/PRCMAccInt.h                 |  201 ++--
 drivers/dsp/bridge/hw/PRCMRegAcM.h                 | 1197 +++++++++-----------
 drivers/dsp/bridge/hw/hw_defs.h                    |   21 +-
 drivers/dsp/bridge/hw/hw_dspssC64P.c               |   13 +-
 drivers/dsp/bridge/hw/hw_dspssC64P.h               |   15 +-
 drivers/dsp/bridge/hw/hw_mbox.c                    |   15 +-
 drivers/dsp/bridge/hw/hw_mbox.h                    |   63 +-
 drivers/dsp/bridge/hw/hw_mmu.c                     |   37 +-
 drivers/dsp/bridge/hw/hw_mmu.h                     |   21 +-
 drivers/dsp/bridge/hw/hw_prcm.c                    |   12 +-
 drivers/dsp/bridge/hw/hw_prcm.h                    |   12 +-
 drivers/dsp/bridge/pmgr/chnl.c                     |   52 +-
 drivers/dsp/bridge/pmgr/chnlobj.h                  |   25 +-
 drivers/dsp/bridge/pmgr/cmm.c                      |  118 +--
 drivers/dsp/bridge/pmgr/cod.c                      |   51 +-
 drivers/dsp/bridge/pmgr/dbll.c                     |   65 +-
 drivers/dsp/bridge/pmgr/dev.c                      |  106 +--
 drivers/dsp/bridge/pmgr/dmm.c                      |   47 +-
 drivers/dsp/bridge/pmgr/io.c                       |   25 +-
 drivers/dsp/bridge/pmgr/ioobj.h                    |   19 +-
 drivers/dsp/bridge/pmgr/msg.c                      |   23 +-
 drivers/dsp/bridge/pmgr/msgobj.h                   |   19 +-
 drivers/dsp/bridge/pmgr/wcd.c                      |  196 +---
 drivers/dsp/bridge/rmgr/dbdcd.c                    |   56 +-
 drivers/dsp/bridge/rmgr/disp.c                     |   39 +-
 drivers/dsp/bridge/rmgr/drv.c                      |  102 +--
 drivers/dsp/bridge/rmgr/drv_interface.c            |   44 +-
 drivers/dsp/bridge/rmgr/drv_interface.h            |   12 -
 drivers/dsp/bridge/rmgr/dspdrv.c                   |   79 +--
 drivers/dsp/bridge/rmgr/mgr.c                      |   30 +-
 drivers/dsp/bridge/rmgr/nldr.c                     |  108 +--
 drivers/dsp/bridge/rmgr/node.c                     |  289 ++---
 drivers/dsp/bridge/rmgr/proc.c                     |  119 +--
 drivers/dsp/bridge/rmgr/pwr.c                      |   19 +-
 drivers/dsp/bridge/rmgr/rmm.c                      |   14 -
 drivers/dsp/bridge/rmgr/strm.c                     |   49 +-
 drivers/dsp/bridge/services/cfg.c                  |   78 +--
 drivers/dsp/bridge/services/clk.c                  |   25 +-
 drivers/dsp/bridge/services/dbg.c                  |   35 +-
 drivers/dsp/bridge/services/dpc.c                  |  274 -----
 drivers/dsp/bridge/services/list.c                 |   33 -
 drivers/dsp/bridge/services/mem.c                  |   40 +-
 drivers/dsp/bridge/services/ntfy.c                 |   27 +-
 drivers/dsp/bridge/services/reg.c                  |   21 +-
 drivers/dsp/bridge/services/regsup.c               |   30 +-
 drivers/dsp/bridge/services/regsup.h               |    8 -
 drivers/dsp/bridge/services/services.c             |   30 +-
 drivers/dsp/bridge/services/sync.c                 |   35 +-
 drivers/dsp/bridge/wmd/_cmm.h                      |   22 +-
 drivers/dsp/bridge/wmd/_deh.h                      |   18 +-
 drivers/dsp/bridge/wmd/_msg_sm.h                   |   21 +-
 drivers/dsp/bridge/wmd/_tiomap.h                   |  251 ++---
 drivers/dsp/bridge/wmd/_tiomap_mmu.h               |   16 +-
 drivers/dsp/bridge/wmd/_tiomap_pwr.h               |   13 +-
 drivers/dsp/bridge/wmd/_tiomap_util.h              |   13 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                   |   77 +--
 drivers/dsp/bridge/wmd/io_sm.c                     |  608 +++++-----
 drivers/dsp/bridge/wmd/mmu_fault.c                 |   34 +-
 drivers/dsp/bridge/wmd/mmu_fault.h                 |   16 +-
 drivers/dsp/bridge/wmd/msg_sm.c                    |  107 +--
 drivers/dsp/bridge/wmd/tiomap3430.c                |   37 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c            |   41 +-
 drivers/dsp/bridge/wmd/tiomap_io.c                 |   17 +-
 drivers/dsp/bridge/wmd/tiomap_io.h                 |   14 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c                 |   11 +-
 drivers/dsp/bridge/wmd/ue_deh.c                    |   61 +-
 176 files changed, 2895 insertions(+), 6893 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/dpc.h
 delete mode 100644 drivers/dsp/bridge/services/dpc.c

