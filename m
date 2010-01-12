From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/10] OMAP2/3/4 clockdomains/powerdomains: split shared
	dependencies and clean up - for 2.6.34
Date: Mon, 11 Jan 2010 18:05:31 -0700
Message-ID: <20100112010258.6275.97999.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45276 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab0ALBQU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:16:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

this series has already been posted on linux-omap, but is being
reposted here on linux-arm-kernel in case others wish to comment
before sending upstream to the for-next tree for 2.6.34 merging.

- Paul

---

Hi,

This series moves wakeup and sleep dependencies on the OMAP2/3 chips from
the powerdomain layer to the clockdomain layer, where they belong.  It also
adds usecounting for clockdomain dependency usecounting, which fixes the
obvious problem that occurs when several different pieces of code need
to add clockdomain dependencies, and then one removes the dependency.
(To add usecounting, the dependencies that were shared between
clockdomains have been split into separate records.)  These changes should
prepare the clockdomain code for OMAP4 clockdomain dependencies.

The series also does some cleanup.  struct powerdomain is packed, the
dead function pwrdm_clk_state_switch() is removed, documentation is improved,
the nonexistent MDM clockdomain is removed from OMAP2420.

Boot-tested on N800, 2430SDP, and OMAP3 Beagle.  Compile-tested with
omap_osk_5912_defconfig.

Applies on the 'for_2.6.34' branch of git://git.pwsan.com/linux-2.6


- Paul

---

   text    data     bss     dec     hex filename
3622921  198528  102984 3924433  3be1d1 vmlinux.beagle.orig
3623325  199168  102984 3925477  3be5e5 vmlinux.beagle

Paul Walmsley (10):
      OMAP2/3 clkdm/pwrdm: move wkdep/sleepdep handling from pwrdm to clkdm
      OMAP2/3 clockdomains: split shared structures so usecounting works
      OMAP2 clockdomain: modem clockdomain is only present on OMAP2430
      OMAP clockdomain/powerdomain: remove runtime register/unregister
      OMAP clockdomains: add usecounting for wakeup and sleep dependencies
      OMAP2/3/4 clockdomain: add clkdm_clear_all_{wkdep,sleepdep}s()
      OMAP powerdomain/PM: use symbolic constants for the max number of power states
      OMAP powerdomain: rearrange struct powerdomain to save some memory
      OMAP powerdomain: remove pwrdm_clk_state_switch
      OMAP clockdomain/powerdomain: improve documentation


 arch/arm/mach-omap2/clockdomain.c             |  691 +++++++++++++++++++------
 arch/arm/mach-omap2/clockdomains.h            |  474 +++++++++++++++++
 arch/arm/mach-omap2/io.c                      |    2 
 arch/arm/mach-omap2/omap_hwmod.c              |   10 
 arch/arm/mach-omap2/pm34xx.c                  |   10 
 arch/arm/mach-omap2/powerdomain.c             |  570 ++++-----------------
 arch/arm/mach-omap2/powerdomains.h            |   88 ---
 arch/arm/mach-omap2/powerdomains24xx.h        |   87 ---
 arch/arm/mach-omap2/powerdomains34xx.h        |  145 -----
 arch/arm/mach-omap2/prcm.c                    |   12 
 arch/arm/plat-omap/include/plat/clockdomain.h |   99 ++--
 arch/arm/plat-omap/include/plat/powerdomain.h |   78 +--
 arch/arm/plat-omap/include/plat/prcm.h        |    8 
 13 files changed, 1241 insertions(+), 1033 deletions(-)

