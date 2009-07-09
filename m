From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 0/2] watchdog:OMAP3:Add support for IVA2, SECURE WDTs
Date: Thu,  9 Jul 2009 13:04:21 -0500
Message-ID: <1247162663-27541-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33030 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZGIR62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 13:58:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wim@iguana.be
Cc: linux-omap@vger.kernel.org, Ulrik Bech Hald <ubh@ti.com>

This patch series enables support for IVA2 and SECURE
WDTs, available on omap34xx.
The WDTs will be accessible (when present on device) through:
MPU:	/dev/watchdog
SECURE:	/dev/watchdog_secure
IVA2:	/dev/watchdog_iva2

Tested on Zoom1 OMAP3 platform, compile-tested for OMAP2
Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
--- 
 arch/arm/mach-omap1/clock.c     |    6 +-
 arch/arm/mach-omap2/clock24xx.c |    4 -
 arch/arm/mach-omap2/clock34xx.c |   12 ++---
 arch/arm/plat-omap/devices.c    |   91 ++++++++++++++++++++++++++++++++--------
 drivers/watchdog/omap_wdt.c     |   34 +++++++++++---
 5 files changed, 112 insertions(+), 35 deletions(-)
