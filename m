From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 00/10] trivial cleanups
Date: Mon, 18 Jan 2010 13:13:42 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50E1B@dlee03.ent.ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37263 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887Ab0ARTOU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 14:14:20 -0500
In-Reply-To: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar on Friday, January 15, 2010 3:29 PM
>
>This is a small set of trivial cleanups piled up in the patch queue.
>
>Higlights:
>- New patch with contributors file.
>- "Fix multiline macros to use do while" patch is dropped for
>  rework.
>
>Omar Ramirez Luna (10):
>  DSPBRIDGE: trivial license fix in tramp and tramp_table_c6000
>  DSPBRIDGE: contributors file
>  DSPBRIDGE: trivial file history cleanup for headers
>  DSPBRIDGE: trivial file history cleanup for driver sources
>  DSPBRIDGE: checkpatch - space required after comma
>  DSPBRIDGE: checkpatch - space required before open parenthesis
>  DSPBRIDGE: checkpatch spacing and indentation
>  DSPBRIDGE: Checkpatch - line over 80 characters
>  DSPBRIDGE: checkpatch - printk() should include KERN_ facility level
>  DSPBRIDGE: trivial cleanup for io_sm
>
> Documentation/tidspbridge/CONTRIBUTORS            |   70 ++
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h   |   46 +-
> arch/arm/plat-omap/include/dspbridge/_dcd.h       |   40 +-
> arch/arm/plat-omap/include/dspbridge/brddefs.h    |   18 +-
> arch/arm/plat-omap/include/dspbridge/cfg.h        |   50 +--
> arch/arm/plat-omap/include/dspbridge/cfgdefs.h    |   27 +-
> arch/arm/plat-omap/include/dspbridge/chnl.h       |   45 +-
> arch/arm/plat-omap/include/dspbridge/chnl_sm.h    |   30 +-
> arch/arm/plat-omap/include/dspbridge/chnldefs.h   |   26 +-
> arch/arm/plat-omap/include/dspbridge/chnlpriv.h   |   33 +-
> arch/arm/plat-omap/include/dspbridge/clk.h        |   11 +-
> arch/arm/plat-omap/include/dspbridge/cmm.h        |   66 +--
> arch/arm/plat-omap/include/dspbridge/cmmdefs.h    |   20 +-
> arch/arm/plat-omap/include/dspbridge/cod.h        |   58 +--
> arch/arm/plat-omap/include/dspbridge/dbc.h        |   32 +-
> arch/arm/plat-omap/include/dspbridge/dbdcd.h      |   26 +-
> arch/arm/plat-omap/include/dspbridge/dbdcddef.h   |   27 +-
> arch/arm/plat-omap/include/dspbridge/dbdefs.h     |   61 +--
> arch/arm/plat-omap/include/dspbridge/dbg.h        |   25 +-
> arch/arm/plat-omap/include/dspbridge/dbldefs.h    |   10 -
> arch/arm/plat-omap/include/dspbridge/dbll.h       |   15 +-
> arch/arm/plat-omap/include/dspbridge/dblldefs.h   |   11 -
> arch/arm/plat-omap/include/dspbridge/dbtype.h     |   21 +-
> arch/arm/plat-omap/include/dspbridge/dehdefs.h    |   14 +-
> arch/arm/plat-omap/include/dspbridge/dev.h        |   64 +--
> arch/arm/plat-omap/include/dspbridge/devdefs.h    |   15 +-
> arch/arm/plat-omap/include/dspbridge/disp.h       |   31 +-
> arch/arm/plat-omap/include/dspbridge/dispdefs.h   |   14 +-
> arch/arm/plat-omap/include/dspbridge/dmm.h        |   18 +-
> arch/arm/plat-omap/include/dspbridge/dpc.h        |   26 +-
> arch/arm/plat-omap/include/dspbridge/drv.h        |   48 +-
> arch/arm/plat-omap/include/dspbridge/drvdefs.h    |   13 +-
> arch/arm/plat-omap/include/dspbridge/dspdrv.h     |   33 +-
> arch/arm/plat-omap/include/dspbridge/errbase.h    |   37 +-
> arch/arm/plat-omap/include/dspbridge/gb.h         |   10 +-
> arch/arm/plat-omap/include/dspbridge/getsection.h |   21 +-
> arch/arm/plat-omap/include/dspbridge/gh.h         |    8 -
> arch/arm/plat-omap/include/dspbridge/gs.h         |   15 +-
> arch/arm/plat-omap/include/dspbridge/gt.h         |   27 +-
> arch/arm/plat-omap/include/dspbridge/host_os.h    |   10 -
> arch/arm/plat-omap/include/dspbridge/io.h         |   21 +-
> arch/arm/plat-omap/include/dspbridge/io_sm.h      |   44 +-
> arch/arm/plat-omap/include/dspbridge/iodefs.h     |   13 +-
> arch/arm/plat-omap/include/dspbridge/ldr.h        |   34 +-
> arch/arm/plat-omap/include/dspbridge/list.h       |   36 +-
> arch/arm/plat-omap/include/dspbridge/mbx_sh.h     |   25 +-
> arch/arm/plat-omap/include/dspbridge/mem.h        |   54 +--
> arch/arm/plat-omap/include/dspbridge/memdefs.h    |   16 +-
> arch/arm/plat-omap/include/dspbridge/mgr.h        |   32 +-
> arch/arm/plat-omap/include/dspbridge/mgrpriv.h    |   14 +-
> arch/arm/plat-omap/include/dspbridge/msg.h        |   24 +-
> arch/arm/plat-omap/include/dspbridge/msgdefs.h    |   15 +-
> arch/arm/plat-omap/include/dspbridge/nldr.h       |   29 +-
> arch/arm/plat-omap/include/dspbridge/nldrdefs.h   |   14 +-
> arch/arm/plat-omap/include/dspbridge/node.h       |   48 +-
> arch/arm/plat-omap/include/dspbridge/nodedefs.h   |   16 +-
> arch/arm/plat-omap/include/dspbridge/nodepriv.h   |   23 +-
> arch/arm/plat-omap/include/dspbridge/ntfy.h       |   22 +-
> arch/arm/plat-omap/include/dspbridge/proc.h       |   47 +-
> arch/arm/plat-omap/include/dspbridge/procpriv.h   |   13 +-
> arch/arm/plat-omap/include/dspbridge/pwr.h        |   19 -
> arch/arm/plat-omap/include/dspbridge/pwr_sh.h     |   12 +-
> arch/arm/plat-omap/include/dspbridge/reg.h        |   35 +-
> arch/arm/plat-omap/include/dspbridge/rmm.h        |   26 +-
> arch/arm/plat-omap/include/dspbridge/rms_sh.h     |   34 +-
> arch/arm/plat-omap/include/dspbridge/rmstypes.h   |   15 +-
> arch/arm/plat-omap/include/dspbridge/services.h   |   17 +-
> arch/arm/plat-omap/include/dspbridge/std.h        |   48 --
> arch/arm/plat-omap/include/dspbridge/strm.h       |   41 +-
> arch/arm/plat-omap/include/dspbridge/strmdefs.h   |   14 +-
> arch/arm/plat-omap/include/dspbridge/sync.h       |   40 +-
> arch/arm/plat-omap/include/dspbridge/utildefs.h   |   16 +-
> arch/arm/plat-omap/include/dspbridge/uuidutil.h   |   16 +-
> arch/arm/plat-omap/include/dspbridge/wcd.h        |   49 +-
> arch/arm/plat-omap/include/dspbridge/wcdioctl.h   |   52 +--
> arch/arm/plat-omap/include/dspbridge/wmd.h        |   57 +-
> arch/arm/plat-omap/include/dspbridge/wmdchnl.h    |   29 +-
> arch/arm/plat-omap/include/dspbridge/wmddeh.h     |   30 +-
> arch/arm/plat-omap/include/dspbridge/wmdio.h      |   24 +-
> arch/arm/plat-omap/include/dspbridge/wmdioctl.h   |   26 +-
> arch/arm/plat-omap/include/dspbridge/wmdmsg.h     |   27 +-
> drivers/dsp/bridge/dynload/doff.h                 |   17 +-
> drivers/dsp/bridge/dynload/module_list.h          |   82 +-
> drivers/dsp/bridge/dynload/params.h               |   23 +-
> drivers/dsp/bridge/dynload/reloc.c                |   29 +-
> drivers/dsp/bridge/dynload/tramp.c                |   18 +-
> drivers/dsp/bridge/dynload/tramp_table_c6000.c    |   18 +-
> drivers/dsp/bridge/gen/_gt_para.c                 |   24 +-
> drivers/dsp/bridge/gen/gb.c                       |   17 +-
> drivers/dsp/bridge/gen/gh.c                       |    5 -
> drivers/dsp/bridge/gen/gs.c                       |   17 +-
> drivers/dsp/bridge/gen/gt.c                       |   16 +-
> drivers/dsp/bridge/gen/uuidutil.c                 |   20 +-
> drivers/dsp/bridge/hw/GlobalTypes.h               |   16 +-
> drivers/dsp/bridge/hw/PRCMRegAcM.h                |   24 +-
> drivers/dsp/bridge/hw/hw_defs.h                   |   13 +-
> drivers/dsp/bridge/hw/hw_dspssC64P.c              |   13 +-
> drivers/dsp/bridge/hw/hw_dspssC64P.h              |   15 +-
> drivers/dsp/bridge/hw/hw_mbox.c                   |   13 +-
> drivers/dsp/bridge/hw/hw_mbox.h                   |   55 +-
> drivers/dsp/bridge/hw/hw_mmu.c                    |   17 +-
> drivers/dsp/bridge/hw/hw_mmu.h                    |   15 +-
> drivers/dsp/bridge/hw/hw_prcm.c                   |   12 +-
> drivers/dsp/bridge/hw/hw_prcm.h                   |   12 +-
> drivers/dsp/bridge/pmgr/chnl.c                    |   51 +--
> drivers/dsp/bridge/pmgr/chnlobj.h                 |   21 +-
> drivers/dsp/bridge/pmgr/cmm.c                     |  101 +--
> drivers/dsp/bridge/pmgr/cod.c                     |   51 +-
> drivers/dsp/bridge/pmgr/dbll.c                    |   65 +-
> drivers/dsp/bridge/pmgr/dev.c                     |  102 +---
> drivers/dsp/bridge/pmgr/dmm.c                     |   47 +-
> drivers/dsp/bridge/pmgr/io.c                      |   25 +-
> drivers/dsp/bridge/pmgr/ioobj.h                   |   19 +-
> drivers/dsp/bridge/pmgr/msg.c                     |   23 +-
> drivers/dsp/bridge/pmgr/msgobj.h                  |   19 +-
> drivers/dsp/bridge/pmgr/wcd.c                     |   80 +--
> drivers/dsp/bridge/rmgr/dbdcd.c                   |   56 +--
> drivers/dsp/bridge/rmgr/disp.c                    |   39 +-
> drivers/dsp/bridge/rmgr/drv.c                     |  102 +--
> drivers/dsp/bridge/rmgr/drv_interface.c           |   32 +-
> drivers/dsp/bridge/rmgr/drv_interface.h           |   12 -
> drivers/dsp/bridge/rmgr/dspdrv.c                  |   79 +--
> drivers/dsp/bridge/rmgr/mgr.c                     |   30 +-
> drivers/dsp/bridge/rmgr/nldr.c                    |   66 +--
> drivers/dsp/bridge/rmgr/node.c                    |  287 +++-----
> drivers/dsp/bridge/rmgr/proc.c                    |  102 +---
> drivers/dsp/bridge/rmgr/pwr.c                     |   19 +-
> drivers/dsp/bridge/rmgr/rmm.c                     |   14 -
> drivers/dsp/bridge/rmgr/strm.c                    |   49 +--
> drivers/dsp/bridge/services/cfg.c                 |   68 +--
> drivers/dsp/bridge/services/clk.c                 |   27 +-
> drivers/dsp/bridge/services/dbg.c                 |   35 +-
> drivers/dsp/bridge/services/dpc.c                 |   32 +-
> drivers/dsp/bridge/services/list.c                |   33 -
> drivers/dsp/bridge/services/mem.c                 |   40 +-
> drivers/dsp/bridge/services/ntfy.c                |   27 +-
> drivers/dsp/bridge/services/reg.c                 |   21 +-
> drivers/dsp/bridge/services/regsup.c              |   30 +-
> drivers/dsp/bridge/services/regsup.h              |    8 -
> drivers/dsp/bridge/services/services.c            |   20 +-
> drivers/dsp/bridge/services/sync.c                |   35 +-
> drivers/dsp/bridge/wmd/_cmm.h                     |   22 +-
> drivers/dsp/bridge/wmd/_deh.h                     |   13 +-
> drivers/dsp/bridge/wmd/_msg_sm.h                  |   21 +-
> drivers/dsp/bridge/wmd/_tiomap.h                  |   49 +-
> drivers/dsp/bridge/wmd/_tiomap_mmu.h              |   16 +-
> drivers/dsp/bridge/wmd/_tiomap_pwr.h              |   13 +-
> drivers/dsp/bridge/wmd/_tiomap_util.h             |   13 +-
> drivers/dsp/bridge/wmd/chnl_sm.c                  |   77 +--
> drivers/dsp/bridge/wmd/io_sm.c                    |  903 +++++++++++----------
> drivers/dsp/bridge/wmd/mmu_fault.c                |   19 +-
> drivers/dsp/bridge/wmd/mmu_fault.h                |   14 +-
> drivers/dsp/bridge/wmd/msg_sm.c                   |  107 +--
> drivers/dsp/bridge/wmd/tiomap3430.c               |   25 +-
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c           |   17 +-
> drivers/dsp/bridge/wmd/tiomap_io.c                |   17 +-
> drivers/dsp/bridge/wmd/tiomap_io.h                |   14 +-
> drivers/dsp/bridge/wmd/ue_deh.c                   |   34 +-
> 158 files changed, 1364 insertions(+), 4707 deletions(-)
> create mode 100644 Documentation/tidspbridge/CONTRIBUTORS

Pushed to dspbridge

- omar
