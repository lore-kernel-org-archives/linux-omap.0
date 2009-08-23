From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 0/7] OMAP3: PM debug infrastructure
Date: Mon, 24 Aug 2009 00:32:19 +0300
Message-ID: <1251063146-9255-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35606 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbZHWVc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 17:32:28 -0400
Received: by ewy3 with SMTP id 3so1908394ewy.18
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 14:32:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

updates from v1
- update 'Add PRCM register dump support' to use SoC specific
  registers.  Currenly only OMAP3 supported.
- drop debug observability support for now, needs some updates as pointed
  out by Tony

Peter 'p2' De Schrijver (5):
  OMAP: PM counter infrastructure.
  OMAP: PM: Hook into PM counters
  OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
  OMAP: PM: Add pm-debug counters
  OMAP: PM debug: make powerdomains use PM-debug counters

Tero Kristo (2):
  OMAP: PM debug: Add PRCM register dump support
  OMAP: PM: Added suspend target state control to debugfs for OMAP3

 arch/arm/mach-omap2/clock.c                   |    2 +
 arch/arm/mach-omap2/clockdomain.c             |   10 +-
 arch/arm/mach-omap2/pm-debug.c                |  429 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                      |   11 +
 arch/arm/mach-omap2/pm24xx.c                  |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |   38 ++-
 arch/arm/mach-omap2/powerdomain.c             |  110 ++++++-
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/powerdomain.h |   15 +-
 9 files changed, 607 insertions(+), 15 deletions(-)

