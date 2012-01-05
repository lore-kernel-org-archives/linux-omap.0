From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family detection
Date: Wed,  4 Jan 2012 17:16:39 -0800
Message-ID: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57505 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757459Ab2AEBQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:16:48 -0500
Received: by mail-gy0-f170.google.com with SMTP id r1so12076ghr.15
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:16:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Currently, our SoC detection is based on SoC family detection
(using die ID) and the presence of specific IP blocks (or feature.)

This series begins the separation of the SoC family detection and
specific IP detection.

Applies on top of Tony's current master branch and so far, it has only
been compile tested using omap2plus_defconfig.

Kevin


Kevin Hilman (7):
  ARM: OMAP: remove unused cpu_is macros that depend on specific IP
    checks
  ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for
    UART4
  ARM: OMAP3: clock data: treat all AM35x devices the same
  ARM: OMAP: AM35x: remove redunant cpu_is checks for AM3505
  ARM: OMAP: clock: remove unused CK_3505 flag
  ARM: OMAP: remove unused cpu_is_omap3505()
  ARM: OMAP: remove unused cpu_is_omap3530()

 arch/arm/mach-omap2/clock3xxx_data.c          |   16 +-------------
 arch/arm/mach-omap2/hsmmc.c                   |    8 +++---
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h         |   26 +------------------------
 6 files changed, 10 insertions(+), 47 deletions(-)

-- 
1.7.8.2

