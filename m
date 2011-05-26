From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 0/4] OMAP: PM debug: remove register dump, misc cleanups
Date: Thu, 26 May 2011 16:02:47 -0700
Message-ID: <1306450971-27732-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58367 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756405Ab1EZW4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 18:56:42 -0400
Received: by mail-pz0-f51.google.com with SMTP id 26so523836pzk.10
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 15:56:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: p-titiano@ti.com

Inspired by Jean's work to move PM code to modules, I decided it's
time to remove a bunch of ugly and difficult to maintain code from PM
debug.

The main chunk here is removing the register dump features for
OMAP2/OMAP3 which are awful to read, and impossible to scale for
OMAP4+.  Also, there are now some userspace /dev/mem-based tools (like
omapconf) that can handle this type of thing much better, and with a
much better interface and display.

Series applies to v2.6.39.

Kevin Hilman (4):
  OMAP3: PM debug: remove sleep_while_idle feature
  OMAP2: PM debug: remove register dumping
  OMAP3: PM debug: remove register dumping
  OMAP2: PM debug: move wakeup timer into clockevent code

 arch/arm/mach-omap2/pm-debug.c            |  362 -----------------------------
 arch/arm/mach-omap2/pm.h                  |    9 -
 arch/arm/mach-omap2/pm24xx.c              |    6 +-
 arch/arm/mach-omap2/pm34xx.c              |    6 -
 arch/arm/mach-omap2/timer-gp.c            |   33 +++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 6 files changed, 32 insertions(+), 385 deletions(-)

-- 
1.7.4

