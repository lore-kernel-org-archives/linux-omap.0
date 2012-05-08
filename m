From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: Misc cleanup
Date: Tue, 8 May 2012 12:44:19 +0530
Message-ID: <1336461259-28596-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51618 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab2EHHO1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 03:14:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Please pull the following preparatory cleanup series to add OMAP5 minimal
support. Boot tested on OMAP2430 SDP, OMAP3430 SDP and OMAP4430 SDP platforms.

I have dropped {[PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function}
from this set since Paul is taking that one in his queue.

P.S: While merging this series with linux-omap master, I saw one trivial
Makefile conflict.

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3.5/omap_misc_cleanup

R Sricharan (1):
      ARM: OMAP2+: dma: Define dma capabilities register bitfields and use them.

Santosh Shilimkar (6):
      ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4 only builds.
      ARM: OMAP2+: Clean up wrapping multiple objects in Makefile
      ARM: OMAP4: Remove un-used WakeupGen register defines.
      ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future patching.
      ARM: All OMAP2PLUS machines use omap2 directory so just add one entry
      ARM: OMAP4: Reduce the static IO mapping

 arch/arm/Makefile                                 |    4 +-
 arch/arm/mach-omap2/Makefile                      |  163 ++++++++++-----------
 arch/arm/mach-omap2/dma.c                         |   11 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    8 -
 arch/arm/mach-omap2/io.c                          |   30 ----
 arch/arm/mach-omap2/iomap.h                       |   28 ----
 arch/arm/plat-omap/dma.c                          |    4 +-
 arch/arm/plat-omap/include/plat/dma.h             |    5 +
 8 files changed, 93 insertions(+), 160 deletions(-)

Regards
Santosh
