From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] OMAP: pm-next: few more PM updates for 2.6.37
Date: Thu, 23 Sep 2010 11:18:52 -0700
Message-ID: <1285265935-3477-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60092 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0IWSS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 14:18:57 -0400
Received: by pwj6 with SMTP id 6so369189pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 11:18:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Here area few more PM updates targetted for 2.6.37.

These are added to the pm-next brach available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next

Benoit Cousson (2):
  OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
  OMAP4: pm: Change l3_main to l3_main_1 during bus device init

Kevin Hilman (1):
  OMAP: GPIO: ensure debounce clocks are disabled during idle/suspend

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/io.c                     |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  482 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                     |    7 +-
 arch/arm/plat-omap/Makefile                  |    2 +-
 arch/arm/plat-omap/gpio.c                    |    6 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 7 files changed, 498 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_44xx_data.c

-- 
1.7.2.1

