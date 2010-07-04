From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] staging: ti dspbridge: improve Kconfig
Date: Sun,  4 Jul 2010 16:36:21 +0300
Message-ID: <1278250586-17062-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65451 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab0GDNga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:36:30 -0400
Received: by bwz1 with SMTP id 1so2295721bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:36:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

The current Kconfig really needed some attention. I have tried to standarize
everything to CONFIG_TIDSPBRIDGE, unfortunately, it seems the dspgateway was
using that. Since that was never mainlined, I removed the dead code that was
relying on it (should move to the dspgateway branch).

Also, make some code only useful for debugging or testing configurable.

 1) in production, DEBUG=n BACKTRACE=n
 2) in internal testing, DEBUG=n BACKTRACE=y
 3) in development debugging, DEBUG=y BACKTRACE=y

These apply on top of the deh rewrite patches.

(Essentially the same as the previous try, but rebased on top of staging tree)

Felipe Contreras (5):
  omap: OMAP_DSP is not in mainline, remove it
  staging: ti dspbridge: prefix configs with TIDSPBRIDGE
  staging: ti dspbridge: improve Kconfig
  staging: ti dspbridge: use _DEBUG for debug trace
  staging: ti dspbridge: add _BACKTRACE config

 arch/arm/plat-omap/devices.c                       |   62 --------------------
 drivers/staging/tidspbridge/Kconfig                |   42 +++++++------
 drivers/staging/tidspbridge/core/io_sm.c           |   30 +++++-----
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |   30 +++++-----
 drivers/staging/tidspbridge/core/tiomap_io.c       |    4 +-
 drivers/staging/tidspbridge/core/ue_deh.c          |    8 ++-
 drivers/staging/tidspbridge/core/wdt.c             |    4 +-
 drivers/staging/tidspbridge/gen/gh.c               |    2 +
 .../tidspbridge/include/dspbridge/_chnl_sm.h       |    2 +-
 .../staging/tidspbridge/include/dspbridge/dbc.h    |    2 +-
 .../staging/tidspbridge/include/dspbridge/dbll.h   |    2 +
 .../staging/tidspbridge/include/dspbridge/drv.h    |    2 +-
 drivers/staging/tidspbridge/include/dspbridge/gh.h |    2 +
 .../staging/tidspbridge/include/dspbridge/io_sm.h  |    6 +-
 .../staging/tidspbridge/include/dspbridge/nldr.h   |    2 +
 .../staging/tidspbridge/include/dspbridge/node.h   |    2 +
 drivers/staging/tidspbridge/pmgr/dbll.c            |    2 +
 drivers/staging/tidspbridge/rmgr/drv.c             |    2 +-
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |   32 +++++-----
 drivers/staging/tidspbridge/rmgr/nldr.c            |    2 +
 drivers/staging/tidspbridge/rmgr/node.c            |    9 ++-
 drivers/staging/tidspbridge/rmgr/proc.c            |    8 +-
 22 files changed, 111 insertions(+), 146 deletions(-)

