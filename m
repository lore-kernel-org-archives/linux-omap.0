From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v2 0/3] ARM: omap: Thumb-2 kernel compatibility fixes
Date: Mon,  6 Dec 2010 17:35:34 +0000
Message-ID: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44264 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0LFRgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:36:10 -0500
Received: by wyb28 with SMTP id 28so12260626wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 09:36:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Tony Lindgren <tony@atomide.com>

These patches enable the omap kernel to build and work in
Thumb-2 (CONFIG_THUMB2_KERNEL).

They may make useful reading for all low-level BSP maintainers,
since in general similar issues tend to crop up whenever migrating
code to support Thumb-2.

Tested on: omap3 (Beagle xM A2)
Not tested on any other platforms yet.

Dave Martin (3):
  ARM: omap: Enable low-level omap3 PM code to work with
    CONFIG_THUMB2_KERNEL
  ARM: omap4: Correct definition of do_wfi() for CONFIG_THUMB2_KERNEL
  ARM: omap4: Convert END() to ENDPROC() for correct linkage with
    CONFIG_THUMB2_KERNEL

 arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++
 arch/arm/mach-omap2/omap-headsmp.S              |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S              |    8 ++--
 arch/arm/mach-omap2/pm.h                        |    2 +
 arch/arm/mach-omap2/pm34xx.c                    |   13 ++++++--
 arch/arm/mach-omap2/sleep34xx.S                 |   37 +++++++++++++++++++++--
 arch/arm/mach-omap2/sram34xx.S                  |   34 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/sram.h          |    1 +
 arch/arm/plat-omap/sram.c                       |   10 +++++-
 9 files changed, 90 insertions(+), 22 deletions(-)

