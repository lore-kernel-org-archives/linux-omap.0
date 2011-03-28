From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v4 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Mon, 28 Mar 2011 19:56:58 +0530
Message-ID: <1301322422-29886-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55903 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab1C1OcF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 10:32:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, tony@atomide.com

Patch series to support mstandby mode handling and enabling runtime PM
support for DMA driver.

Change History:
v4:
Fixed Paul's comment:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47359.html

v3:
Warning fix:
http://thread.gmane.org/gmane.linux.ports.arm.omap/54753/focus=55097

v2:
 - fixed runtime_status issue if channel linking feature is used.
 - fixed context restore issue during off mode.
 - removed sysconfig register access during DMA context/restore

The review comments and alignment can be found at:
http://thread.gmane.org/gmane.linux.ports.arm.omap/53150

Applies cleanly on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: omap-for-linus
commit  05f689400ea5fa3d71af82f910c8b140f87ad1f3
Merge branches 'devel-mux' and 'devel-misc' into omap-for-linus

Boot testing and dma test cases are executed on OMAP4430(Blaze).
More details on testing is available at:
http://article.gmane.org/gmane.linux.ports.arm.omap/54753

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
 arch/arm/plat-omap/omap_device.c              |   62 ++++++++
 8 files changed, 291 insertions(+), 33 deletions(-)

