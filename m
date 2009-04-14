From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/7] OMAP clock fixes for v2.6.30-rc1
Date: Tue, 14 Apr 2009 12:23:24 -0600
Message-ID: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45700 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbZDNS1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Hi Russell,

Here are some OMAP clock-related fixes against v2.6.30-rc1.  If you
are happy with these, Tony will merge them into his omap-fixes branch
for you to pull.

You might consider the last patch to be too big to be a fix; if so,
please let me know and it will be moved to a feature series.


regards

- Paul

---

Arun KS (1):
      OMAP1: clock: Typo fix for clock in omap1

Kevin Hilman (1):
      OMAP: dmtimer: enable all timers to be wakeup events

Paul Walmsley (4):
      OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed in board-*.c files
      OMAP3 GPTIMER: fix GPTIMER12 IRQ
      OMAP2xxx clock: fix broken cpu_mask code
      OMAP2xxx clock: init osc_ck, sys_ck internal lists early

Sergio Aguirre (1):
      OMAP3: clock: Camera module doesn't have IDLEST bit


 arch/arm/mach-omap1/mcbsp.c                |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    4 ++
 arch/arm/mach-omap2/clock24xx.c            |   15 ++++-----
 arch/arm/mach-omap2/clock24xx.h            |   10 +++++-
 arch/arm/mach-omap2/clock34xx.h            |    7 ++--
 arch/arm/mach-omap2/timer-gp.c             |   48 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/dmtimer.c               |   28 ++++++++++------
 arch/arm/plat-omap/include/mach/dmtimer.h  |    2 +
 arch/arm/plat-omap/include/mach/timer-gp.h |   17 ++++++++++
 9 files changed, 104 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h


omap-clock-fixes
   text	   data	    bss	    dec	    hex	filename
4601895	 249952	 304788	5156635	 4eaf1b	vmlinux.3430sdp.orig
4602055	 249952	 304788	5156795	 4eafbb	vmlinux.3430sdp


