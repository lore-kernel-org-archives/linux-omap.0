From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/5] ARM: OMAP: Fix SPARSE_IRQ on OMAP4 - Episode I
Date: Thu, 23 Feb 2012 23:23:16 +0100
Message-ID: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab2BWWXb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 17:23:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

Here is a first, and incomplete, attempt to make OMAP4 SPARSE_IRQ friendly.
GPIO is still broken, and will be fixed later.

It is still not clear how we can get rid of the board IRQ configuration
properly without device tree. So the complete SPARSE_IRQ migration might
be achievable only when DT convertion will be done :-(

I started removing as well the IRQs definition header to start tracking
the bad drivers that still need to be cleaned or hwmod or DT adapted.

Regards,
Benoit


Benoit Cousson (5):
  ARM: OMAP2+: l3_noc: Remove references to static IRQ defines
  ARM: OMAP: irqs: Delete irqs-44xx.h file
  ARM: OMAP2+: wakeupgen: Fix wrong array size for irq_target_cpu
  ARM: OMAP2+: gpmc: Use irq_alloc_descs instead of static IRQ range
  ARM: OMAP: irqs: Set NR_IRQS to NR_IRQS_LEGACY for CONFIG_SPARSE_IRQ

 arch/arm/mach-omap2/gpmc.c                  |   22 +++--
 arch/arm/mach-omap2/omap-wakeupgen.c        |    4 +-
 arch/arm/mach-omap2/omap_l3_noc.c           |    6 +-
 arch/arm/plat-omap/include/plat/irqs-44xx.h |  144 ---------------------------
 arch/arm/plat-omap/include/plat/irqs.h      |   19 +++-
 5 files changed, 35 insertions(+), 160 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h

