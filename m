From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Thu, 18 Nov 2010 19:54:45 -0600
Message-ID: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab0KSBzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Bunch of fixes as part of phase 1 targetting mainly OMAP3630 HS devices
for OFF mode logic.

It is important to note - for proper functionality of HS OFF mode on OMAP3630,
   CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE=y and
   CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID should be set to the correct
   service that the security PPA supports on the platform.

Based on kernel.org 2.6.37-rc2 tag

Smoke tested on:
SDP3630 -GP
Zoom3 (3630): GP & EMU (Es1.1, ES1.2)
SDP3430 - GP & EMU (ES3.1)

These are fixes for corner case bugs seen, so tests of off and ret done with
wakeup timer - behavior between 2.6.37-rc2 before and after applying patch
seen consistent.

Request for testing this series for comparison between master and this
series requested for additional platforms where available.

Archana Sriram (1):
  OMAP3: PM: Errata i582: per domain reset issue: uart

Eduardo Valentin (3):
  OMAP3: PM: Deny MPU idle while saving secure RAM
  OMAP3: PM: Apply errata i540 before save secure ram
  OMAP3630: PM: Errata i583: disable coreoff if < ES1.2

Nishanth Menon (3):
  OMAP3: PM: make secure ram save size configurable
  OMAP3: PM: Fix secure save size for OMAP3
  OMAP3630: PM: Errata i608: disable RTA

Peter 'p2' De Schrijver (2):
  OMAP3: PM: Errata i581 suppport: dll kick strategy
  OMAP3630: PM: Disable L2 cache while invalidating L2 cache

Richard Woodruff (1):
  OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all

Tero Kristo (3):
  OMAP3: PM: Save secure RAM context before entering WFI
  OMAP3: PM: optional save secure RAM context every core off cycle
  OMAP3: PM: allocate secure RAM context memory from low-mem

 arch/arm/mach-omap2/control.c            |    5 +-
 arch/arm/mach-omap2/control.h            |    5 +
 arch/arm/mach-omap2/io.c                 |   11 ++
 arch/arm/mach-omap2/pm.h                 |   40 +++++++
 arch/arm/mach-omap2/pm34xx.c             |  184 ++++++++++++++++++++++++-----
 arch/arm/mach-omap2/serial.c             |   80 +++++++++++++
 arch/arm/mach-omap2/sleep34xx.S          |  187 ++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/serial.h |    4 +
 8 files changed, 412 insertions(+), 104 deletions(-)

Regards,
Nishanth Menon
