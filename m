From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
Date: Mon,  8 Jun 2009 16:08:10 -0500
Message-ID: <1244495293-17244-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34066 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755950AbZFHVCT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Jun 2009 17:02:19 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58L2DJa031516
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 16:02:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch series enables support for IVA and SECURE
WDTs, available on omap34xx.
For omap34xx devices the WDT will be accessible 
(when present) through:
SECURE:	       /dev/watchdog1
MPU:	       /dev/watchdog2
IVA:	       /dev/watchdog3

For devices older than omap34xx only MPU WDT is present
and will be accessible through /dev/watchdog

The series also fixes two bugs:

1) Correct timeout value is not loaded upon opening the
   watchdog device.

2) clks are not enabled when accessing registers in probe 

 b/arch/arm/mach-omap2/clock34xx.c |   12 ++---
 b/arch/arm/plat-omap/devices.c    |   79 ++++++++++++++++++++++++++++++--------
 b/drivers/watchdog/omap_wdt.c     |   42 ++++++++++++++++++----
 3 files changed, 112 insertions(+), 28 deletions(-)

