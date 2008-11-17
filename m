From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [FYI] Rebase: tidspbridge-20081118
Date: Mon, 17 Nov 2008 15:36:29 +0200 (EET)
Message-ID: <20081117.153629.191249242.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5303E11EBF40@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61986 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYKQNgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2008 08:36:41 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5303E11EBF40@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x00omar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com

Hi,

The following changes since commit f23f23fb6bfd8ce4669070df35ec9b320983ac0c:
  Grazvydas Ignotas (1):
        HSMMC: Add MMC configuration for pandora

are available in the git repository at:

  http://git.gitorious.org/lk/mainline.git tidspbridge-20081118

Axel Haslam (1):
      BRIDGE: tiomap unmap fix

Fernando Guzman Lugo (5):
      BRIDGE: Remove sparse warnings from wcd
      BRIDGE: Module ISR removed
      BRIDGE: PRCS wrappers removal
      BRIDGE: Chnl module cleanup
      BRIDGE: Sparse warnings cleanup

Hari Kanigeri (4):
      BRIDGE Add preemption support to unprotected functions
      BRIDGE Resource cleanup node delete fix
      BRIDGE Memory leak fix
      BRIDGE Handle Node messaging when DSP crashed

Hiroshi DOYU (23):
      BRIDGE: Kconfig Entry
      BRIDGE: Header files
      BRIDGE: Doff image dynamic loader
      BRIDGE: Generic Utilities
      BRIDGE: Hardware Interfaces
      BRIDGE: Platform Manager
      BRIDGE: Resource Manager
      BRIDGE: Services
      BRIDGE: Mini driver
      BRIDGE: README
      BRIDGE: Fix header path
      BRIDGE: Sync omapzoom bridge patches
      BRIDGE: set 0 for phys_mempool_* as default
      BRIDGE: Rename header file location
      BRIDGE: Fix header path name to "arch/arm/plat-omap/include/dspbridge"
      BRIDGE: Add 'dspbridge' dirname in header file inclusion
      BRIDGE: Fix incorrect pathname
      BRIDGE: Remove paths in header comment
      BRIDGE: fix build error
      BRIDGE: enable dspbridge in omap_3430sdp_defconfig
      BRIDGE: use more detail name for interrupt claiming device
      BRIDGE: Fix uninitialized spinlock
      BRIDGE: Fix memory leak in PROC_Init()

Omar Ramirez Luna (11):
      BRIDGE: Ceanup GT sparse warnings
      BRIDGE: Cleanup static declarations warnings
      BRIDGE: Remove unused clk structs
      BRIDGE: Clean up unusedvariables
      BRIDGE: Cosmetic changes reported from checkpatch
      BRIDGE: Add wcd table end
      BRIDGE: Checkpatch Cleanup
      BRIDGE: OMAP CSL wrappers removed
      BRIDGE: Remove CDECL macro
      BRIDGE: GT mask for DSP traces
      BRIDGE: MMUfault infinite timeout fix

Ramesh Gupta (4):
      BRIDGE: Power management changes
      BRIDGE: OMAP PM Bug softlockup fix
      BRIDGE Power Management cleanup
      BRIDGE Save mailbox settings for suspend-resume

Suman Anna (1):
      BRIDGE: Fix bug in HW Mailbox messaging

Tony Lindgren (1):
      DSPBRIDGE: Flush posted write when acking mailbox irq

