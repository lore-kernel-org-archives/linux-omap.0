From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Remove some dead code for omaps
Date: Tue, 19 Nov 2013 08:31:23 -0800
Message-ID: <1384878685-1515-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab3KSQb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 11:31:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

I noticed we have some dead code left over after we made omap4
to boot in device tree only mode, so let's just remove it.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Remove legacy mux code for display.c
  ARM: OMAP2+: Remove legacy omap4_twl6030_hsmmc_init

 arch/arm/mach-omap2/common.h       |  1 -
 arch/arm/mach-omap2/display.c      | 78 --------------------------------------
 arch/arm/mach-omap2/omap4-common.c | 57 ----------------------------
 3 files changed, 136 deletions(-)

-- 
1.8.1.1

