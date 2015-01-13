From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Drop legacy support for omap3517
Date: Tue, 13 Jan 2015 09:57:41 -0800
Message-ID: <1421171865-5209-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50723 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751109AbbAMSBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 13:01:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

It seems we can now drop omap3517 legacy booting support to get
a bit closer to making all of omap3 boot in device tree only mode.

All these boards have at least minimal support for booting with
device tree, and pretty much anything supported with the legacy
board files can be configured also for device tree based booting
if not done already.

If anybody has issues booting 3517 with appended device tree,
please post the isssues to the mailing lists so we can promptly
fix those.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP3: Remove legacy support for am3517-evm
  ARM: OMAP3: Remove legacy support for am3517crane
  ARM: OMAP3: Remove cm-t3517 legacy support
  ARM: OMAP3: Remove legacy support for am35xx-emac

 arch/arm/mach-omap2/Kconfig                |  17 --
 arch/arm/mach-omap2/Makefile               |   8 -
 arch/arm/mach-omap2/am35xx-emac.c          | 114 ---------
 arch/arm/mach-omap2/am35xx-emac.h          |  15 --
 arch/arm/mach-omap2/am35xx.h               |  46 ----
 arch/arm/mach-omap2/board-am3517crane.c    | 150 ------------
 arch/arm/mach-omap2/board-am3517evm.c      | 373 -----------------------------
 arch/arm/mach-omap2/board-cm-t3517.c       | 335 --------------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  33 +--
 arch/arm/mach-omap2/pdata-quirks.c         |   1 -
 10 files changed, 2 insertions(+), 1090 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h
 delete mode 100644 arch/arm/mach-omap2/am35xx.h
 delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c
 delete mode 100644 arch/arm/mach-omap2/board-am3517evm.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

-- 
2.1.4

