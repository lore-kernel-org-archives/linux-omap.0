From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP3 clock: add DPLL enable, disable, autoidle control
Date: Thu, 03 Apr 2008 19:09:41 -0600
Message-ID: <20080404010941.510844152@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49315 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbYDDB2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 21:28:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

this patch series adds DPLL autoidle control for OMAP3.  It then adds
OMAP3 DPLL enable and disable support via clock framework clk_enable()
and clk_disable().  It also updates the clock34xx.h comments to credit
frequent contributors.

I personally have verified that DPLL disable has been verified to
work on this code on OMAP3430ES2 SDP; and I believe that Jouni has 
verified that DPLL enable works correctly.

- Paul


size:
   text    data     bss     dec     hex filename
3262069  149384  100464 3511917  35966d vmlinux.orig
3263177  149384  100464 3513025  359ac1 vmlinux

diffstat:
 arch/arm/mach-omap2/clock34xx.c       |  301 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h       |   72 ++++++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |   18 +-
 arch/arm/mach-omap2/cm.h              |    1
 include/asm-arm/arch-omap/clock.h     |    5
 5 files changed, 369 insertions(+), 28 deletions(-)

