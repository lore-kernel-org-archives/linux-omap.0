From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] misc. OMAP PM core updates for 2.6.38
Date: Tue, 21 Dec 2010 14:56:21 -0800
Message-ID: <877hf2wx9m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62032 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0LUW40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 17:56:26 -0500
Received: by iwn9 with SMTP id 9so4713458iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 14:56:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Here's my collection of misc. PM core updates for 2.6.38.  The bulk of
this is the idle/errata fixups from Nishanth and the idle code cleanup
from Jean Pihet.

Kevin


The following changes since commit 90a8a73c06cc32b609a880d48449d7083327e11a:

  Linux 2.6.37-rc7 (2010-12-21 11:26:40 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next

Eduardo Valentin (1):
      OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2

Jean Pihet (8):
      OMAP2+: disable idle early in the suspend sequence
      OMAP3: remove unused code from the ASM sleep code
      OMAP2+: use global values for the SRAM PA addresses
      OMAP3: remove hardcoded values from the ASM sleep code
      OMAP3: re-organize the ASM sleep code
      OMAP3: rework of the ASM sleep code execution paths
      OMAP3: add comments for low power code errata
      OMAP3: ASM sleep code format rework

Nishanth Menon (3):
      OMAP3: pm: introduce errata handling
      OMAP3630: PM: Erratum i608: disable RTA
      OMAP3: PM: make omap3_cpuidle_update_states independent of enable_off_mode

Peter 'p2' De Schrijver (2):
      OMAP3: PM: Erratum i581 support: dll kick strategy
      OMAP3630: PM: Disable L2 cache while invalidating L2 cache

Richard Woodruff (1):
      OMAP3: PM: Update clean_l2 to use v7_flush_dcache_all

Thara Gopinath (1):
      OMAP: pm.c correct the initcall for an early init.

 arch/arm/mach-omap2/control.c          |   22 +-
 arch/arm/mach-omap2/control.h          |    9 +-
 arch/arm/mach-omap2/cpuidle34xx.c      |   36 +-
 arch/arm/mach-omap2/pm.c               |    2 +-
 arch/arm/mach-omap2/pm.h               |   15 +-
 arch/arm/mach-omap2/pm24xx.c           |   16 +-
 arch/arm/mach-omap2/pm34xx.c           |   66 ++-
 arch/arm/mach-omap2/pm44xx.c           |   16 +-
 arch/arm/mach-omap2/sdrc.h             |    1 -
 arch/arm/mach-omap2/sleep34xx.S        |  832 ++++++++++++++++++--------------
 arch/arm/plat-omap/include/plat/sram.h |   11 +
 arch/arm/plat-omap/sram.c              |    7 +-
 12 files changed, 597 insertions(+), 436 deletions(-)
