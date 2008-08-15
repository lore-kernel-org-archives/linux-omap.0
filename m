From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Fri, 15 Aug 2008 09:46:54 +0300
Message-ID: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31743 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYHOGr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 02:47:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, x00omar@ti.com, x0023949@ti.com, soni.trilok@gmail.com, felipe.contreras@nokia.com

Hello all,

I have ported the latest TI DSP BRIDGE from "omapzoom" to linux
omap. The purpose of this port is to get this code kept in a new
dedicated branch(ex: "dspbridge") in l-o, not intended to be merged
into master or some other existing branches for now, but to provide
an efficient development space to collaborate.

Presently there's no code base for TI BRIDGE in l-o at all but there
are some dspbridge related discussions and patches have been sent in
this ML since the interface with DSP is necessary from the system
point of view in practice. I don't think that it's efficient to
work/discuss without this code in l-o but, at the same time, it seems
to be too early to get this code merged in because the code quality of
this S/W still hasn't been linux kernel compatible to be merged in as
"checkpatch.pl" still complains lots of warnings. This S/W component
isn't so small and lots of effort will be needed before this code is
merged, and also some restructuring may be necessary, like eliminating
API abstraction layer and so on.

So I propose that, keeping this code in one dedicated branch in l-o
just for the development space would improve the situation, providing
the place for opensource developers to work together efficiently
through the public linux omap repository(on a dedicated branch) and
this linux omap ML. All patches related to bridge will be maintained
in this dedicated branch until the code will get enough cleaned up.

Any comment on this proposal would be appreciated.

    Hiroshi DOYU

