From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 00/40] dspbridge: trivial error code cleanup
Date: Fri, 11 Jun 2010 18:00:34 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CE443@dlee03.ent.ti.com>
References: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33454 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab0FKXAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 19:00:45 -0400
In-Reply-To: <1275544073-20418-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Hebbar, Shivananda" <x0hebbar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From: Ramirez Luna, Omar
>
>These set of patches gets rid of the custom error codes still present.
>
>Although there are a lot of patches most of them are just replacements
>which were broken into single patches to avoid big patch files.
>
>One of the patches creates a help file with the matching linux
>error codes just in case the error is not descriptive enough, and
>it also lists a common scenario where the error might be seen.
>
>Finally, the last patch replaces a custom typedef (dsp_status)
>with an int type as now those errors can have a negative value.
>
>Omar Ramirez Luna (40):
>  DSPBRIDGE: Remove success codes
>  DSPBRIDGE: change DSP_SENUMCOMPLETE for ENODATA
>  DSPBRIDGE: err code replace CHNL_E_WAITTIMEOUT with ETIMEDOUT
>  DSPBRIDGE: err code replace CHNL_E_NOEOS with EPERM
>  DSPBRIDGE: err code replace CHNL_E_BUFSIZE with EINVAL
>  DSPBRIDGE: err code replace CHNL_E_NOIORPS with EIO
>  DSPBRIDGE: err code replace CHNL_E_ISR with EIO
>  DSPBRIDGE: err code replace CHNL_E_MGREXISTS with EEXIST
>  DSPBRIDGE: err code replace CHNL_E_NOMEMMAP with EFAULT
>  DSPBRIDGE: err code replace CHNL_E_INVALIDMEMBASE with EINVAL
>  DSPBRIDGE: err code replace CHNL_E_INVALIDWORDSIZE with EINVAL
>  DSPBRIDGE: err code replace CHNL_E_EOS with EPIPE
>  DSPBRIDGE: err code replace CHNL_E_NOIOC with EREMOTEIO
>  DSPBRIDGE: err code replace CHNL_E_BADCHANID with ECHRNG
>  DSPBRIDGE: err code replace CHNL_E_OUTOFSTREAMS with ENOSR
>  DSPBRIDGE: err code replace CHNL_E_MAXCHANNELS with ECHRNG
>  DSPBRIDGE: err code replace COD_E_ZLCREATEFAILED with ESPIPE
>  DSPBRIDGE: err code replace COD_E_SYMBOLNOTFOUND with ESPIPE
>  DSPBRIDGE: err code replace COD_E_NOSYMBOLSLOADED with ESPIPE
>  DSPBRIDGE: err code replace DSP_EDPMSUSPEND with EPERM
>  DSPBRIDGE: err code replace DSP_EDYNLOAD with EILSEQ
>  DSPBRIDGE: err code replace DSP_EBADSEGID with EBADR
>  DSPBRIDGE: err code replace DSP_EOVERLAYMEMORY with ENXIO
>  DSPBRIDGE: err code replace DSP_ENOSECT with ENXIO
>  DSPBRIDGE: err code replace DSP_ETRANSLATE with ESRCH
>  DSPBRIDGE: err code replace DSP_ENOTFOUND with ENOENT
>  DSPBRIDGE: err code replace DSP_EDCDNOAUTOREGISTER with EACCES
>  DSPBRIDGE: err code replace DSP_EDCDLOADBASE with EACCES
>  DSPBRIDGE: err code replace DSP_EDCDGETSECT with EACCES
>  DSPBRIDGE: err code replace DSP_EDCDPARSESECT with EACCES
>  DSPBRIDGE: err code replace DSP_EDCDREADSECT with EACCES
>  DSPBRIDGE: err code replace DSP_ESYMBOL with ESPIPE
>  DSPBRIDGE: err code replace DSP_EWRONGSTATE with EBADR
>  DSPBRIDGE: err code replace DSP_EPENDING with EPIPE
>  DSPBRIDGE: err code replace DSP_ECHANGEDURINGENUM with EIDRM
>  DSPBRIDGE: remove custom errbase definitions
>  DSPBRIDGE: cleanup for duplicated error codes
>  DSPBRIDGE: removed unused error codes from comments
>  DSPBRIDGE: error code guide
>  DSPBRIDGE: remove dsp_status typedef
>
> Documentation/tidspbridge/error-codes              |  157 ++++++++++++++
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/cfg.h         |   57 +++---
> arch/arm/plat-omap/include/dspbridge/chnl.h        |   31 ++--
> arch/arm/plat-omap/include/dspbridge/clk.h         |    8 +-
> arch/arm/plat-omap/include/dspbridge/cmm.h         |   44 ++--
> arch/arm/plat-omap/include/dspbridge/cod.h         |   61 +++---
> arch/arm/plat-omap/include/dspbridge/dbdcd.h       |   73 +++----
> arch/arm/plat-omap/include/dspbridge/dbdcddef.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/dbdefs.h      |    5 +-
> arch/arm/plat-omap/include/dspbridge/dbldefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/dbll.h        |   14 +-
> arch/arm/plat-omap/include/dspbridge/dblldefs.h    |   47 ++---
> arch/arm/plat-omap/include/dspbridge/dev.h         |  156 ++++++--------
> arch/arm/plat-omap/include/dspbridge/disp.h        |   25 +--
> arch/arm/plat-omap/include/dspbridge/dmm.h         |   18 +-
> arch/arm/plat-omap/include/dspbridge/drv.h         |   38 ++--
> .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    2 +-
> arch/arm/plat-omap/include/dspbridge/dspapi.h      |    8 +-
> arch/arm/plat-omap/include/dspbridge/dspchnl.h     |   24 +-
> arch/arm/plat-omap/include/dspbridge/dspdefs.h     |  226 ++++++++++----------
> arch/arm/plat-omap/include/dspbridge/dspdeh.h      |    8 +-
> arch/arm/plat-omap/include/dspbridge/dspio.h       |   10 +-
> arch/arm/plat-omap/include/dspbridge/dspmsg.h      |   10 +-
> arch/arm/plat-omap/include/dspbridge/errbase.h     |  177 ---------------
> arch/arm/plat-omap/include/dspbridge/io.h          |   19 +-
> arch/arm/plat-omap/include/dspbridge/io_sm.h       |    6 +-
> arch/arm/plat-omap/include/dspbridge/mgr.h         |   34 ++--
> arch/arm/plat-omap/include/dspbridge/msg.h         |    2 +-
> arch/arm/plat-omap/include/dspbridge/nldr.h        |   14 +-
> arch/arm/plat-omap/include/dspbridge/nldrdefs.h    |   31 ++--
> arch/arm/plat-omap/include/dspbridge/node.h        |  148 ++++++-------
> arch/arm/plat-omap/include/dspbridge/nodepriv.h    |    8 +-
> arch/arm/plat-omap/include/dspbridge/ntfy.h        |   13 +-
> arch/arm/plat-omap/include/dspbridge/proc.h        |  117 +++++------
> arch/arm/plat-omap/include/dspbridge/pwr.h         |   25 +--
> .../plat-omap/include/dspbridge/resourcecleanup.h  |   30 ++--
> arch/arm/plat-omap/include/dspbridge/rmm.h         |   10 +-
> arch/arm/plat-omap/include/dspbridge/strm.h        |   71 +++---
> arch/arm/plat-omap/include/dspbridge/sync.h        |   11 +-
> drivers/dsp/bridge/core/_tiomap.h                  |    4 +-
> drivers/dsp/bridge/core/_tiomap_pwr.h              |   14 +-
> drivers/dsp/bridge/core/chnl_sm.c                  |   83 ++++----
> drivers/dsp/bridge/core/dsp-clock.c                |    9 +-
> drivers/dsp/bridge/core/io_sm.c                    |   75 ++++----
> drivers/dsp/bridge/core/mmu_fault.c                |    1 -
> drivers/dsp/bridge/core/msg_sm.c                   |   31 ++--
> drivers/dsp/bridge/core/tiomap3430.c               |  123 ++++++------
> drivers/dsp/bridge/core/tiomap3430_pwr.c           |   45 ++--
> drivers/dsp/bridge/core/tiomap_io.c                |   21 +-
> drivers/dsp/bridge/core/tiomap_io.h                |    6 +-
> drivers/dsp/bridge/core/ue_deh.c                   |   21 +-
> drivers/dsp/bridge/core/wdt.c                      |    1 -
> drivers/dsp/bridge/pmgr/chnl.c                     |   17 +-
> drivers/dsp/bridge/pmgr/cmm.c                      |   47 ++--
> drivers/dsp/bridge/pmgr/cod.c                      |   61 +++---
> drivers/dsp/bridge/pmgr/dbll.c                     |   47 ++--
> drivers/dsp/bridge/pmgr/dev.c                      |  113 +++++-----
> drivers/dsp/bridge/pmgr/dmm.c                      |   43 ++--
> drivers/dsp/bridge/pmgr/dspapi.c                   |  101 +++++-----
> drivers/dsp/bridge/pmgr/io.c                       |   13 +-
> drivers/dsp/bridge/pmgr/msg.c                      |    5 +-
> drivers/dsp/bridge/rmgr/dbdcd.c                    |   97 +++++----
> drivers/dsp/bridge/rmgr/disp.c                     |   35 ++--
> drivers/dsp/bridge/rmgr/drv.c                      |   97 ++++-----
> drivers/dsp/bridge/rmgr/drv_interface.c            |   13 +-
> drivers/dsp/bridge/rmgr/dspdrv.c                   |    3 +-
> drivers/dsp/bridge/rmgr/mgr.c                      |   43 ++--
> drivers/dsp/bridge/rmgr/nldr.c                     |   91 ++++----
> drivers/dsp/bridge/rmgr/node.c                     |  157 +++++++-------
> drivers/dsp/bridge/rmgr/proc.c                     |  131 ++++++------
> drivers/dsp/bridge/rmgr/pwr.c                      |   16 +-
> drivers/dsp/bridge/rmgr/rmm.c                      |   11 +-
> drivers/dsp/bridge/rmgr/strm.c                     |   84 ++++----
> drivers/dsp/bridge/services/cfg.c                  |   41 ++--
> drivers/dsp/bridge/services/sync.c                 |   10 +-
> 76 files changed, 1666 insertions(+), 1788 deletions(-)
> create mode 100644 Documentation/tidspbridge/error-codes
> delete mode 100644 arch/arm/plat-omap/include/dspbridge/errbase.h

Pushed to dspbridge

- omar
