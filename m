From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH pm-wip/uart 0/4] misc. fixes for IDLEST and OMAP24xx support
Date: Wed, 26 May 2010 16:05:11 -0700
Message-ID: <1274915115-28355-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36727 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0EZXFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 19:05:22 -0400
Received: by pwi7 with SMTP id 7so430965pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 16:05:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series on top of my pm-wip/uart branch fixes up various issues
with UART hwmods for 24xx as well as IDLEST issues after Benoit's
fixes/cleanup series.

Tested on OMAP3 (omap3evm) and OMAP2 (n810/2420).

Note that for OMAP2, this recently posted patch is required as well:

  [PATCH] OMAP24xx: CM: fix mask used for checking IDLEST status

These ares posted as FYI, and will be folded into the original hwmod
data for OMAP2+ UARTs.

Kevin


Kevin Hilman (4):
  OMAP3: hwmod: UART: add module offs
  OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
  OMAP2420: hwmod: UART3 needs prcm_reg_id = 2
  24xx: need .module_offs = CORE_MOD

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   14 ++++++++++----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    9 ++++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   15 +++++++++++----
 3 files changed, 27 insertions(+), 11 deletions(-)

