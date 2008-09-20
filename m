From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [BRIDGE] latest dspbridge rebased on l-o and sync'ed with o-z
Date: Sat, 20 Sep 2008 07:56:39 +0300 (EEST)
Message-ID: <20080920.075639.02798063.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344B3DCD8@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47798 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYITE4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2008 00:56:48 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344B3DCD8@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com, x00omar@ti.com, h-kanigeri2@ti.com

Hi,

I have updated TI BRIDGE patchset for its easy integration. It has
been sync'ed with omapzoom("o-z") bridge patches[1] and rebased on the
latest l-o.  Most of the patches come from o-z(Thanks TI bridge team!)
and I just collected them;)

Now the latest patchset is:

    http://4869037.web.fc2.com/tidspbridge-20080920.tgz

So steps are:

  $ git clone http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
  $ cd linux-omap-2.6
  $ wget http://4869037.web.fc2.com/tidspbridge-20080920.tgz
  $ tar xvzf tidspbridge-20080920.tgz
  $ git am *.patch
  $ make <your omap3 board>_defconfig
  $ make menuconfig # add the following options in the menuconfig
 ...
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=14
 CONFIG_MPU_BRIDGE=m
 ...

You can get bridge sample binaries as below:

  https://omapzoom.org/gf/download/frsrelease/132/632/dspbridge_binaries.tar.bz2

And extract it somewhere on target rootfs.

After kernel booted up:

 $ depmod -a
 $ modprobe bridgedriver base_img=ddbase_tiomap3430.dof64P
 $ <Thy some sample applications>

This bridge patchset includes:

 Documentation/tidspbridge/README                   |   70 +
 arch/arm/Kconfig                                   |    1 +
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
 arch/arm/plat-omap/include/dspbridge/host_os.h     |   73 +
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
 arch/arm/plat-omap/include/dspbridge/sync.h        |  339 ++
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
 drivers/dsp/bridge/Kconfig                         |   36 +
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
 drivers/dsp/bridge/gen/gb.c                        |  182 ++
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
 drivers/dsp/bridge/hw/hw_mbox.c                    |  255 ++
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
 drivers/dsp/bridge/rmgr/drv_interface.c            |  853 +++++
 drivers/dsp/bridge/rmgr/drv_interface.h            |   40 +
 drivers/dsp/bridge/rmgr/dspdrv.c                   |  276 ++
 drivers/dsp/bridge/rmgr/mgr.c                      |  491 +++
 drivers/dsp/bridge/rmgr/nldr.c                     | 1967 +++++++++++
 drivers/dsp/bridge/rmgr/node.c                     | 3397 ++++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                     | 1994 ++++++++++++
 drivers/dsp/bridge/rmgr/pwr.c                      |  184 ++
 drivers/dsp/bridge/rmgr/rmm.c                      |  604 ++++
 drivers/dsp/bridge/rmgr/strm.c                     | 1066 ++++++
 drivers/dsp/bridge/services/cfg.c                  |  483 +++
 drivers/dsp/bridge/services/clk.c                  |  365 +++
 drivers/dsp/bridge/services/csl.c                  |  173 +
 drivers/dsp/bridge/services/dbg.c                  |  119 +
 drivers/dsp/bridge/services/dpc.c                  |  275 ++
 drivers/dsp/bridge/services/kfile.c                |  338 ++
 drivers/dsp/bridge/services/list.c                 |  285 ++
 drivers/dsp/bridge/services/mem.c                  |  594 ++++
 drivers/dsp/bridge/services/ntfy.c                 |  329 ++
 drivers/dsp/bridge/services/reg.c                  |  196 ++
 drivers/dsp/bridge/services/regsup.c               |  368 +++
 drivers/dsp/bridge/services/regsup.h               |   58 +
 drivers/dsp/bridge/services/services.c             |  193 ++
 drivers/dsp/bridge/services/sync.c                 |  610 ++++
 drivers/dsp/bridge/wmd/_cmm.h                      |   59 +
 drivers/dsp/bridge/wmd/_deh.h                      |   46 +
 drivers/dsp/bridge/wmd/_msg_sm.h                   |  158 +
 drivers/dsp/bridge/wmd/_tiomap.h                   |  400 +++
 drivers/dsp/bridge/wmd/_tiomap_mmu.h               |   53 +
 drivers/dsp/bridge/wmd/_tiomap_pwr.h               |  100 +
 drivers/dsp/bridge/wmd/_tiomap_util.h              |   47 +
 drivers/dsp/bridge/wmd/chnl_sm.c                   | 1100 +++++++
 drivers/dsp/bridge/wmd/io_sm.c                     | 2045 ++++++++++++
 drivers/dsp/bridge/wmd/mmu_fault.c                 |  172 +
 drivers/dsp/bridge/wmd/mmu_fault.h                 |   45 +
 drivers/dsp/bridge/wmd/msg_sm.c                    |  600 ++++
 drivers/dsp/bridge/wmd/tiomap3430.c                | 2174 +++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c            |  589 ++++
 drivers/dsp/bridge/wmd/tiomap_io.c                 |  427 +++
 drivers/dsp/bridge/wmd/tiomap_io.h                 |  112 +
 drivers/dsp/bridge/wmd/tiomap_sm.c                 |  321 ++
 drivers/dsp/bridge/wmd/ue_deh.c                    |  329 ++
 187 files changed, 65069 insertions(+), 0 deletions(-)

If you find something missed, please let me know.

[1] https://omapzoom.org/gf/project/omapbridge/wiki/

     Hiroshi DOYU
