From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 0/7] DSPBRIDGE: fix mem+cache API issues
Date: Thu, 27 May 2010 19:02:07 +0300
Message-ID: <1274976134-22769-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14152 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0E0QC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 12:02:27 -0400
Received: by fg-out-1718.google.com with SMTP id d23so83476fga.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 09:02:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

This patchset introduces an approach to eliminate the direct calls
to follow_page and to the low level cache APIs.

The patchset works by caching the page information while memory
is mapped, and then using that information later when needed 
instead of calling follow_page. The low level cache API is then replaced
by standard DMA API.

Changes from v2:

* Fix rebase error that plagued the v2 series
* Added some debug logs to help analyzing missing mapping issues

Notes:
1. The global bridge device struct is used by adding an 'extern'
   to proc. This issue should be handled in a different patch series
   (the struct should not be global. instead, it should be accessible
   to the dspbridge code via one of the context objects. This way we 
   will also be able to transform pr_* prints to dev_* prints).
2. The patchset was tested with testsuite, DMM sample app and varios
    MM and recovery scenarios. Many thanks to Ivan Gomez Castellanos
    for the help here. Also Many thanks to Felipe Contreras for the
    thorough review, comments and testing.

Thanks,
Ohad.

---
If you want, you can also reach me at <  ohadb at ti dot com  >.

Ohad Ben-Cohen (7):
  DSPBRIDGE: enhance dmm_map_object
  DSPBRIDGE: maintain mapping and page info
  DSPBRIDGE: do not call follow_page
  DSPBRIDGE: do not use low level cache manipulation API
  DSPBRIDGE: remove mem_flush_cache
  DSPBRIDGE: add dspbridge API to mark end of DMA
  DSPBRIDGE: add new PROC_BEGINDMA and PROC_ENDDMA ioctls

 arch/arm/plat-omap/include/dspbridge/drv.h         |   32 +-
 .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    9 +
 arch/arm/plat-omap/include/dspbridge/dspapi.h      |    2 +
 arch/arm/plat-omap/include/dspbridge/dspdefs.h     |    3 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |   29 ++
 drivers/dsp/bridge/core/io_sm.c                    |   11 +-
 drivers/dsp/bridge/core/tiomap3430.c               |    9 +-
 drivers/dsp/bridge/pmgr/dspapi.c                   |   34 ++-
 drivers/dsp/bridge/rmgr/drv.c                      |   33 --
 drivers/dsp/bridge/rmgr/proc.c                     |  410 ++++++++++++++++----
 10 files changed, 433 insertions(+), 139 deletions(-)

