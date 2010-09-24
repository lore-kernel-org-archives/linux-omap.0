From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [GIT PULL] omap: sram fixes and omap4 es2.0 support
Date: Fri, 24 Sep 2010 12:03:07 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD469D0D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39004 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412Ab0IXGdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 02:33:17 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
  Linus Torvalds (1):
        Linux 2.6.36-rc5

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap_for_2.6.37

David Anders (1):
      omap4: Panda: Add DEBUG_LL support

Santosh Shilimkar (3):
      omap4: Update id.c and cpu.h for es2.0
      omap4: l2x0: Fix init parameter for es2.0
      omap4: Fix bootup crash observed with higher CPU clocks

Vikram Pandita (2):
      omap: sram: fix is_sram_locked check
      omap4: sram: Fix start address

 arch/arm/mach-omap2/id.c                     |   38 +++++++++++++++++++++-----
 arch/arm/mach-omap2/omap4-common.c           |   10 +++++--
 arch/arm/plat-omap/dmtimer.c                 |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h        |    5 +++-
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 arch/arm/plat-omap/sram.c                    |   13 +-------
 6 files changed, 46 insertions(+), 23 deletions(-)

Regards,
Santosh
(As per thread: http://www.spinics.net/lists/linux-omap/msg37131.html)
