From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/11] OMAP clock/hwmod: final set of 2.6.34 patches
Date: Mon, 22 Feb 2010 21:50:12 -0700
Message-ID: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60242 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0BWE5i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Here are a few more OMAP clock and hwmod patches intended for 2.6.34,
posted in case anyone has any review comments.

These patches have been boot-tested on OSK5912, N800, 2430SDP,
Overo; and compile-tested on 4430SDP.


- Paul

---

size:
   text	   data	    bss	    dec	    hex	filename
2882000	 127872	  88872	3098744	 2f4878	vmlinux.osk5912.orig
2882016	 127872	  88872	3098760	 2f4888	vmlinux.osk5912.patched
2324953	 121440	  63728	2510121	 264d29	vmlinux.n8x0.orig
2325885	 121536	  63728	2511149	 26512d	vmlinux.n8x0.patched
3422044	 176928	 146928	3745900	 39286c	vmlinux.2430sdp.orig
3423048	 177024	 146928	3747000	 392cb8	vmlinux.2430sdp.patched
6060161	1797424	5800396	13657981 d0677d	vmlinux.omap3.orig
6061113	1797488	5800396	13658997 d06b75	vmlinux.omap3.patched
2049131	 168736	  65412	2283279	 22d70f	vmlinux.4430sdp.orig
2050167	 169632	  65412	2285211	 22de9b	vmlinux.4430sdp.patched

Paul Walmsley (7):
      OMAP clock: add omap_clk_get_by_name() for use by OMAP hwmod core code
      OMAP hwmod: convert hwmod to use hardware clock names rather than clkdev dev+con
      OMAP hwmod: convert header files with static allocations into C files
      OMAP hwmod: add hwmod class support
      OMAP clockdomain: if no autodeps exist, don't try to add or remove them
      OMAP2/3 clock: combine OMAP2 & 3 boot-time MPU rate change code
      OMAP2+ clock: revise omap2_clk_{disable,enable}()

Rajendra Nayak (1):
      OMAP4: clock: Rename leaf clock nodes to end with a _ick or _fck

Santosh Shilimkar (2):
      OMAP4: clock: Add dummy clock nodes for interface clocks
      OMAP4: clock: Remove clock hacks from timer-gp.c

Vimarsh Zutshi (1):
      From 5c87e27fd557a56aca72cd10529c3bdcb0c8a517 Mon Sep 17 00:00:00 2001


 arch/arm/configs/omap_4430sdp_defconfig      |    7 
 arch/arm/mach-omap1/clock.c                  |   14 -
 arch/arm/mach-omap1/clock_data.c             |    6 
 arch/arm/mach-omap2/Makefile                 |   12 -
 arch/arm/mach-omap2/clock.c                  |  220 ++++++++--
 arch/arm/mach-omap2/clock.h                  |    5 
 arch/arm/mach-omap2/clock2xxx.c              |   34 -
 arch/arm/mach-omap2/clock3xxx.c              |   59 ---
 arch/arm/mach-omap2/clock3xxx_data.c         |    2 
 arch/arm/mach-omap2/clock44xx_data.c         |  596 ++++++++++++++------------
 arch/arm/mach-omap2/clockdomain.c            |   16 +
 arch/arm/mach-omap2/io.c                     |   21 -
 arch/arm/mach-omap2/omap_hwmod.c             |  244 ++++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   38 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   38 +-
 arch/arm/mach-omap2/omap_hwmod_34xx.h        |  168 -------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  181 ++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   24 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h |   24 +
 arch/arm/mach-omap2/timer-gp.c               |    5 
 arch/arm/plat-omap/clock.c                   |   37 ++
 arch/arm/plat-omap/include/plat/clock.h      |    3 
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   71 ++-
 23 files changed, 1073 insertions(+), 752 deletions(-)
 rename arch/arm/mach-omap2/{omap_hwmod_2420.h => omap_hwmod_2420_data.c} (82%)
 rename arch/arm/mach-omap2/{omap_hwmod_2430.h => omap_hwmod_2430_data.c} (83%)
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_data.h

