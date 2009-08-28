From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] OMAP: misc. fixes for 2.6.32
Date: Fri, 28 Aug 2009 11:28:45 +0300
Message-ID: <1251448127-27336-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:39610 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZH1I2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 04:28:49 -0400
Received: by fxm17 with SMTP id 17so1427948fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 01:28:50 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Tony,

I pushed a couple more fixes to my pm-upstream/fixes-32 branch.  You've
already pulled this branch into your for-next, so a re-pull will get
you just these two additional patches.

Thanks,

Kevin


Reddy, Teerth (1):
  OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP

Vikram Pandita (1):
  OMAP: Zoom2: release debug board detect gpio line

 arch/arm/mach-omap2/board-3430sdp.c         |    6 ++++++
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++++---
 arch/arm/mach-omap2/mux.c                   |    5 +++++
 arch/arm/plat-omap/include/mach/mux.h       |    3 +++
 4 files changed, 18 insertions(+), 3 deletions(-)

