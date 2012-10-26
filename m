From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] ARM: OMAP: fix build, sparse problems in cleanup-headers
Date: Fri, 26 Oct 2012 14:08:24 -0600
Message-ID: <20121026200413.16521.88985.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40887 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966288Ab2JZUJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:09:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fix several build failures and a sparse warning in the linux-omap
omap-for-v3.8/cleanup-headers branch.  

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/cleanup-headers-compile-fixes-3.8/20121026132711/

Due to underlying problems in v3.7-rc2, several tests fail.  The
failures are unrelated to these patches.

Intended for 3.8 cleanup.

- Paul

---

cleanup-headers-compile-fixes-3.8
   text	   data	    bss	    dec	    hex	filename
5452826	 352260	 121588	5926674	 5a6f12	vmlinux.omap1_defconfig.orig
5452826	 352260	 121588	5926674	 5a6f12	vmlinux.omap1_defconfig

Paul Walmsley (3):
      ARM: OMAP2+: fix build breakage introduced by commit b7754452b3e27716347a528b47b0a1083af32520
      ARM: OMAP1: fix build breakage introduced by commit 25c7d49ed48b4843da7dea56a81ae7f620211ee0
      ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3


 arch/arm/mach-omap1/fpga.c   |    1 +
 arch/arm/mach-omap1/pm_bus.c |    2 ++
 drivers/mtd/onenand/omap2.c  |   36 ++++++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 12 deletions(-)