* I have ported all patched from:
http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=119


 Documentation/tidspbridge/README                   |   70 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/plat-omap/include/bridge/_chnl_sm.h       |  221 ++
 arch/arm/plat-omap/include/bridge/_dcd.h           |  187 ++
 arch/arm/plat-omap/include/bridge/brddefs.h        |   54 +
 arch/arm/plat-omap/include/bridge/cfg.h            |  339 ++
 arch/arm/plat-omap/include/bridge/cfgdefs.h        |  127 +
 arch/arm/plat-omap/include/bridge/chnl.h           |  537 ++++
 arch/arm/plat-omap/include/bridge/chnl_sm.h        |  210 ++
 arch/arm/plat-omap/include/bridge/chnldefs.h       |   92 +
 arch/arm/plat-omap/include/bridge/chnlpriv.h       |  136 +
 arch/arm/plat-omap/include/bridge/clk.h            |  155 +
 arch/arm/plat-omap/include/bridge/cmm.h            |  420 +++
 arch/arm/plat-omap/include/bridge/cmmdefs.h        |  135 +
 arch/arm/plat-omap/include/bridge/cod.h            |  494 +++
 arch/arm/plat-omap/include/bridge/csl.h            |  269 ++
 arch/arm/plat-omap/include/bridge/dbapi.h          |   48 +
 arch/arm/plat-omap/include/bridge/dbc.h            |   66 +
 arch/arm/plat-omap/include/bridge/dbdcd.h          |  388 +++
 arch/arm/plat-omap/include/bridge/dbdcddef.h       |   94 +
 arch/arm/plat-omap/include/bridge/dbdefs.h         |  564 ++++
 arch/arm/plat-omap/include/bridge/dbg.h            |  110 +
 arch/arm/plat-omap/include/bridge/dbl.h            |  354 ++
 arch/arm/plat-omap/include/bridge/dbldefs.h        |  519 +++
 arch/arm/plat-omap/include/bridge/dbll.h           |   70 +
 arch/arm/plat-omap/include/bridge/dblldefs.h       |  513 +++
 arch/arm/plat-omap/include/bridge/dbof.h           |  117 +
 arch/arm/plat-omap/include/bridge/dbreg.h          |  113 +
 arch/arm/plat-omap/include/bridge/dbtype.h         |  105 +
 arch/arm/plat-omap/include/bridge/ddma_sh.h        |   95 +
 arch/arm/plat-omap/include/bridge/ddmatypes.h      |   36 +
 arch/arm/plat-omap/include/bridge/dehdefs.h        |   42 +
 arch/arm/plat-omap/include/bridge/dev.h            |  804 +++++
 arch/arm/plat-omap/include/bridge/devdefs.h        |   35 +
 arch/arm/plat-omap/include/bridge/disp.h           |  236 ++
 arch/arm/plat-omap/include/bridge/dispdefs.h       |   45 +
 arch/arm/plat-omap/include/bridge/dldr.h           |   75 +
 arch/arm/plat-omap/include/bridge/dldrdefs.h       |  315 ++
 arch/arm/plat-omap/include/bridge/dmm.h            |   85 +
 arch/arm/plat-omap/include/bridge/dpc.h            |  167 +
 arch/arm/plat-omap/include/bridge/drv.h            |  434 +++
 arch/arm/plat-omap/include/bridge/drvdefs.h        |   34 +
 arch/arm/plat-omap/include/bridge/dspapi.h         |   50 +
 arch/arm/plat-omap/include/bridge/dspdrv.h         |  106 +
 arch/arm/plat-omap/include/bridge/dynamic_loader.h |  505 +++
 arch/arm/plat-omap/include/bridge/errbase.h        |  509 +++
 arch/arm/plat-omap/include/bridge/gb.h             |   85 +
 arch/arm/plat-omap/include/bridge/getsection.h     |  121 +
 arch/arm/plat-omap/include/bridge/gh.h             |   37 +
 arch/arm/plat-omap/include/bridge/gp.h             |   33 +
 arch/arm/plat-omap/include/bridge/gs.h             |   64 +
 arch/arm/plat-omap/include/bridge/gt.h             |  317 ++
 arch/arm/plat-omap/include/bridge/host_os.h        |   80 +
 arch/arm/plat-omap/include/bridge/io.h             |  132 +
 arch/arm/plat-omap/include/bridge/io_sm.h          |  330 ++
 arch/arm/plat-omap/include/bridge/iodefs.h         |   45 +
 arch/arm/plat-omap/include/bridge/isr.h            |  219 ++
 arch/arm/plat-omap/include/bridge/kfile.h          |  216 ++
 arch/arm/plat-omap/include/bridge/ldr.h            |   51 +
 arch/arm/plat-omap/include/bridge/list.h           |  296 ++
 arch/arm/plat-omap/include/bridge/mbx_sh.h         |  213 ++
 arch/arm/plat-omap/include/bridge/mem.h            |  340 ++
 arch/arm/plat-omap/include/bridge/memdefs.h        |   52 +
 arch/arm/plat-omap/include/bridge/memry.h          |   96 +
 arch/arm/plat-omap/include/bridge/mgr.h            |  234 ++
 arch/arm/plat-omap/include/bridge/mgrpriv.h        |   55 +
 arch/arm/plat-omap/include/bridge/msg.h            |  106 +
 arch/arm/plat-omap/include/bridge/msgdefs.h        |   43 +
 arch/arm/plat-omap/include/bridge/nldr.h           |   81 +
 arch/arm/plat-omap/include/bridge/nldrdefs.h       |  307 ++
 arch/arm/plat-omap/include/bridge/node.h           |  619 ++++
 arch/arm/plat-omap/include/bridge/nodedefs.h       |   40 +
 arch/arm/plat-omap/include/bridge/nodepriv.h       |  237 ++
 arch/arm/plat-omap/include/bridge/ntfy.h           |  146 +
 arch/arm/plat-omap/include/bridge/prcs.h           |  101 +
 arch/arm/plat-omap/include/bridge/proc.h           |  648 ++++
 arch/arm/plat-omap/include/bridge/procpriv.h       |   35 +
 arch/arm/plat-omap/include/bridge/pwr.h            |  129 +
 arch/arm/plat-omap/include/bridge/pwr_sh.h         |   41 +
 arch/arm/plat-omap/include/bridge/reg.h            |  257 ++
 .../arm/plat-omap/include/bridge/resourcecleanup.h |   89 +
 arch/arm/plat-omap/include/bridge/rmm.h            |  199 ++
 arch/arm/plat-omap/include/bridge/rms_sh.h         |  125 +
 arch/arm/plat-omap/include/bridge/rmstypes.h       |   41 +
 arch/arm/plat-omap/include/bridge/services.h       |   63 +
 arch/arm/plat-omap/include/bridge/std.h            |  143 +
 arch/arm/plat-omap/include/bridge/strm.h           |  441 +++
 arch/arm/plat-omap/include/bridge/strmdefs.h       |   57 +
 arch/arm/plat-omap/include/bridge/sync.h           |  339 ++
 arch/arm/plat-omap/include/bridge/util.h           |  173 +
 arch/arm/plat-omap/include/bridge/utildefs.h       |   51 +
 arch/arm/plat-omap/include/bridge/uuidutil.h       |   74 +
 arch/arm/plat-omap/include/bridge/wcd.h            |   61 +
 arch/arm/plat-omap/include/bridge/wcdioctl.h       |  518 +++
 arch/arm/plat-omap/include/bridge/wmd.h            | 1193 +++++++
 arch/arm/plat-omap/include/bridge/wmdchnl.h        |   90 +
 arch/arm/plat-omap/include/bridge/wmddeh.h         |   64 +
 arch/arm/plat-omap/include/bridge/wmdio.h          |   53 +
 arch/arm/plat-omap/include/bridge/wmdioctl.h       |   91 +
 arch/arm/plat-omap/include/bridge/wmdmsg.h         |   70 +
 drivers/Makefile                                   |    1 +
 drivers/dsp/bridge/dynload/cload.c                 | 1856 +++++++++++
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
 drivers/dsp/bridge/gen/gb.c                        |  182 ++
 drivers/dsp/bridge/gen/gh.c                        |  191 ++
 drivers/dsp/bridge/gen/gs.c                        |  108 +
 drivers/dsp/bridge/gen/gt.c                        |  346 ++
 drivers/dsp/bridge/gen/uuidutil.c                  |  238 ++
 drivers/dsp/bridge/hw/EasiBase.h                   |  179 ++
 drivers/dsp/bridge/hw/EasiGlobal.h                 |   42 +
 drivers/dsp/bridge/hw/GlobalTypes.h                |  328 ++
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
 drivers/dsp/bridge/hw/hw_mbox.c                    |  255 ++
 drivers/dsp/bridge/hw/hw_mbox.h                    |  358 +++
 drivers/dsp/bridge/hw/hw_mmu.c                     |  607 ++++
 drivers/dsp/bridge/hw/hw_mmu.h                     |  178 +
 drivers/dsp/bridge/hw/hw_prcm.c                    |  167 +
 drivers/dsp/bridge/hw/hw_prcm.h                    |  168 +
 drivers/dsp/bridge/pmgr/chnl.c                     |  517 +++
 drivers/dsp/bridge/pmgr/chnlobj.h                  |   71 +
 drivers/dsp/bridge/pmgr/cmm.c                      | 1290 ++++++++
 drivers/dsp/bridge/pmgr/cod.c                      |  683 ++++
 drivers/dsp/bridge/pmgr/dbl.c                      | 1385 ++++++++
 drivers/dsp/bridge/pmgr/dbll.c                     | 1565 +++++++++
 drivers/dsp/bridge/pmgr/dev.c                      | 1475 +++++++++
 drivers/dsp/bridge/pmgr/dmm.c                      |  646 ++++
 drivers/dsp/bridge/pmgr/io.c                       |  204 ++
 drivers/dsp/bridge/pmgr/ioobj.h                    |   52 +
 drivers/dsp/bridge/pmgr/msg.c                      |  173 +
 drivers/dsp/bridge/pmgr/msgobj.h                   |   52 +
 drivers/dsp/bridge/pmgr/wcd.c                      | 1641 ++++++++++
 drivers/dsp/bridge/rmgr/dbdcd.c                    | 1599 ++++++++++
 drivers/dsp/bridge/rmgr/disp.c                     |  915 ++++++
 drivers/dsp/bridge/rmgr/drv.c                      | 1883 +++++++++++
 drivers/dsp/bridge/rmgr/drv_interface.c            |  780 +++++
 drivers/dsp/bridge/rmgr/drv_interface.h            |   40 +
 drivers/dsp/bridge/rmgr/dspdrv.c                   |  276 ++
 drivers/dsp/bridge/rmgr/mgr.c                      |  491 +++
 drivers/dsp/bridge/rmgr/nldr.c                     | 1966 ++++++++++++
 drivers/dsp/bridge/rmgr/node.c                     | 3365 ++++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                     | 1958 ++++++++++++
 drivers/dsp/bridge/rmgr/pwr.c                      |  184 ++
 drivers/dsp/bridge/rmgr/rmm.c                      |  604 ++++
 drivers/dsp/bridge/rmgr/strm.c                     | 1053 ++++++
 drivers/dsp/bridge/services/cfg.c                  |  484 +++
 drivers/dsp/bridge/services/clk.c                  |  376 +++
 drivers/dsp/bridge/services/csl.c                  |  274 ++
 drivers/dsp/bridge/services/dbg.c                  |  119 +
 drivers/dsp/bridge/services/dpc.c                  |  275 ++
 drivers/dsp/bridge/services/isr.c                  |  261 ++
 drivers/dsp/bridge/services/kfile.c                |  336 ++
 drivers/dsp/bridge/services/list.c                 |  285 ++
 drivers/dsp/bridge/services/mem.c                  |  594 ++++
 drivers/dsp/bridge/services/ntfy.c                 |  329 ++
 drivers/dsp/bridge/services/prcs.c                 |  119 +
 drivers/dsp/bridge/services/reg.c                  |  196 ++
 drivers/dsp/bridge/services/regsup.c               |  367 +++
 drivers/dsp/bridge/services/regsup.h               |   58 +
 drivers/dsp/bridge/services/services.c             |  205 ++
 drivers/dsp/bridge/services/sync.c                 |  610 ++++
 drivers/dsp/bridge/wmd/_cmm.h                      |   59 +
 drivers/dsp/bridge/wmd/_deh.h                      |   48 +
 drivers/dsp/bridge/wmd/_msg_sm.h                   |  158 +
 drivers/dsp/bridge/wmd/_tiomap.h                   |  400 +++
 drivers/dsp/bridge/wmd/_tiomap_api.h               |  182 ++
 drivers/dsp/bridge/wmd/_tiomap_clk.h               |  123 +
 drivers/dsp/bridge/wmd/_tiomap_mmu.h               |   53 +
 drivers/dsp/bridge/wmd/_tiomap_pwr.h               |   82 +
 drivers/dsp/bridge/wmd/_tiomap_util.h              |   47 +
 drivers/dsp/bridge/wmd/chnl_sm.c                   | 1101 +++++++
 drivers/dsp/bridge/wmd/io_sm.c                     | 1843 +++++++++++
 drivers/dsp/bridge/wmd/mmu_fault.c                 |  171 +
 drivers/dsp/bridge/wmd/mmu_fault.h                 |   52 +
 drivers/dsp/bridge/wmd/msg_sm.c                    |  599 ++++
 drivers/dsp/bridge/wmd/tiomap3430.c                | 2171 +++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c            |  568 ++++
 drivers/dsp/bridge/wmd/tiomap_io.c                 |  430 +++
 drivers/dsp/bridge/wmd/tiomap_io.h                 |  112 +
 drivers/dsp/bridge/wmd/tiomap_sm.c                 |  305 ++
 drivers/dsp/bridge/wmd/ue_deh.c                    |  502 +++
 200 files changed, 68060 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/tidspbridge/README
 create mode 100644 arch/arm/plat-omap/include/bridge/_chnl_sm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/_dcd.h
 create mode 100644 arch/arm/plat-omap/include/bridge/brddefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/cfg.h
 create mode 100644 arch/arm/plat-omap/include/bridge/cfgdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/chnl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/chnl_sm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/chnldefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/chnlpriv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/clk.h
 create mode 100644 arch/arm/plat-omap/include/bridge/cmm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/cmmdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/cod.h
 create mode 100644 arch/arm/plat-omap/include/bridge/csl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbapi.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbc.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbdcd.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbdcddef.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbg.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbldefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbll.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dblldefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbof.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbreg.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dbtype.h
 create mode 100644 arch/arm/plat-omap/include/bridge/ddma_sh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/ddmatypes.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dehdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dev.h
 create mode 100644 arch/arm/plat-omap/include/bridge/devdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/disp.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dispdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dldr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dldrdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dmm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dpc.h
 create mode 100644 arch/arm/plat-omap/include/bridge/drv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/drvdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dspapi.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dspdrv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/dynamic_loader.h
 create mode 100644 arch/arm/plat-omap/include/bridge/errbase.h
 create mode 100644 arch/arm/plat-omap/include/bridge/gb.h
 create mode 100644 arch/arm/plat-omap/include/bridge/getsection.h
 create mode 100644 arch/arm/plat-omap/include/bridge/gh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/gp.h
 create mode 100644 arch/arm/plat-omap/include/bridge/gs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/gt.h
 create mode 100644 arch/arm/plat-omap/include/bridge/host_os.h
 create mode 100644 arch/arm/plat-omap/include/bridge/io.h
 create mode 100644 arch/arm/plat-omap/include/bridge/io_sm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/iodefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/isr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/kfile.h
 create mode 100644 arch/arm/plat-omap/include/bridge/ldr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/list.h
 create mode 100644 arch/arm/plat-omap/include/bridge/mbx_sh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/mem.h
 create mode 100644 arch/arm/plat-omap/include/bridge/memdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/memry.h
 create mode 100644 arch/arm/plat-omap/include/bridge/mgr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/mgrpriv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/msg.h
 create mode 100644 arch/arm/plat-omap/include/bridge/msgdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/nldr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/nldrdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/node.h
 create mode 100644 arch/arm/plat-omap/include/bridge/nodedefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/nodepriv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/ntfy.h
 create mode 100644 arch/arm/plat-omap/include/bridge/prcs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/proc.h
 create mode 100644 arch/arm/plat-omap/include/bridge/procpriv.h
 create mode 100644 arch/arm/plat-omap/include/bridge/pwr.h
 create mode 100644 arch/arm/plat-omap/include/bridge/pwr_sh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/reg.h
 create mode 100644 arch/arm/plat-omap/include/bridge/resourcecleanup.h
 create mode 100644 arch/arm/plat-omap/include/bridge/rmm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/rms_sh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/rmstypes.h
 create mode 100644 arch/arm/plat-omap/include/bridge/services.h
 create mode 100644 arch/arm/plat-omap/include/bridge/std.h
 create mode 100644 arch/arm/plat-omap/include/bridge/strm.h
 create mode 100644 arch/arm/plat-omap/include/bridge/strmdefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/sync.h
 create mode 100644 arch/arm/plat-omap/include/bridge/util.h
 create mode 100644 arch/arm/plat-omap/include/bridge/utildefs.h
 create mode 100644 arch/arm/plat-omap/include/bridge/uuidutil.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wcd.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wcdioctl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmd.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmdchnl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmddeh.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmdio.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmdioctl.h
 create mode 100644 arch/arm/plat-omap/include/bridge/wmdmsg.h
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
 create mode 100644 drivers/dsp/bridge/hw/EasiBase.h
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
 create mode 100644 drivers/dsp/bridge/services/isr.c
 create mode 100644 drivers/dsp/bridge/services/kfile.c
 create mode 100644 drivers/dsp/bridge/services/list.c
 create mode 100644 drivers/dsp/bridge/services/mem.c
 create mode 100644 drivers/dsp/bridge/services/ntfy.c
 create mode 100644 drivers/dsp/bridge/services/prcs.c
 create mode 100644 drivers/dsp/bridge/services/reg.c
 create mode 100644 drivers/dsp/bridge/services/regsup.c
 create mode 100644 drivers/dsp/bridge/services/regsup.h
 create mode 100644 drivers/dsp/bridge/services/services.c
 create mode 100644 drivers/dsp/bridge/services/sync.c
 create mode 100644 drivers/dsp/bridge/wmd/_cmm.h
 create mode 100644 drivers/dsp/bridge/wmd/_deh.h
 create mode 100644 drivers/dsp/bridge/wmd/_msg_sm.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap_api.h
 create mode 100644 drivers/dsp/bridge/wmd/_tiomap_clk.h
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

