From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/3] DSPBRIDGE: Replace custom mailbox implementation with
 kernel mailbox module
Date: Fri, 12 Feb 2010 20:01:57 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18E0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0BMCCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 21:02:01 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From d287e11cdb126f2c9b4be8d6d6f958ffdf7ff716 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 12 Feb 2010 19:55:55 -0600
Subject: [PATCH] DSPBRIDGE: Replace custom mailbox implementation with
kernel mailbox module

This set of patches removes dspbridge mailbox implementation and migrates to
use kernel mailbox module.


NOTE: Instability was found in stress tests, which were fixed with this set of patches:

http://marc.info/?l=linux-omap&m=126602506112846&w=2
It is recommended to apply them first.


Fernando Guzman Lugo (3):
  DSPBRIDGE: Change dspbridge for open source mailbox implementation
  DSPBRIDGE: Remove hw_mbox.c and hw_mbox.h not needed anymore
  DSPBRIDGE: Remove chnl_sm.h and tiomap_sm.c

 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    1 -
 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |  154 -----------
 arch/arm/plat-omap/include/dspbridge/clk.h     |    3 +-
 arch/arm/plat-omap/include/dspbridge/drv.h     |    3 -
 arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h   |    7 +-
 drivers/dsp/bridge/Makefile                    |    4 +-
 drivers/dsp/bridge/hw/hw_mbox.c                |  248 ------------------
 drivers/dsp/bridge/hw/hw_mbox.h                |  326 ------------------------
 drivers/dsp/bridge/rmgr/drv.c                  |    9 -
 drivers/dsp/bridge/services/clk.c              |    1 -
 drivers/dsp/bridge/wmd/_tiomap.h               |   22 ++-
 drivers/dsp/bridge/wmd/chnl_sm.c               |   26 ++-
 drivers/dsp/bridge/wmd/io_sm.c                 |  209 ++++++----------
 drivers/dsp/bridge/wmd/tiomap3430.c            |   52 +++--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   26 +--
 drivers/dsp/bridge/wmd/tiomap_io.c             |   71 +++++
 drivers/dsp/bridge/wmd/tiomap_sm.c             |  192 --------------
 drivers/dsp/bridge/wmd/ue_deh.c                |    4 +-
 19 files changed, 237 insertions(+), 1123 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/chnl_sm.h
 delete mode 100644 drivers/dsp/bridge/hw/hw_mbox.c
 delete mode 100644 drivers/dsp/bridge/hw/hw_mbox.h
 delete mode 100644 drivers/dsp/bridge/wmd/tiomap_sm.c
 
