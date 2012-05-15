From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/3] GPMC NAND isr using standard API
Date: Tue, 15 May 2012 20:08:09 +0530
Message-ID: <cover.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49264 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156Ab2EOOyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 10:54:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, dedekind1@gmail.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

Hi Tony, Artem,

This series creates a fictitious GPMC interrupt chip and provide the
clients with interrupts that could be handled using standard APIs.
This helps in removing the requirement of driver of peripheral
connected to GPMC having the knowledge about GPMC. The only user is
OMAP NAND driver, it has also been modified to use interrupts provided
by imaginary GPMC chip.

This series has a dependency on [2], while [2] has a trivial
dependency on [1].

With this series plus [1,2], GPMC driver conversion which is going to
happen shortly will not create noticable effect outside of
arch/arm/*omap*/.

If this series along with [1,2] can be taken in for 3.5, ripples felt
by MTD drivers upon GPMC driver conversion would be minimal.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68581.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68652.html


Afzal Mohammed (3):
  ARM: OMAP2+: gpmc: Modify interrupt handling
  ARM: OMAP2+: gpmc-nand: Modify Interrupt handling
  mtd: nand: omap2: use gpmc provided irqs

 arch/arm/mach-omap2/gpmc-nand.c        |   28 +++++--
 arch/arm/mach-omap2/gpmc.c             |  137 ++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 drivers/mtd/nand/omap2.c               |   70 +++++++++-------
 4 files changed, 185 insertions(+), 51 deletions(-)

-- 
1.7.10

