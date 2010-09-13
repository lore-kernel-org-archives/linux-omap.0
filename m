From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] idle-path reorg for interrupt-enabled runtime PM
Date: Mon, 13 Sep 2010 16:02:36 -0700
Message-ID: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41384 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0IMXCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 19:02:43 -0400
Received: by yxp4 with SMTP id 4so2199422yxp.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Sep 2010 16:02:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, p-basak2@ti.com, Tero Kristo <tero.kristo@nokia.com>

From: Kevin Hilman <khilman@ti.com>

This series is a cleanup/reorg/streamline of the core idle path.

The goal is to remove all device-specific idle management out of the
core idle path into device-specific code.  

This series starts with some of the device-specific hacks currently in
the idle path, and also moves GPIO handling out of the core idle loop.

Eventually, all device-specific idle management should be done using
the runtime PM hooks of the driver for that device.  Until then,
temporary hacks belong in the new omap3_device_[idle|resume] functions.

Note that for debug purposes, UART is still managed inside the
interrupt-disabled idle path.  This is for debug purposes only so that
any panic/BUG code that gets triggered before the device resume code
is run will not crash the system.  As soon as the new omap-serial
driver is converted to runtime PM, the UART management can be removed
from the idle path as well.

Patch 1 will be queued in my pm-next branch for .37 and patch 2 should
be incorporated into baseline for the GPIO hwmod conversion.

Kevin Hilman (2):
  OMAP3: PM: move device-specific special cases from PM core into
    CPUidle
  OMAP2+: GPIO: move late PM out of interrupts-disabled idle path

 arch/arm/mach-omap2/cpuidle34xx.c      |   54 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm.h               |    2 +
 arch/arm/mach-omap2/pm24xx.c           |    2 +-
 arch/arm/mach-omap2/pm34xx.c           |   48 ++++++++------------------
 arch/arm/plat-omap/gpio.c              |   57 ++++++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/gpio.h |    4 +--
 6 files changed, 113 insertions(+), 54 deletions(-)

-- 
1.7.2.1

