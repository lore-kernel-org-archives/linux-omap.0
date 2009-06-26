From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH v5 0/2] watchdog:OMAP3:Add support for IVA2, SECURE WDTs
Date: Fri, 26 Jun 2009 16:07:06 -0500
Message-ID: <1246050428-29817-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbZFZVBt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jun 2009 17:01:49 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5QL1lkp027211
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 16:01:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch series enables support for IVA2 and SECURE
WDTs, available on omap34xx.
The WDTs will be accessible (when present on device) through:
MPU:	/dev/watchdog
SECURE:	/dev/watchdog_secure
IVA2:	/dev/watchdog_iva2

Tested on Zoom1 OMAP3 platform, compile-tested for OMAP2
Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
--- 
This patch set has a dependency on:
runtime: [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload

 arch/arm/mach-omap1/clock.c     |    6 +-
 arch/arm/mach-omap2/clock24xx.c |    4 -
 arch/arm/mach-omap2/clock34xx.c |   12 ++---
 arch/arm/plat-omap/devices.c    |   91 ++++++++++++++++++++++++++++++++--------
 drivers/watchdog/omap_wdt.c     |   34 +++++++++++---
 5 files changed, 112 insertions(+), 35 deletions(-)
