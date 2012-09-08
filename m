From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] ARM: OMAP2+: clean up the Makefile
Date: Fri, 07 Sep 2012 18:39:36 -0600
Message-ID: <20120908002614.4648.31150.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59123 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab2IHAlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 20:41:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This series, intended for 3.7 cleanup, cleans up the Makefile in
arch/arm/mach-omap2.  It places PRCM-related lines in the PRCM
sections, clock lines in the clock sections, etc.; and fixes some
formatting and whitespace.  This is meant to serve as a base for
future cleanups to avoid conflicts as lines get removed.

Boot and build test logs can be found at:

    http://www.pwsan.com/omap/testlogs/makefile_cleanup_3.7/20120905143119/


- Paul

---

object size (delta in bytes from test_v3.6-rc4 (4cbe5a555fa58a79b6ecbb6c531b8bab0650778d)):
  text    data     bss   total  kernel
     0       0       0       0  2430_testconfig
     0       0       0       0  5912osk_testconfig
     0       0       0       0  am33xx_testconfig
    +8       0       0      +8  n800_b_testconfig
    +8       0       0      +8  n800_multi_omap2xxx
    +8       0       0      +8  n800_testconfig
     0       0       0       0  omap1510_defconfig
     0       0       0       0  omap1_defconfig
   +32       0       0     +32  omap2_4_testconfig
    +8       0       0      +8  omap2plus_defconfig
   +16       0       0     +16  omap2plus_no_pm
    -8       0       0      -8  omap3_4_testconfig
   -56       0       0     -56  omap3_testconfig
     0       0       0       0  omap4_testconfig
     0       0       0       0  rmk_omap3430_ldp_oldconfig
     0       0       0       0  rmk_omap4430_sdp_oldconfig

Paul Walmsley (6):
      ARM: OMAP2+: clean up whitespace in Makefile
      ARM: OMAP2+: clean up omap_hwmod.o build directives in Makefile
      ARM: OMAP2+: move MPU INTCPS, secure monitor, SDRC build directives in Makefile
      ARM: OMAP2+: clean up OMAP4 PRM & sleep build directives in Makefile
      ARM: OMAP2+: clean up OMAP clock Makefile sections
      ARM: OMAP2+: clean up PRCM sections of the Makefile


 arch/arm/mach-omap2/Makefile |  108 +++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 64 deletions(-)

