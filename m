From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 0/3] first pass at core PM sync-up
Date: Tue,  3 Feb 2009 18:03:46 -0800
Message-ID: <1233713029-14904-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:20893 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBDCDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 21:03:54 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2575471wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 18:03:53 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The linux-omap tree has long carried some core PM code that has never
gone upstream.  This is a first pass to get a base PM core upstream,
so that the PM branch can be pushed next.  

This code has been touched by many folks, and it's impossible to give
credit to everyone, but I tried to mention significant contributions
in the patch headers.  Please let me know if I missed anyone.

This series currently applies on top of the large clock update series
sent by Paul Walmsley.  I will rebase onto RMKs clock merge when
it is ready and available.

Paul's series is in the 'staging/paul-clock1' branch of my
linux-omap-pm git repo.  This series is pushed on top of that
in the 'staging/pm-upstream' branch.  

Kevin


Jouni Hogander (1):
  OMAP: Add new function to check wether there is irq pending

Kalle Jokiniemi (1):
  OMAP3: PM: SmartReflex driver integration

Kevin Hilman (1):
  OMAP2/3: PM: push core PM code from linux-omap

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/irq.c                  |   17 +-
 arch/arm/mach-omap2/pm-debug.c             |  157 ++++++
 arch/arm/mach-omap2/pm.c                   |  154 +++---
 arch/arm/mach-omap2/pm.h                   |   32 ++
 arch/arm/mach-omap2/pm24xx.c               |  545 ++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c               |  695 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h     |   20 +-
 arch/arm/mach-omap2/sleep34xx.S            |  544 ++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.c          |  762 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h          |  259 ++++++++++
 arch/arm/plat-omap/Kconfig                 |   31 ++
 arch/arm/plat-omap/include/mach/control.h  |   18 +
 arch/arm/plat-omap/include/mach/irqs.h     |    1 +
 arch/arm/plat-omap/include/mach/omap34xx.h |    3 +-
 arch/arm/plat-omap/include/mach/pm.h       |   77 +---
 16 files changed, 3169 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/smartreflex.h

