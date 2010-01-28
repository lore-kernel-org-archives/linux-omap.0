From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] misc. multi-omap compile fixes
Date: Thu, 28 Jan 2010 09:17:12 -0800
Message-ID: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54167 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219Ab0A1RRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:17:19 -0500
Received: by pwi21 with SMTP id 21so625474pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:17:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series fixes a few things preventing compile of omap3_defconfig
and also cleans up several new compiler warnings that were introduced.

Kevin Hilman (4):
  OMAP2/3: IRQ: ensure valid base address
  OMAP2/3: GPMC: ensure valid clock pointer
  OMAP2: clock: fix misc. OMAP24xx compile issues
  OMAP2/3: PRCM: fix misc. compiler warnings

 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    8 ++++----
 arch/arm/mach-omap2/clock2xxx_data.c         |    2 +-
 arch/arm/mach-omap2/gpmc.c                   |    5 ++++-
 arch/arm/mach-omap2/irq.c                    |    4 +++-
 arch/arm/mach-omap2/prcm.c                   |    4 +++-
 5 files changed, 15 insertions(+), 8 deletions(-)

