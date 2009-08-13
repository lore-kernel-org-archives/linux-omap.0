From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/10] OMAP PM debug infrastructure for 2.6.32
Date: Thu, 13 Aug 2009 09:52:29 -0700
Message-ID: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:49955 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbZHMQwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 12:52:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This series adds the PM debug infrastructure which is
currently used in the OMAP PM branch[1].

Applies on v2.6.31-rc5 plus previous PM fixes queue:

  [PATCH 00/14] OMAP PM fixes for .31-rc series

Kevin

[1] http://elinux.org/OMAP_Power_Management

Peter 'p2' De Schrijver (8):
  OMAP: PM counter infrastructure.
  OMAP: PM: Hook into PM counters
  OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
  OMAP: PM: Add pm-debug counters
  OMAP: PM debug: make powerdomains use PM-debug counters
  OMAP: PM: Add definitions for ETK pads and observability registers
  OMAP3: Debug observability and ETK padconf implementation
  OMAP3: Add debug observablity (debobs) Kconfig item

Tero Kristo (2):
  OMAP: PM debug: Add PRCM register dump support
  OMAP: PM: Added suspend target state control to debugfs for OMAP3

 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/clock.c                   |    2 +
 arch/arm/mach-omap2/clockdomain.c             |   10 +-
 arch/arm/mach-omap2/debobs.c                  |  240 ++++++++++++++
 arch/arm/mach-omap2/pm-debug.c                |  413 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                      |   11 +
 arch/arm/mach-omap2/pm24xx.c                  |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |   38 ++-
 arch/arm/mach-omap2/powerdomain.c             |  110 +++++++-
 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/control.h     |   47 +++-
 arch/arm/plat-omap/include/mach/debobs.h      |    7 +
 arch/arm/plat-omap/include/mach/powerdomain.h |   15 +-
 14 files changed, 893 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debobs.c
 mode change 100644 => 100755 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/plat-omap/include/mach/debobs.h

