From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Thu, 24 Mar 2011 07:00:15 +0530
Message-ID: <1300930219-23160-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab1CXBeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Mar 2011 21:34:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com

This series is same as v2 series:
http://article.gmane.org/gmane.linux.ports.arm.omap/54753
except one warning fix:
http://thread.gmane.org/gmane.linux.ports.arm.omap/54753/focus=55097

Applies cleanly on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: omap-for-linus
commit	05f689400ea5fa3d71af82f910c8b140f87ad1f3
Merge branches 'devel-mux' and 'devel-misc' into omap-for-linus

G, Manjunath Kondaiah (4):
  OMAP2+: PM: omap device: API's for handling mstandby mode
  OMAP2+: DMA: prevent races while setting M idle mode to nostandby
  OMAP: PM: DMA: Enable runtime pm
  OMAP: DMA: Fix: context restore during off mode

 arch/arm/mach-omap1/dma.c                     |    1 +
 arch/arm/mach-omap2/dma.c                     |   16 ++
 arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
 arch/arm/plat-omap/dma.c                      |  196 +++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/dma.h         |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
 arch/arm/plat-omap/omap_device.c              |   64 ++++++++
 8 files changed, 293 insertions(+), 33 deletions(-)

