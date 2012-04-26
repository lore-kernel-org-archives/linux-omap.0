From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family detection
Date: Thu, 26 Apr 2012 16:29:45 -0700
Message-ID: <1335482993-14035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:45774 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab2DZX3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 19:29:01 -0400
Received: by dadn15 with SMTP id n15so206084dad.30
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 16:29:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This is a rebased version of this series which is ready for broader
testing.  I'd especially appreciate testing from those of you with
AM35x platforms.

Currently, our SoC detection is based on SoC family detection
(using die ID) and the presence of specific IP blocks (or feature.)

This series begins the separation of the SoC family detection and
specific IP detection by completely removing IP detection from the SoC
family detection (cpu_is_*.)

Applies on top of v3.4-rc4, boot tested on AM3517 EVM.

Kevin

Kevin Hilman (8):
  ARM: OMAP: remove unused cpu_is macros that depend on specific IP
    checks
  ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for
    UART4
  ARM: OMAP3: clock data: treat all AM35x devices the same
  ARM: OMAP: AM35x: remove redunant cpu_is checks for AM3505
  ARM: OMAP: clock: remove unused CK_3505 flag
  ARM: OMAP: remove unused cpu_is_omap3505()
  ARM: OMAP: remove unused cpu_is_omap3530()
  ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx

 arch/arm/mach-omap2/clock3xxx_data.c          |   22 ++++----------
 arch/arm/mach-omap2/hsmmc.c                   |    8 ++---
 arch/arm/mach-omap2/id.c                      |    7 ++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +--
 arch/arm/plat-omap/include/plat/cpu.h         |   39 +++++--------------------
 9 files changed, 24 insertions(+), 64 deletions(-)

-- 
1.7.9.2

