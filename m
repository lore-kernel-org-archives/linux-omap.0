From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/4] ARM: l2x0: Optimisation and minor cleanup
Date: Sat, 31 Jul 2010 23:13:46 +0530
Message-ID: <1280598226-4317-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45587 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab0GaRoM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Jul 2010 13:44:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch series is generated against latest mainline + Thomas's
earlier kexec series.
	http://www.spinics.net/lists/arm-kernel/msg92095.html
	
[PATCH 1/4] ARM: l2x0: Fix coding-style in the cache-l2x0.h
	- Small clean up in cache-l2x0.h
[PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
	- Override the generic l2x0_disable with omap4 specific fn
[PATCH 3/4] ARM: l2x0: Determine the cache size
	- Calculate the total L2 cache size
[PATCH 4/4] ARM: l2x0: Optmise the range based operations
	- Speedup cache operations for bigger buffers	
	
Santosh Shilimkar (4):
  ARM: l2x0: Fix coding-style in the cache-l2x0.h
  omap4: l2x0: Override the default l2x0_disable
  ARM: l2x0: Determine the cache size
  ARM: l2x0: Optmise the range based operations

 arch/arm/include/asm/hardware/cache-l2x0.h |    9 ++-
 arch/arm/mach-omap2/omap4-common.c         |   13 ++++
 arch/arm/mm/cache-l2x0.c                   |  108 ++++++++++++++++++----------
 3 files changed, 88 insertions(+), 42 deletions(-)

