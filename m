From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 00/12] Custom debug removal
Date: Tue, 23 Feb 2010 12:09:07 -0600
Message-ID: <4B8419C3.4050701@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34894 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab0BWSJM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 13:09:12 -0500
In-Reply-To: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 2/18/2010 3:37 PM, Ramirez Luna, Omar wrote:
> Step 2 to remove custom debug tracing.
>
> This set of patches gets rid of GT_* and DBG_* functionality, and
> replaces them to use dev_dbg instead.
>
> This is meant to be a follow up of previous debug removal patches.
>
> More info on dynamic_debug:
> http://lwn.net/Articles/286191/
>
> Omar Ramirez Luna (12):
>    DSPBRIDGE: global bridge device
>    DSPBRIDGE: Change custom GT_trace for dev_dbg
>    DSPBRIDGE: Change custom GT_trace for dev_dbg in wmd
>    DSPBRIDGE: Change custom GT_trace for dev_dbg in pmgr
>    DSPBRIDGE: Change custom GT_trace for dev_dbg in services
>    DSPBRIDGE: Remove GT_trace variables for rmgr
>    DSPBRIDGE: Remove GT_trace variables for wmd
>    DSPBRIDGE: Remove GT_trace variables for pmgr
>    DSPBRIDGE: Remove GT_trace variables for services
>    DSPBRIDGE: Remove custom debugging implementation
>    DSPBRIDGE: Remove debug header files
>    DSPBRIDGE: Remove unused instances of CONFIG_BRIDGE_DEBUG
>
>   arch/arm/plat-omap/include/dspbridge/dbc.h     |    2 -
>   arch/arm/plat-omap/include/dspbridge/dbg.h     |   89 -------
>   arch/arm/plat-omap/include/dspbridge/gt.h      |  308 ----------------------
>   arch/arm/plat-omap/include/dspbridge/host_os.h |    1 +
>   drivers/dsp/bridge/Makefile                    |    4 +-
>   drivers/dsp/bridge/gen/_gt_para.c              |   95 -------
>   drivers/dsp/bridge/gen/gt.c                    |  336 ------------------------
>   drivers/dsp/bridge/pmgr/chnl.c                 |   11 -
>   drivers/dsp/bridge/pmgr/cmm.c                  |   19 +-
>   drivers/dsp/bridge/pmgr/cod.c                  |   15 +-
>   drivers/dsp/bridge/pmgr/dbll.c                 |   75 ++----
>   drivers/dsp/bridge/pmgr/dev.c                  |    8 -
>   drivers/dsp/bridge/pmgr/dmm.c                  |   58 ++---
>   drivers/dsp/bridge/pmgr/io.c                   |   10 -
>   drivers/dsp/bridge/pmgr/msg.c                  |   13 +-
>   drivers/dsp/bridge/pmgr/wcd.c                  |    7 -
>   drivers/dsp/bridge/rmgr/dbdcd.c                |   32 +--
>   drivers/dsp/bridge/rmgr/disp.c                 |   69 ++----
>   drivers/dsp/bridge/rmgr/drv.c                  |   96 +++----
>   drivers/dsp/bridge/rmgr/drv_interface.c        |   55 ++---
>   drivers/dsp/bridge/rmgr/dspdrv.c               |   14 +-
>   drivers/dsp/bridge/rmgr/mgr.c                  |   31 +--
>   drivers/dsp/bridge/rmgr/nldr.c                 |   43 +---
>   drivers/dsp/bridge/rmgr/node.c                 |  118 +++------
>   drivers/dsp/bridge/rmgr/proc.c                 |   94 ++-----
>   drivers/dsp/bridge/rmgr/rmm.c                  |   11 -
>   drivers/dsp/bridge/rmgr/strm.c                 |   45 ++--
>   drivers/dsp/bridge/services/cfg.c              |   23 +--
>   drivers/dsp/bridge/services/clk.c              |   12 +-
>   drivers/dsp/bridge/services/dbg.c              |   88 ------
>   drivers/dsp/bridge/services/mem.c              |    6 -
>   drivers/dsp/bridge/services/ntfy.c             |    8 -
>   drivers/dsp/bridge/services/reg.c              |    7 -
>   drivers/dsp/bridge/services/regsup.c           |   26 +--
>   drivers/dsp/bridge/services/services.c         |   21 +--
>   drivers/dsp/bridge/services/sync.c             |    8 -
>   drivers/dsp/bridge/wmd/chnl_sm.c               |    5 +-
>   drivers/dsp/bridge/wmd/io_sm.c                 |  119 ++++-----
>   drivers/dsp/bridge/wmd/mmu_fault.c             |   10 +-
>   drivers/dsp/bridge/wmd/tiomap3430.c            |  134 +++++------
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   64 ++----
>   drivers/dsp/bridge/wmd/tiomap_io.c             |    1 -
>   drivers/dsp/bridge/wmd/tiomap_sm.c             |    6 +-
>   drivers/dsp/bridge/wmd/ue_deh.c                |    6 +-
>   44 files changed, 406 insertions(+), 1797 deletions(-)
>   delete mode 100644 arch/arm/plat-omap/include/dspbridge/dbg.h
>   delete mode 100644 arch/arm/plat-omap/include/dspbridge/gt.h
>   delete mode 100644 drivers/dsp/bridge/gen/_gt_para.c
>   delete mode 100644 drivers/dsp/bridge/gen/gt.c
>   delete mode 100644 drivers/dsp/bridge/services/dbg.c
>   create mode 100644 drivers/dsp/bridge/uTimeout
>

removed bogus file: create mode 100644 drivers/dsp/bridge/uTimeout from 
patch [02/12] DSPBRIDGE: Change custom GT_trace for dev_dbg

Included as part of the set:
DSPBRIDGE: Remove GT_TRACE conditional macro
http://marc.info/?l=linux-omap&m=126694528710256&w=2

Rebased and pushed to dspbridge

- omar
