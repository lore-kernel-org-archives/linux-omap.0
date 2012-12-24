From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] ARM: OMAP: resolve sparse warnings with v3.8-rc1
Date: Sun, 23 Dec 2012 18:24:56 -0700
Message-ID: <20121224012304.13698.43551.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57200 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2LXB1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 20:27:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Another minor release, another new set of sparse warnings.  It would
be good if patch submitters and mainline committers can verify that
new patches don't add sparse warnings.  Otherwise it makes it harder
for others to verify that their code is sparse-warning-free.

- Paul

---

sparse_fixes_a_3.8-rc
   text	   data	    bss	    dec	    hex	filename
7697036	 722268	5614832	14034136	 d624d8	vmlinux.omap2plus_defconfig.orig
7697036	 722268	5614832	14034136	 d624d8	vmlinux.omap2plus_defconfig

Paul Walmsley (3):
      ARM: OMAP: 32k counter: resolve sparse warnings
      ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
      ARM: OMAP: SRAM: resolve sparse warnings


 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++-
 arch/arm/plat-omap/counter_32k.c           |    2 ++
 arch/arm/plat-omap/counter_32k.h           |   20 ++++++++++++++++
 arch/arm/plat-omap/sram.c                  |    2 ++
 arch/arm/plat-omap/sram.h                  |   35 ++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-omap/counter_32k.h
 create mode 100644 arch/arm/plat-omap/sram.h

