From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP2/3 clock: add DPLL rate rounding; OMAP3 DPLL rate programming
Date: Tue, 08 Apr 2008 00:27:25 -0600
Message-ID: <20080408062725.660256735@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58696 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYDHGrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 02:47:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hello,

the following two patches add:

- a new DPLL rate rounding algorithm for OMAP2/3, and

- non-CORE DPLL rate programming for OMAP3 (e.g., DPLLs 1, 2, 4, 5)

The rate rounding code is not yet integrated into the OMAP2 DPLL - this 
will come in future patches - but it is integrated on OMAP3.  

Tested on OMAP3430ES2 SDP.  Applies against 722c80b...


- Paul


size:
   text    data     bss     dec     hex filename
3264796  150696  100736 3516228  35a744 vmlinux.orig
3266060  151032  100736 3517828  35ad84 vmlinux


diffstat:
 arch/arm/mach-omap2/clock.c       |  198 +++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock.h       |    5
 arch/arm/mach-omap2/clock24xx.c   |   12 +-
 arch/arm/mach-omap2/clock24xx.h   |   17 ++-
 arch/arm/mach-omap2/clock34xx.c   |  139 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h   |   47 +++++++--
 include/asm-arm/arch-omap/clock.h |   10 +
 7 files changed, 409 insertions(+), 19 deletions(-)

