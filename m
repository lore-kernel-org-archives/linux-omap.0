From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/2] Implementation of Watch dog timer and recovery for DSP
Date: Fri, 5 Mar 2010 04:09:42 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA9E405D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49433 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab0CEKJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 05:09:47 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From 7db8ef8ac43e42a486b02c0647417da2b2387552 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 5 Mar 2010 04:14:10 -0600
Subject: [PATCH 0/2] Implementation of Watch dog timer and recovery for DSP


This two patches implementent a watch dog timer to catch DSP hangs and also
implement DSP recovery feature.

Fernando Guzman Lugo (2):
  DSPBRIDGE: Implement WDT3 to notify DSP hangs
  DSPBRIDGE: DSP recovery feature

 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    7 ++
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    3 +
 arch/arm/plat-omap/include/dspbridge/drv.h      |    6 +
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |   13 +++
 drivers/dsp/bridge/Kconfig                      |   25 +++++
 drivers/dsp/bridge/pmgr/wcd.c                   |   14 +--
 drivers/dsp/bridge/rmgr/drv.c                   |    3 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |   63 ++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                  |   14 +--
 drivers/dsp/bridge/services/clk.c               |    4 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |    6 +
 drivers/dsp/bridge/wmd/io_sm.c                  |  117 +++++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430.c             |   13 +++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |   17 ++++
 drivers/dsp/bridge/wmd/tiomap_sm.c              |    5 +
 drivers/dsp/bridge/wmd/ue_deh.c                 |   22 ++++-
 16 files changed, 312 insertions(+), 20 deletions(-)
