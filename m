From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 00/15] tidspbridge: general cleanups
Date: Wed, 18 Mar 2009 03:22:56 +0200
Message-ID: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56149 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbZCRBXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:23:31 -0400
Received: by bwz17 with SMTP id 17so321490bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:23:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

This patch series is not doing much, just cleaning up the irq mailbox functions
and related stuff.

Among the sem-functional changes are:
 * 0010: avoid udelay and use time_after
 * 0015: print an error when timing out

Felipe Contreras (15):
  tidspbridge: remove revision history
  tidspbridge: trivial cleanup
  tidspbridge: remove unused stuff
  tidspbridge: remove IO_CALLDPC
  tidspbridge: whitespace cleanups
  tidspbridge: trivial cleanups
  tidspbridge: hDevContext == pDevContext
  tidspbridge: remove UTIL_Wait wrapper
  tidspbridge: cleanup and remove HW_MBOX_IsFull
  tidspbridge: remove udelay and use time_after instead
  tidspbridge: Remove IO_InterruptDSP
  tidspbridge: remove IO_InterruptDSP2
  tidspbridge: remove CHNLSM_InterruptDSP
  tidspbridge: remove wIntrVal2Dsp
  tidspbridge: print an error when timing out

 arch/arm/plat-omap/include/dspbridge/chnl_sm.h |   42 ----
 arch/arm/plat-omap/include/dspbridge/io_sm.h   |    3 -
 arch/arm/plat-omap/include/dspbridge/util.h    |   51 -----
 drivers/dsp/bridge/hw/hw_mbox.c                |   25 ---
 drivers/dsp/bridge/hw/hw_mbox.h                |   35 ----
 drivers/dsp/bridge/wmd/_tiomap.h               |   23 --
 drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    4 -
 drivers/dsp/bridge/wmd/_tiomap_util.h          |    1 -
 drivers/dsp/bridge/wmd/io_sm.c                 |   78 +-------
 drivers/dsp/bridge/wmd/tiomap3430.c            |   18 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   22 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c             |  260 +++++++-----------------
 12 files changed, 101 insertions(+), 461 deletions(-)

