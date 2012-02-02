From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 02 Feb 2012 02:38:48 -0700
Message-ID: <20120202093600.12509.35052.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab2BBJj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 04:39:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

Hi

This series consolidates some duplicated PM code across OMAP2, 3, and 4.
This saves both binary kernel image size, and lines of source.  These
functions are just the low-hanging fruit; it looks to me like there's even
more consolidation that could be done.

Suspend + UART wakeup was tested on OMAP44xx BeagleBoard.  On the
OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up from
suspend correctly with or without these patches, so I've only boot-tested
them on that platform.

- Paul

---

pm_cleanup_b_3.4
   text	   data	    bss	    dec	    hex	filename
6596402	 680284	5593820	12870506	 c4636a	vmlinux.orig
6596230	 680292	5593756	12870278	 c46286	vmlinux.patched

Paul Walmsley (2):
      ARM: OMAP2+: PM: share clkdms_setup() across OMAP2, 3, 4
      ARM: OMAP2+: PM: share some suspend-related functions across OMAP2, 3, 4


 arch/arm/mach-omap2/pm.c     |   74 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h     |    2 +
 arch/arm/mach-omap2/pm24xx.c |   69 +++------------------------------------
 arch/arm/mach-omap2/pm34xx.c |   73 ++++-------------------------------------
 arch/arm/mach-omap2/pm44xx.c |   57 ++------------------------------
 5 files changed, 91 insertions(+), 184 deletions(-)

