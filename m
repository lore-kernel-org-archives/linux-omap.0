From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: OMAP3+ DMA and Device ID Fixes
Date: Thu, 1 Mar 2012 19:10:12 -0600
Message-ID: <1330650612-10854-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51184 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab2CBBKQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Mar 2012 20:10:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, manjugk@ti.com, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Here are a couple minor OMAP3+ fixes I stumbled across.

Jon Hunter (2):
  ARM: OMAP: DMA: Fix DMA channel end definition for OMAP36xx-PLUS
    devices
  ARM: OMAP: Remove definition cpu_is_omap4430()

 arch/arm/mach-omap2/dma.c             |    4 ++--
 arch/arm/plat-omap/include/plat/cpu.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

