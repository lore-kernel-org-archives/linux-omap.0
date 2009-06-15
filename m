From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 0/2] watchdog:OMAP3:Add support for IVA2, SECURE WDTs
Date: Mon, 15 Jun 2009 16:11:50 -0500
Message-ID: <1245100312-2312-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56861 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934391AbZFOVHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 17:07:10 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5FL77wX007170
	for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 16:07:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch series enables support for IVA2 and SECURE
WDTs, available on omap34xx.
The WDTs will be accessible (when present on device) through:
MPU:	/dev/watchdog
SECURE:	/dev/watchdog_secure
IVA:	/dev/watchdog_iva2

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
--- 
This patch set has a dependency on:
[PATCH 1/2] OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS
[PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload

 arch/arm/mach-omap2/clock34xx.c |   12 ++---
 arch/arm/plat-omap/devices.c    |   81 ++++++++++++++++++++++++++++++++--------
 drivers/watchdog/omap_wdt.c     |   51 +++++++++++++++++++++----
 3 files changed, 114 insertions(+), 30 deletions(-)



