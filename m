From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Omap fixes for 2.6.29-rc series, also one arm generic fix
Date: Wed, 28 Jan 2009 10:21:48 -0800
Message-ID: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52172 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZA1SVv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:21:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi,

Here are few more fixes for omap. The first patch in the series
"Do early I/O mapping if spinlock debugging is enabled" may also
help other platforms.

Regards,

Tony

---

Aaro Koskinen (1):
      ARM: OMAP: gptimer min_delta_ns corrected

Jarkko Nikula (1):
      ARM: OMAP: DMA: Fix uninitialized channel flags

Juha Yrjola (2):
      ARM: OMAP: Fix race in OMAP2/3 DMA IRQ handling
      ARM: Do early I/O mapping if spinlock debugging is enabled

Kevin Hilman (1):
      ARM: OMAP: fix fault in enter_full_retention()

Stanley.Miao (1):
      ARM: OMAP: Fix McBSP spin_lock deadlock

Tony Lindgren (2):
      ARM: OMAP: Fix hsmmc init
      ARM: OMAP: Fix omap34xx revision detection for ES3.1

=EA=B9=80=EA=B7=9C=EC=9B=90 (1):
      ARM: OMAP: Mask interrupts when disabling interrupts


 arch/arm/kernel/head.S                  |    2=20
 arch/arm/mach-omap1/mcbsp.c             |   98 ++-------------------
 arch/arm/mach-omap2/id.c                |    6 +
 arch/arm/mach-omap2/irq.c               |    6 +
 arch/arm/mach-omap2/mcbsp.c             |  145 +++++------------------=
--------
 arch/arm/mach-omap2/sleep24xx.S         |    3 -
 arch/arm/mach-omap2/timer-gp.c          |    3 -
 arch/arm/plat-omap/devices.c            |    8 +-
 arch/arm/plat-omap/dma.c                |    5 +
 arch/arm/plat-omap/include/mach/cpu.h   |    1=20
 arch/arm/plat-omap/include/mach/mcbsp.h |    6 +
 arch/arm/plat-omap/mcbsp.c              |   52 ++++++++---
 12 files changed, 104 insertions(+), 231 deletions(-)

--=20
Signature
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
