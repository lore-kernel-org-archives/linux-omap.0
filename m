From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] omap fixes for 2.6.33-rc6
Date: Tue, 02 Feb 2010 18:25:51 -0800
Message-ID: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59188 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335Ab0BCCZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Kevin Hilman (2):
      OMAP2/3: IRQ: ensure valid base address
      OMAP2/3: GPMC: ensure valid clock pointer

Marek Skuczynski (1):
      omap: Fix access to already released memory in clk_debugfs_regist=
er_one()

Sriram (1):
      ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP

Tony Lindgren (4):
      omap: Remove old unused defines for OMAP_32KSYNCT_BASE
      omap: Fix 3630 mux errors
      omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
      omap: Disable serial port autoidle by default

Uwe Kleine-K=C3=B6nig (1):
      omap: define _toggle_gpio_edge_triggering only for OMAP1


 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-omap2/gpmc.c       |    5 +++-
 arch/arm/mach-omap2/irq.c        |    4 ++-
 arch/arm/mach-omap2/mux.c        |   10 +++++++-
 arch/arm/mach-omap2/mux34xx.c    |   47 ++++++++++++++++++++++++++++++=
++++++++
 arch/arm/mach-omap2/serial.c     |    8 ++++++
 arch/arm/plat-omap/clock.c       |    4 ++-
 arch/arm/plat-omap/gpio.c        |    4 ++-
 arch/arm/plat-omap/omap_device.c |   10 --------
 9 files changed, 75 insertions(+), 18 deletions(-)

--=20
Signature
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
