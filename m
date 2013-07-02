From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 0/9] Consolidate AM335x and OMAP4 PRM/CM APIs
Date: Tue, 2 Jul 2013 16:58:09 +0530
Message-ID: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33015 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab3GBL3K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Even though there are differences in the PRCM features on different
TI SoCs (mostly OMAP3+) the underlying PRCM architecture is similar
on OMAP4+, AM335x, AM437x (and DM81xx). With some rework of the OMAP4
APIs we can easily consolidate the low level PRM/CM APIs for these
SoCs and cut down 800+ lines under mach-omap2.

These patches go on top of v3.10-rc7 (would rebase once 3.11-rc1 is out)
and have been boot tested on AM335x EVM. I have tried to ensure OMAP4+
is not affected but any testing on OMAP4+ would be helpful.

NOTE: The last patch which has the AM335x restart function would need
to be reworked since the OMAP4 code is moving to a different file.

Vaibhav Bedia (9):
  ARM: OMAP2+: AM335X: Add a constant CM_INST for all the clkdomains
  ARM: OMAP2+: CM code: Reintroduce SW_SLEEP for OMAP4 class of devices
  ARM: OMAP2+: AM335X: Add a constant PRCM_PARITION for the pwrdomains
  ARM: OMAP4: PRM: Get rid of hardcoded offsets
  ARM: OMAP4: Add offsets for pwrstctrl and pwrstst
  ARM: OMAP4: CM code: Remove the check for non-zero clkctrl_offs
  ARM: OMAP4: Generalize reset handling API
  ARM: OMAP2+: AM335x: Migrate to OMAP4 PRM/CM APIs
  ARM: OMAP2+: AM33XX: Get rid of custom PRM, CM APIs

 arch/arm/mach-omap2/Makefile                |   3 +-
 arch/arm/mach-omap2/am33xx-restart.c        |  34 ---
 arch/arm/mach-omap2/clockdomains33xx_data.c |  18 ++
 arch/arm/mach-omap2/cm33xx.c                | 364 ----------------------------
 arch/arm/mach-omap2/cm33xx.h                |  41 +---
 arch/arm/mach-omap2/cminst44xx.c            |  31 ++-
 arch/arm/mach-omap2/io.c                    |   3 +
 arch/arm/mach-omap2/omap4-common.c          |  14 ++
 arch/arm/mach-omap2/omap_hwmod.c            | 184 +-------------
 arch/arm/mach-omap2/powerdomains33xx_data.c |   6 +
 arch/arm/mach-omap2/powerdomains44xx_data.c |  32 +++
 arch/arm/mach-omap2/prm33xx.c               | 338 --------------------------
 arch/arm/mach-omap2/prm33xx.h               |  12 +-
 arch/arm/mach-omap2/prm44xx.c               |  45 ++--
 arch/arm/mach-omap2/prminst44xx.c           |  47 +++-
 arch/arm/mach-omap2/prminst44xx.h           |   6 +-
 16 files changed, 183 insertions(+), 995 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am33xx-restart.c
 delete mode 100644 arch/arm/mach-omap2/cm33xx.c
 delete mode 100644 arch/arm/mach-omap2/prm33xx.c

-- 
1.8.1

