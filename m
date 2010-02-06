From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patchv2 0/8] DSPBRIDGE: typedef cleanup
Date: Sat, 6 Feb 2010 06:51:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A776231@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223Ab0BFBVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:21:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o161LIx5007692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:21:20 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o161LHmB001354
	for <linux-omap@vger.kernel.org>; Sat, 6 Feb 2010 06:51:17 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Resending the patches after updating review comments and also 
Fixing some compilation breaks.

These patches remove the typedefs and replace it with normal C types:

Shivananda Hebbar (8)

DSPBRIDGE: typedef cleanup -DSP RTOS
DSPBRIDGE: typedef cleanup -PROCTYPE
DSPBRIDGE: typedef cleanup -PROCFAMILY
DSPBRIDGE: typedef cleanup -DSP_HSTREAM
DSPBRIDGE: typedef cleanup -DSP_HPROCESSOR
DSPBRIDGE: typedef cleanup -DSP_HNODE
DSPBRIDGE: typedef cleanup -BRD_STATUS
DSPBRIDGE: typedef cleanup -CHNL_MODE

 arch/arm/plat-omap/include/dspbridge/brddefs.h  |    1 -
 arch/arm/plat-omap/include/dspbridge/chnldefs.h |    2 -
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   18 +---
 arch/arm/plat-omap/include/dspbridge/dispdefs.h |    4 +-
 arch/arm/plat-omap/include/dspbridge/dmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    6 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |    4 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |   43 +++++-----
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   96 +++++++++++-----------
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/wmdchnl.h  |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                   |    6 +-
 drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |    4 +-
 drivers/dsp/bridge/rmgr/node.c                  |   12 ++--
 drivers/dsp/bridge/rmgr/proc.c                  |   56 +++++++-------
 drivers/dsp/bridge/rmgr/strm.c                  |    2 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |    8 +-
 drivers/dsp/bridge/wmd/tiomap3430.c             |    4 +-
 21 files changed, 134 insertions(+), 146 deletions(-)
