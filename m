From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
Date: Mon, 30 Apr 2012 16:37:08 -0700
Message-ID: <1335829030-19431-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37461 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756638Ab2D3XgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:36:11 -0400
Received: by pbcxa12 with SMTP id xa12so4980012pbc.37
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:36:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The detection of AM35xx SoCs is confusing and has redundancies.  Clean
this up so that SoC detection is only based on SoC family: AM35xx.

Kevin Hilman (2):
  ARM: OMAP: AM35xx: remove redunant cpu_is checks for AM3505
  ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx

 arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
 arch/arm/mach-omap2/id.c                      |    7 +++----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h         |    8 ++++++++
 7 files changed, 19 insertions(+), 12 deletions(-)

-- 
1.7.9.2

