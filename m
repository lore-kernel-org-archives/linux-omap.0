From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 0/7] DSPBRIDGE: fix mem+cache API issues
Date: Mon, 24 May 2010 19:05:11 +0300
Message-ID: <1274717118-15226-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64406 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280Ab0EXQFx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 12:05:53 -0400
Received: by bwz7 with SMTP id 7so1076486bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 09:05:51 -0700 (PDT)
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

Changes from v1:

* The DMM layer is enhanced to support caching of the required
  mapping and page information (inside dmm map objects).
  (the result: less code!)
* Two new ioctls were added, PROC_BEGINDMA and PROC_ENDDMA.
  These ioctls accepts a general direction argument, so dspbridge
  now supports all three possible (FROM, TO & BIDI) DMA directions.
* The old flush & inv ioctls were not removed; they have been
  implemented using the new DMA functions (with the appropriate
  direction). IOW, existing applications should still work as before.
* mem_flush_cache is removed, since low-level cache operations are
  not needed anymore.
* Patches were rebased on top of 7fd5c51c2753cedc095bfa20d433da1bb1e865a5.
* Minor cleanups

Notes:
1. The global bridge device struct is used by adding an 'extern'
   to proc. This issue should be handled in a different patch series
   (the struct should not be global. instead, it should be accessible
   to the dspbridge code via one of the context objects. This way we 
   will also be able to transform pr_* prints to dev_* prints).
2. The patchset was tested with the bridge testsuite and the dmm sample
   application running on ZOOM2 / 2.6.33.

Many thanks to Felipe Contreras for the thorough review, comments
and testing, and for Ivan Gomez Castellanos for thorough testing
of multiple scenarios.

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
 drivers/dsp/bridge/rmgr/proc.c                     |  404 ++++++++++++++++----
 10 files changed, 427 insertions(+), 139 deletions(-)

