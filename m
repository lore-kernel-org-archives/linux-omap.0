From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: Patch[0/2]:DSPBRIDGE: Excessive u32 Cleanup
Date: Fri, 19 Feb 2010 00:53:34 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044D71B418@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45768 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab0BRTXl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 14:23:41 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1IJNcGU020502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:23:40 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1IJNawY027723
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 00:53:37 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

These patches remove excessive u32 type and replaces it with the Normal C types.

Shivananda Hebbar (2)

DSPBRIDGE: Excessive u32 Cleanup (u32->short int)
DSPBRIDGE: Excessive u32 Cleanup (u32->int)

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   10 ++++----
 arch/arm/plat-omap/include/dspbridge/cfg.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h  |   10 ++++----
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |   16 ++++++------
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 +-
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/cod.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 +-
 drivers/dsp/bridge/pmgr/dev.c                   |    8 +++---
 drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/io.c                    |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |    8 +++---
 drivers/dsp/bridge/rmgr/dbdcd.c                 |    4 +-
 drivers/dsp/bridge/rmgr/disp.c                  |   15 +++++-------
 drivers/dsp/bridge/rmgr/drv.c                   |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c                   |    6 ++--
 drivers/dsp/bridge/rmgr/nldr.c                  |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |   12 +++++-----
 drivers/dsp/bridge/rmgr/proc.c                  |    4 +-
 drivers/dsp/bridge/rmgr/rmm.c                   |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                  |    8 +++---
 drivers/dsp/bridge/services/cfg.c               |    4 +-
 drivers/dsp/bridge/services/mem.c               |    2 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |   28 +++++++++++-----------
 drivers/dsp/bridge/wmd/msg_sm.c                 |    4 +-
 34 files changed, 89 insertions(+), 92 deletions(-)
 

Regards
Shivananda
