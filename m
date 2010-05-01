From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Sat,  1 May 2010 23:44:25 +0300
Message-ID: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:63707 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0EAUrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:47:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so364854fgg.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:47:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

This patchset introduces an approach to eliminate the direct calls
to follow_page and to the low level cache APIs.

The patchset works by caching the page information while memory
is mapped, and then using that information later when needed 
instead of calling follow_page. The low level cache API is then replaced
by the standard DMA API.

A few key points in the current approach that I'd be happy to hear
your feedback about:
1. The new mapping + page information is currently cached in the
   proc object, but it might fit better inside dmm map objects
   (by enhancing the DMM layer to support the required data caching,
   storing and retrieving).
2. The information is stored in a linked list. That's pretty fine
   as long as the number of memory mappings per application is not 
   extremely high. If that assumption is wrong, a different underlying
   data structure might be better (hash table, priority tree, etc..).
3. Moving to standard DMA API completely changes the user's point
   of view; users should no longer think in terms of which cache
   manipulation is required, but instead, they should just tell dspbridge
   before a DMA transfer begins, and after it ends. Between the begin
   and end calls, the buffer "belongs" to the DSP and should not
   be accessed by the user.

   The patchset renames the flush ioctl to begin_dma_to_dsp and
   the invalidate ioctl to begin_dma_from_dsp. Both functions
   eventually call dma_map_sg, with the former requesting a
   DMA_BIDIRECTIONAL direction, and the latter requesting a
   DMA_FROM_DEVICE direction.
   In addition, the patchset adds two new APIs which calls dma_unmap_sg:
   end_dma_to_dsp and end_dma_from_dsp.

   Ideally, there would be only a single begin_dma command and a single
   end_dma one, which would accept an additional parameter that will
   determine the direction of the transfer. Such an approach would be more
   versatile and cleaner, but it would also break all user space apps that
   use dspbridge today.

Notes:
1. During my tests, a few testsuite scenarios failed due to the
   fact that the test cases called flush/invalidate on a memory
   buffer it didn't map beforehand.
   I consider that as a misuse of the API, and thus a testsuite error.
2. The global bridge device struct is used by adding an 'extern'
   to proc. This issue should be handled in a different patch series
   (the struct should not be global. instead, it should be accessible
   to the dspbridge code via one of the context objects. This way we 
   will also be able to transform pr_* prints to dev_* prints).
3. The patchset is not yet rebased on the latest dspbridge commits.
   It's currently based on 13e2573f2162b76d45313e790fc67a0d7672930b.
4. The patchset was tested with the bridge testsuite and the dmm sample
   application running on ZOOM3 / 2.6.33.

I'd like to thank Hari and Fernando for initial review of this patchset.

Please review and let me know your comments.

Thanks,
Ohad.

---
If you want, you can also reach me at <  ohadb at ti dot com  >.

Ohad Ben-Cohen (6):
  DSPBRIDGE: add memory_map_info to PROC
  DSPBRIDGE: remember mapping and page info in proc_map
  DSPBRIDGE: remove mapping information in proc_unmap
  DSPBRIDGE: do not call follow_page
  DSPBRIDGE: do not use low level cache manipulation API
  DSPBRIDGE: add dspbridge API to mark end of DMA

 arch/arm/plat-omap/include/dspbridge/_dcd.h     |    6 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    8 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    6 +-
 arch/arm/plat-omap/include/dspbridge/wmd.h      |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |   39 ++-
 drivers/dsp/bridge/rmgr/proc.c                  |  440 ++++++++++++++++++++---
 drivers/dsp/bridge/wmd/io_sm.c                  |   10 +-
 drivers/dsp/bridge/wmd/tiomap3430.c             |   11 +-
 8 files changed, 448 insertions(+), 75 deletions(-)