ext Ramirez Luna, Omar (1):
      BRIDGE: removing unnecesary OMAP3430 checks

 Documentation/tidspbridge/README                   |   70 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/configs/omap_3430sdp_defconfig            |    6 +-
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |  212 ++
 arch/arm/plat-omap/include/dspbridge/_dcd.h        |  187 ++
 arch/arm/plat-omap/include/dspbridge/brddefs.h     |   54 +
 arch/arm/plat-omap/include/dspbridge/cfg.h         |  339 ++
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h     |  124 +
 arch/arm/plat-omap/include/dspbridge/chnl.h        |  170 +
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h     |  210 ++
 arch/arm/plat-omap/include/dspbridge/chnldefs.h    |   92 +
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h    |  136 +
 arch/arm/plat-omap/include/dspbridge/clk.h         |  155 +
 arch/arm/plat-omap/include/dspbridge/cmm.h         |  420 +++
 arch/arm/plat-omap/include/dspbridge/cmmdefs.h     |  135 +
 arch/arm/plat-omap/include/dspbridge/cod.h         |  433 +++
 arch/arm/plat-omap/include/dspbridge/csl.h         |  135 +
 arch/arm/plat-omap/include/dspbridge/dbc.h         |   66 +
 arch/arm/plat-omap/include/dspbridge/dbdcd.h       |  388 +++
 arch/arm/plat-omap/include/dspbridge/dbdcddef.h    |   94 +
 arch/arm/plat-omap/include/dspbridge/dbdefs.h      |  577 ++++
 arch/arm/plat-omap/include/dspbridge/dbg.h         |  110 +
 arch/arm/plat-omap/include/dspbridge/dbl.h         |  354 ++
 arch/arm/plat-omap/include/dspbridge/dbldefs.h     |  155 +
 arch/arm/plat-omap/include/dspbridge/dbll.h        |   70 +
 arch/arm/plat-omap/include/dspbridge/dblldefs.h    |  509 +++
 arch/arm/plat-omap/include/dspbridge/dbof.h        |  117 +
 arch/arm/plat-omap/include/dspbridge/dbreg.h       |  113 +
 arch/arm/plat-omap/include/dspbridge/dbtype.h      |  103 +
 arch/arm/plat-omap/include/dspbridge/dehdefs.h     |   42 +
 arch/arm/plat-omap/include/dspbridge/dev.h         |  785 +++++
 arch/arm/plat-omap/include/dspbridge/devdefs.h     |   35 +
 arch/arm/plat-omap/include/dspbridge/disp.h        |  236 ++
 arch/arm/plat-omap/include/dspbridge/dispdefs.h    |   45 +
 arch/arm/plat-omap/include/dspbridge/dmm.h         |   85 +
 arch/arm/plat-omap/include/dspbridge/dpc.h         |  167 +
 arch/arm/plat-omap/include/dspbridge/drv.h         |  430 +++
 arch/arm/plat-omap/include/dspbridge/drvdefs.h     |   34 +
 arch/arm/plat-omap/include/dspbridge/dspdrv.h      |  106 +
 .../plat-omap/include/dspbridge/dynamic_loader.h   |  505 +++
 arch/arm/plat-omap/include/dspbridge/errbase.h     |  509 +++
 arch/arm/plat-omap/include/dspbridge/gb.h          |   85 +
 arch/arm/plat-omap/include/dspbridge/getsection.h  |  118 +
 arch/arm/plat-omap/include/dspbridge/gh.h          |   37 +
 arch/arm/plat-omap/include/dspbridge/gs.h          |   64 +
 arch/arm/plat-omap/include/dspbridge/gt.h          |  315 ++
 arch/arm/plat-omap/include/dspbridge/host_os.h     |   93 +
 arch/arm/plat-omap/include/dspbridge/io.h          |  132 +
 arch/arm/plat-omap/include/dspbridge/io_sm.h       |  338 ++
 arch/arm/plat-omap/include/dspbridge/iodefs.h      |   45 +
 arch/arm/plat-omap/include/dspbridge/kfile.h       |  216 ++
 arch/arm/plat-omap/include/dspbridge/ldr.h         |   51 +
 arch/arm/plat-omap/include/dspbridge/list.h        |  296 ++
 arch/arm/plat-omap/include/dspbridge/mbx_sh.h      |  213 ++
 arch/arm/plat-omap/include/dspbridge/mem.h         |  340 ++
 arch/arm/plat-omap/include/dspbridge/memdefs.h     |   52 +
 arch/arm/plat-omap/include/dspbridge/mgr.h         |  234 ++
 arch/arm/plat-omap/include/dspbridge/mgrpriv.h     |   55 +
 arch/arm/plat-omap/include/dspbridge/msg.h         |  106 +
 arch/arm/plat-omap/include/dspbridge/msgdefs.h     |   43 +
 arch/arm/plat-omap/include/dspbridge/nldr.h        |   81 +
 arch/arm/plat-omap/include/dspbridge/nldrdefs.h    |  307 ++
 arch/arm/plat-omap/include/dspbridge/node.h        |  619 ++++
 arch/arm/plat-omap/include/dspbridge/nodedefs.h    |   40 +
 arch/arm/plat-omap/include/dspbridge/nodepriv.h    |  202 ++
 arch/arm/plat-omap/include/dspbridge/ntfy.h        |  146 +
 arch/arm/plat-omap/include/dspbridge/proc.h        |  648 ++++
 arch/arm/plat-omap/include/dspbridge/procpriv.h    |   35 +
 arch/arm/plat-omap/include/dspbridge/pwr.h         |  129 +
 arch/arm/plat-omap/include/dspbridge/pwr_sh.h      |   41 +
 arch/arm/plat-omap/include/dspbridge/reg.h         |  257 ++
 .../plat-omap/include/dspbridge/resourcecleanup.h  |   88 +
 arch/arm/plat-omap/include/dspbridge/rmm.h         |  199 ++
 arch/arm/plat-omap/include/dspbridge/rms_sh.h      |  125 +
 arch/arm/plat-omap/include/dspbridge/rmstypes.h    |   40 +
 arch/arm/plat-omap/include/dspbridge/services.h    |   63 +
 arch/arm/plat-omap/include/dspbridge/std.h         |  143 +
 arch/arm/plat-omap/include/dspbridge/strm.h        |  441 +++
 arch/arm/plat-omap/include/dspbridge/strmdefs.h    |   57 +
 arch/arm/plat-omap/include/dspbridge/sync.h        |  340 ++
 arch/arm/plat-omap/include/dspbridge/util.h        |  173 +
 arch/arm/plat-omap/include/dspbridge/utildefs.h    |   51 +
 arch/arm/plat-omap/include/dspbridge/uuidutil.h    |   74 +
 arch/arm/plat-omap/include/dspbridge/wcd.h         |   61 +
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h    |  519 +++
 arch/arm/plat-omap/include/dspbridge/wmd.h         | 1193 +++++++
 arch/arm/plat-omap/include/dspbridge/wmdchnl.h     |   90 +
 arch/arm/plat-omap/include/dspbridge/wmddeh.h      |   64 +
 arch/arm/plat-omap/include/dspbridge/wmdio.h       |   53 +
 arch/arm/plat-omap/include/dspbridge/wmdioctl.h    |   91 +
 arch/arm/plat-omap/include/dspbridge/wmdmsg.h      |   70 +
 drivers/Makefile                                   |    1 +
 drivers/dsp/bridge/Kbuild                          |   40 +
 drivers/dsp/bridge/Kconfig                         |   28 +
 drivers/dsp/bridge/dynload/cload.c                 | 1854 +++++++++++
 drivers/dsp/bridge/dynload/dlclasses_hdr.h         |   41 +
 drivers/dsp/bridge/dynload/dload_internal.h        |  237 ++
 drivers/dsp/bridge/dynload/doff.h                  |  347 ++
 drivers/dsp/bridge/dynload/getsection.c            |  412 +++
 drivers/dsp/bridge/dynload/header.h                |   59 +
 drivers/dsp/bridge/dynload/module_list.h           |  161 +
 drivers/dsp/bridge/dynload/params.h                |  231 ++
 drivers/dsp/bridge/dynload/reloc.c                 |  425 +++
 drivers/dsp/bridge/dynload/reloc_table.h           |  102 +
 drivers/dsp/bridge/dynload/reloc_table_c6000.c     |  258 ++
 drivers/dsp/bridge/gen/_gt_para.c                  |  107 +
 drivers/dsp/bridge/gen/gb.c                        |  182 +
 drivers/dsp/bridge/gen/gh.c                        |  191 ++
 drivers/dsp/bridge/gen/gs.c                        |  108 +
 drivers/dsp/bridge/gen/gt.c                        |  348 ++
 drivers/dsp/bridge/gen/uuidutil.c                  |  238 ++
 drivers/dsp/bridge/hw/EasiGlobal.h                 |   42 +
 drivers/dsp/bridge/hw/GlobalTypes.h                |  325 ++
 drivers/dsp/bridge/hw/IPIAccInt.h                  |   41 +
 drivers/dsp/bridge/hw/IVA2RegAcM.h                 |   28 +
 drivers/dsp/bridge/hw/MLBAccInt.h                  |  132 +
 drivers/dsp/bridge/hw/MLBRegAcM.h                  |  200 ++
 drivers/dsp/bridge/hw/MMUAccInt.h                  |   79 +
 drivers/dsp/bridge/hw/MMURegAcM.h                  |  267 ++
 drivers/dsp/bridge/hw/PRCMAccInt.h                 |  300 ++
 drivers/dsp/bridge/hw/PRCMRegAcM.h                 |  669 ++++
 drivers/dsp/bridge/hw/hw_defs.h                    |   73 +
 drivers/dsp/bridge/hw/hw_dspssC64P.c               |   55 +
 drivers/dsp/bridge/hw/hw_dspssC64P.h               |   48 +
 drivers/dsp/bridge/hw/hw_mbox.c                    |  269 ++
 drivers/dsp/bridge/hw/hw_mbox.h                    |  358 ++
 drivers/dsp/bridge/hw/hw_mmu.c                     |  607 ++++
 drivers/dsp/bridge/hw/hw_mmu.h                     |  178 +
 drivers/dsp/bridge/hw/hw_prcm.c                    |  167 +
 drivers/dsp/bridge/hw/hw_prcm.h                    |  168 +
 drivers/dsp/bridge/pmgr/chnl.c                     |  260 ++
 drivers/dsp/bridge/pmgr/chnlobj.h                  |   71 +
 drivers/dsp/bridge/pmgr/cmm.c                      | 1291 ++++++++
 drivers/dsp/bridge/pmgr/cod.c                      |  683 ++++
 drivers/dsp/bridge/pmgr/dbl.c                      | 1385 ++++++++
 drivers/dsp/bridge/pmgr/dbll.c                     | 1564 +++++++++
 drivers/dsp/bridge/pmgr/dev.c                      | 1476 +++++++++
 drivers/dsp/bridge/pmgr/dmm.c                      |  646 ++++
 drivers/dsp/bridge/pmgr/io.c                       |  205 ++
 drivers/dsp/bridge/pmgr/ioobj.h                    |   52 +
 drivers/dsp/bridge/pmgr/msg.c                      |  173 +
 drivers/dsp/bridge/pmgr/msgobj.h                   |   52 +
 drivers/dsp/bridge/pmgr/wcd.c                      | 1647 ++++++++++
 drivers/dsp/bridge/rmgr/dbdcd.c                    | 1596 +++++++++
 drivers/dsp/bridge/rmgr/disp.c                     |  916 ++++++
 drivers/dsp/bridge/rmgr/drv.c                      | 1887 +++++++++++
 drivers/dsp/bridge/rmgr/drv_interface.c            |  797 +++++
 drivers/dsp/bridge/rmgr/drv_interface.h            |   40 +
 drivers/dsp/bridge/rmgr/dspdrv.c                   |  276 ++
 drivers/dsp/bridge/rmgr/mgr.c                      |  491 +++
 drivers/dsp/bridge/rmgr/nldr.c                     | 1967 +++++++++++
 drivers/dsp/bridge/rmgr/node.c                     | 3449 ++++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                     | 1987 +++++++++++
 drivers/dsp/bridge/rmgr/pwr.c                      |  184 ++
 drivers/dsp/bridge/rmgr/rmm.c                      |  604 ++++
 drivers/dsp/bridge/rmgr/strm.c                     | 1066 ++++++
 drivers/dsp/bridge/services/cfg.c                  |  483 +++
 drivers/dsp/bridge/services/clk.c                  |  364 +++
 drivers/dsp/bridge/services/csl.c                  |  173 +
 drivers/dsp/bridge/services/dbg.c                  |  119 +
 drivers/dsp/bridge/services/dpc.c                  |  275 ++
 drivers/dsp/bridge/services/kfile.c                |  338 ++
 drivers/dsp/bridge/services/list.c                 |  285 ++
 drivers/dsp/bridge/services/mem.c                  |  595 ++++
 drivers/dsp/bridge/services/ntfy.c                 |  329 ++
 drivers/dsp/bridge/services/reg.c                  |  196 ++
 drivers/dsp/bridge/services/regsup.c               |  368 +++
 drivers/dsp/bridge/services/regsup.h               |   58 +
 drivers/dsp/bridge/services/services.c             |  193 ++
 drivers/dsp/bridge/services/sync.c                 |  603 ++++
 drivers/dsp/bridge/wmd/_cmm.h                      |   59 +
 drivers/dsp/bridge/wmd/_deh.h                      |   46 +
 drivers/dsp/bridge/wmd/_msg_sm.h                   |  158 +
 drivers/dsp/bridge/wmd/_tiomap.h                   |  400 +++
 drivers/dsp/bridge/wmd/_tiomap_mmu.h               |   53 +
 drivers/dsp/bridge/wmd/_tiomap_pwr.h               |  100 +
 drivers/dsp/bridge/wmd/_tiomap_util.h              |   47 +
 drivers/dsp/bridge/wmd/chnl_sm.c                   | 1100 +++++++
 drivers/dsp/bridge/wmd/io_sm.c                     | 2031 ++++++++++++
 drivers/dsp/bridge/wmd/mmu_fault.c                 |  172 +
 drivers/dsp/bridge/wmd/mmu_fault.h                 |   45 +
 drivers/dsp/bridge/wmd/msg_sm.c                    |  600 ++++
 drivers/dsp/bridge/wmd/tiomap3430.c                | 2181 +++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c            |  552 ++++
 drivers/dsp/bridge/wmd/tiomap_io.c                 |  427 +++
 drivers/dsp/bridge/wmd/tiomap_io.h                 |  112 +
 drivers/dsp/bridge/wmd/tiomap_sm.c                 |  296 ++
 drivers/dsp/bridge/wmd/ue_deh.c                    |  329 ++
 188 files changed, 65014 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/tidspbridge/README
 create mode 100644 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/_dcd.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/brddefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/cfg.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/cfgdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/chnl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/chnl_sm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/chnldefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/chnlpriv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/clk.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/cmm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/cmmdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/cod.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/csl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbc.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbdcd.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbdcddef.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbg.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbldefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbll.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dblldefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbof.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbreg.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dbtype.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dehdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dev.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/devdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/disp.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dispdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dmm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dpc.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/drv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/drvdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dspdrv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/dynamic_loader.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/errbase.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/gb.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/getsection.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/gh.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/gs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/gt.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/host_os.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/io.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/io_sm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/iodefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/kfile.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/ldr.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/list.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/mbx_sh.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/mem.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/memdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/mgr.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/mgrpriv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/msg.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/msgdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/nldr.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/nldrdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/node.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/nodedefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/nodepriv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/ntfy.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/proc.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/procpriv.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/pwr.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/pwr_sh.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/reg.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/resourcecleanup.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/rmm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/rms_sh.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/rmstypes.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/services.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/std.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/strm.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/strmdefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/sync.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/util.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/utildefs.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/uuidutil.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wcd.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wcdioctl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmd.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmdchnl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmddeh.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmdio.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmdioctl.h
 create mode 100644 arch/arm/plat-omap/include/dspbridge/wmdmsg.h
 create mode 100644 drivers/dsp/bridge/Kbuild
 create mode 100644 drivers/dsp/bridge/Kconfig
 create mode 100644 drivers/dsp/bridge/dynload/cload.c
 create mode 100644 drivers/dsp/bridge/dynload/dlclasses_hdr.h
 create mode 100644 drivers/dsp/bridge/dynload/dload_internal.h
 create mode 100644 drivers/dsp/bridge/dynload/doff.h
 create mode 100644 drivers/dsp/bridge/dynload/getsection.c
 create mode 100644 drivers/dsp/bridge/dynload/header.h
 create mode 100644 drivers/dsp/bridge/dynload/module_list.h
 create mode 100644 drivers/dsp/bridge/dynload/params.h
 create mode 100644 drivers/dsp/bridge/dynload/reloc.c
 create mode 100644 drivers/dsp/bridge/dynload/reloc_table.h
 create mode 100644 drivers/dsp/bridge/dynload/reloc_table_c6000.c
 create mode 100644 drivers/dsp/bridge/gen/_gt_para.c
 create mode 100644 drivers/dsp/bridge/gen/gb.c
 create mode 100644 drivers/dsp/bridge/gen/gh.c
 create mode 100644 drivers/dsp/bridge/gen/gs.c
 create mode 100644 drivers/dsp/bridge/gen/gt.c
 create mode 100644 drivers/dsp/bridge/gen/uuidutil.c
 create mode 100644 drivers/dsp/bridge/hw/EasiGlobal.h
 create mode 100644 drivers/dsp/bridge/hw/GlobalTypes.h
 create mode 100644 drivers/dsp/bridge/hw/IPIAccInt.h
 create mode 100644 drivers/dsp/bridge/hw/IVA2RegAcM.h
 create mode 100644 drivers/dsp/bridge/hw/MLBAccInt.h
 create mode 100644 drivers/dsp/bridge/hw/MLBRegAcM.h
 create mode 100644 drivers/dsp/bridge/hw/MMUAccInt.h
 create mode 100644 drivers/dsp/bridge/hw/MMURegAcM.h
 create mode 100644 drivers/dsp/bridge/hw/PRCMAccInt.h
 create mode 100644 drivers/dsp/bridge/hw/PRCMRegAcM.h
 create mode 100644 drivers/dsp/bridge/hw/hw_defs.h
 create mode 100644 drivers/dsp/bridge/hw/hw_dspssC64P.c
 create mode 100644 drivers/dsp/bridge/hw/hw_dspssC64P.h
 create mode 100644 drivers/dsp/bridge/hw/hw_mbox.c
 create mode 100644 drivers/dsp/bridge/hw/hw_mbox.h
 create mode 100644 drivers/dsp/bridge/hw/hw_mmu.c
 create mode 100644 drivers/dsp/bridge/hw/hw_mmu.h
 create mode 100644 drivers/dsp/bridge/hw/hw_prcm.c
 create mode 100644 drivers/dsp/bridge/hw/hw_prcm.h
 create mode 100644 drivers/dsp/bridge/pmgr/chnl.c
 create mode 100644 drivers/dsp/bridge/pmgr/chnlobj.h
 create mode 100644 drivers/dsp/bridge/pmgr/cmm.c
 create mode 100644 drivers/dsp/bridge/pmgr/cod.c
 create mode 100644 drivers/dsp/bridge/pmgr/dbl.c
 create mode 100644 drivers/dsp/bridge/pmgr/dbll.c
 create mode 100644 drivers/dsp/bridge/pmgr/dev.c
 create mode 100644 drivers/dsp/bridge/pmgr/dmm.c
 create mode 100644 drivers/dsp/bridge/pmgr/io.c
 create mode 100644 drivers/dsp/bridge/pmgr/ioobj.h
 create mode 100644 drivers/dsp/bridge/pmgr/msg.c
 create mode 100644 drivers/dsp/bridge/pmgr/msgobj.h
 create mode 100644 drivers/dsp/bridge/pmgr/wcd.c
 create mode 100644 drivers/dsp/bridge/rmgr/dbdcd.c
 create mode 100644 drivers/dsp/bridge/rmgr/disp.c
 create mode 100644 drivers/dsp/bridge/rmgr/drv.c
 create mode 100644 drivers/dsp/bridge/rmgr/drv_interface.c
 create mode 100644 drivers/dsp/bridge/rmgr/drv_interface.h
 create mode 100644 drivers/dsp/bridge/rmgr/dspdrv.c
 create mode 100644 drivers/dsp/bridge/rmgr/mgr.c
 create mode 100644 drivers/dsp/bridge/rmgr/nldr.c
 create mode 100644 drivers/dsp/bridge/rmgr/node.c
 create mode 100644 drivers/dsp/bridge/rmgr/proc.c
 create mode 100644 drivers/dsp/bridge/rmgr/pwr.c
 create mode 100644 drivers/dsp/bridge/rmgr/rmm.c
 create mode 100644 drivers/dsp/bridge/rmgr/strm.c
 create mode 100644 drivers/dsp/bridge/services/cfg.c
 create mode 100644 drivers/dsp/bridge/services/clk.c
 create mode 100644 drivers/dsp/bridge/services/csl.c
 create mode 100644 drivers/dsp/bridge/services/dbg.c
 create mode 100644 drivers/dsp/bridge/services/dpc.c
 create mode 100644 drivers/dsp/bridge/services/kfile.c
 create mode 100644 drivers/dsp/bridge/services/list.c
 create mode 100644 drivers/dsp/bridge/services/mem.c
 create mode 100644 drivers/dsp/bridge/services/ntfy.c
 create mode 100644 drivers/dsp/bridge/services/reg.c
 create mode 100644 drivers/dsp/bridge/services/regsup.c
 create mode 100644 drivers/dsp/bridge/services/regsup.h
 create mode 100644 drivers/dsp/bridge/services/services.c
 create mode 100644 drivers/dsp/bridge/services/sync.c
 create mode 100644 drivers/dsp/bridge/wmd/_cmm.h
 create mode 100644 drivers/dsp/bridge/wmd/_deh.h
 create mode 100644 drivers/dsp/bridge/wmd/_msg_sm.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap_mmu.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap_pwr.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap_util.h
 create mode 100644 drivers/dsp/bridge/wmd/chnl_sm.c
 create mode 100644 drivers/dsp/bridge/wmd/io_sm.c
 create mode 100644 drivers/dsp/bridge/wmd/mmu_fault.c
 create mode 100644 drivers/dsp/bridge/wmd/mmu_fault.h
 create mode 100644 drivers/dsp/bridge/wmd/msg_sm.c
 create mode 100644 drivers/dsp/bridge/wmd/tiomap3430.c
 create mode 100644 drivers/dsp/bridge/wmd/tiomap3430_pwr.c
 create mode 100644 drivers/dsp/bridge/wmd/tiomap_io.c
 create mode 100644 drivers/dsp/bridge/wmd/tiomap_io.h
 create mode 100644 drivers/dsp/bridge/wmd/tiomap_sm.c
 create mode 100644 drivers/dsp/bridge/wmd/ue_deh.c
