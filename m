From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/11] OMAP: hwmod: core patches for 2.6.37
Date: Tue, 21 Sep 2010 10:34:38 -0600
Message-ID: <20100921163021.20258.87587.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47013 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0IUQfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:35:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains hwmod core fixes and improvements, and is intended=
 for
merging via Tony's tree for 2.6.37.

The patches in this series are also available via git at

git://git.pwsan.com/linux-2.6 hwmod_2.6.37

based on v2.6.36-rc5.


regards,

- Paul

---

hwmod_2.6.37
   text    data     bss     dec      hex filename
6531587  455008 5615992 12602587  c04cdb vmlinux.omap2plus.orig
6533467  456160 5615992 12605619  c058b3 vmlinux.omap2plus.patched


Benoit Cousson (4):
      OMAP: hwmod: Rename dma_ch to dma_req
      OMAP: hwmod: Do not disable clocks if hwmod already in idle
      OMAP4: prcm: Add temporarily helper functions for rmw and read in=
side the PRM
      OMAP: hwmod: Force a softreset during _setup

Beno=C3=AEt Cousson (2):
      OMAP4: PRM: add module hard reset support
      OMAP: hwmod: Add hardreset management support

Kevin Hilman (1):
      OMAP: hwmod: separate list locking and hwmod hardware locking

Liam Girdwood (1):
      OMAP: hwmod: Fix omap_hwmod_reset wrong state test

Paul Walmsley (2):
      OMAP2/3: PRM: add module hard reset support
      OMAP: hwmod: add an hardreset API for use by other core code

Rajeev Kulkarni (1):
      OMAP4: prcm: Fix global warm reset bit position


 arch/arm/mach-omap2/Makefile                 |    4=20
 arch/arm/mach-omap2/omap_hwmod.c             |  348 ++++++++++++++++++=
++++----
 arch/arm/mach-omap2/prcm.c                   |   29 ++
 arch/arm/mach-omap2/prm.h                    |   18 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |  110 ++++++++
 arch/arm/mach-omap2/prm44xx.c                |  116 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   36 ++-
 arch/arm/plat-omap/include/plat/prcm.h       |    2=20
 8 files changed, 593 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/prm44xx.c

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
