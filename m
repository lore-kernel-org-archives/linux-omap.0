From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 0/13] Cleanup DSPBRIDGE custom error codes
Date: Fri, 16 Apr 2010 02:46:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FD7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55856 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800Ab0DOVQq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:16:46 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLGhX0019288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:16:45 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLGg8C010998
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:46:43 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

This patch series tries to clean up the remaining 46 error codes.
Out of that 13 error codes are mapped to Linux errrorcodes.
Rest of the error codes will be kept as it is in the errbase.h.

Link to stage 1 cleanup can be found here.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg25835.html


Shivananda Hebbar (13)

DSPBRIDGE: Cleanup custom error code (DSP_EDIRECTION -> -EPERM)
DSPBRIDGE: Cleanup custom error code (DSP_ESTREAMFULL -> -ENOSR)
DSPBRIDGE: Cleanup custom error code (DSP_ENOMORECONNECTIONS -> -ECONNREFUSED)
DSPPBRIDGE: Cleanup custom error code (DSP_EFREAD -> -EBADF)
DSPBRIDGE: Cleanup custom error code (DSP_EALIGNMENT -> -EPERM)
DSPBRIDGE: Cleanup custom error code (DSP_ESTRMMODE -> -EPERM)
DSPBRIDGE: Cleanup custom error code (CFG_E_INVALIDPOINTER -> -EFAULT)
DSPBRIDGE: Cleanup custom error code (CFG_E_INVALIDHDEVNODE -> -EFAULT)
DSPBRIDGE: Cleanup custom error code (CFG_E_RESOURCENOTAVAIL -> -NODATA)
DSPBRIDGE: Cleanup custom error code (COD_E_OPENFAILED -> -EBADF)
DSPBRIDGE: Cleanup custom error code (REG_E_INVALIDSUBKEY -> -ENOKEY)
DSPBRIDGE: Cleanup custom error code (REG_E_NOMOREITEMS -> -ENODATA)
DSPBRIDGE: Cleanup custom error code (DSP_EFAIL -> -EPERM)


 arch/arm/plat-omap/include/dspbridge/_dcd.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/cfg.h      |   44 +++---
 arch/arm/plat-omap/include/dspbridge/clk.h      |   10 +-
 arch/arm/plat-omap/include/dspbridge/cmm.h      |   14 +-
 arch/arm/plat-omap/include/dspbridge/cod.h      |    8 +-
 arch/arm/plat-omap/include/dspbridge/dbdcd.h    |   16 +-
 arch/arm/plat-omap/include/dspbridge/dblldefs.h |    4 +-
 arch/arm/plat-omap/include/dspbridge/dev.h      |   14 +-
 arch/arm/plat-omap/include/dspbridge/disp.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |   12 +-
 arch/arm/plat-omap/include/dspbridge/errbase.h  |  205 ++---------------------
 arch/arm/plat-omap/include/dspbridge/mgr.h      |   12 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |   30 ++--
 arch/arm/plat-omap/include/dspbridge/proc.h     |   48 +++---
 arch/arm/plat-omap/include/dspbridge/pwr.h      |    8 +-
 arch/arm/plat-omap/include/dspbridge/reg.h      |    8 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |   28 ++--
 arch/arm/plat-omap/include/dspbridge/sync.h     |   10 +-
 arch/arm/plat-omap/include/dspbridge/wmd.h      |   44 +++---
 drivers/dsp/bridge/pmgr/cmm.c                   |   12 +-
 drivers/dsp/bridge/pmgr/cod.c                   |    8 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 +-
 drivers/dsp/bridge/pmgr/dev.c                   |   10 +-
 drivers/dsp/bridge/pmgr/msg.c                   |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |   10 +-
 drivers/dsp/bridge/rmgr/dbdcd.c                 |   44 +++---
 drivers/dsp/bridge/rmgr/disp.c                  |   16 +-
 drivers/dsp/bridge/rmgr/drv.c                   |   20 +-
 drivers/dsp/bridge/rmgr/dspdrv.c                |    4 +-
 drivers/dsp/bridge/rmgr/mgr.c                   |    6 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |    4 +-
 drivers/dsp/bridge/rmgr/node.c                  |   42 +++---
 drivers/dsp/bridge/rmgr/proc.c                  |   30 ++--
 drivers/dsp/bridge/rmgr/pwr.c                   |    8 +-
 drivers/dsp/bridge/rmgr/strm.c                  |   22 ++--
 drivers/dsp/bridge/services/cfg.c               |   34 ++--
 drivers/dsp/bridge/services/clk.c               |   12 +-
 drivers/dsp/bridge/services/reg.c               |    2 +-
 drivers/dsp/bridge/services/regsup.c            |   10 +-
 drivers/dsp/bridge/services/regsup.h            |    4 +-
 drivers/dsp/bridge/services/sync.c              |    6 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |   20 +-
 drivers/dsp/bridge/wmd/msg_sm.c                 |    8 +-
 drivers/dsp/bridge/wmd/tiomap3430.c             |   44 +++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |   18 +-
 drivers/dsp/bridge/wmd/tiomap_io.c              |   20 +-
 drivers/dsp/bridge/wmd/ue_deh.c                 |    2 +-
 48 files changed, 385 insertions(+), 560 deletions(-)
