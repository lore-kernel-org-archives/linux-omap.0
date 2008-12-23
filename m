From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/22] Series short description
Date: Mon, 22 Dec 2008 23:38:26 -0700
Message-ID: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52852 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYLWGjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP clock: bug fixes, cleanup, optimization

Hello,

this 22-patch series updates the OMAP1/2/3 clock code.  Highlights:

- Rate recalculation functions are now no longer responsible for
  rate propagation - now handled by plat-omap/clock.c (patches 2, 3,
  4)

- Parent-to-child traversals of the clock tree are now much faster -
  these occur during rate propagation and clock notifiers (patch 5) 

- Many superfluous clock flags have been dropped (patches 6, 7, 8, 9)

- struct clk has been streamlined by removing unused members and
  rearranging the structure to reduce padding (patches 10, 11)

- MPU barriers have been either removed or converted to OCP barriers
  (patches 12, 13, 14)

- clk_get_usecount() has been dropped (patch 15)

- omap2_clk_enable() has been overhauled: two bugs were fixed and
  the function body itself is now understandable (patches 16, 17, 18,
  19, 20)

- Unnecessary custom clocks in smartreflex.c have been removed
  (patch 22)

- Miscellaneous bug fixes (patches 1, 21)


Compile-tested on OMAP1.  Boot-tested on N800 and 3430SDP GP ES2.1.


- Paul


---

size:
   text    data     bss     dec     hex filename
3582958  190280  108824 3882062  3b3c4e vmlinux.3430sdp.orig
3582501  190928  108824 3882253  3b3d0d vmlinux.3430sdp.patched


   text    data     bss     dec     hex filename
3167206  152232   86176 3405614  33f72e vmlinux.n800.orig
3167453  152784   86176 3406413  33fa4d vmlinux.n800.patched

diffstat:

 arch/arm/mach-omap1/clock.c             |   87 +++++++----
 arch/arm/mach-omap1/clock.h             |   64 ++++----
 arch/arm/mach-omap2/clock.c             |  151 ++++++++++---------
 arch/arm/mach-omap2/clock.h             |    8 +
 arch/arm/mach-omap2/clock24xx.c         |  125 ++++++++++------
 arch/arm/mach-omap2/clock24xx.h         |   89 ++++-------
 arch/arm/mach-omap2/clock34xx.c         |   47 +++---
 arch/arm/mach-omap2/clock34xx.h         |  228 +++++++++++------------------
 arch/arm/mach-omap2/pm-debug.c          |    2 
 arch/arm/mach-omap2/pm24xx.c            |    2 
 arch/arm/mach-omap2/smartreflex.c       |   89 ++---------
 arch/arm/plat-omap/clock.c              |  245 +++++++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/clock.h |   73 ++++++---
 13 files changed, 663 insertions(+), 547 deletions(-)


