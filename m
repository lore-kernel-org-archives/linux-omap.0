From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] OMAP2/3: GPTIMER12 fixes
Date: Sat, 04 Apr 2009 14:54:07 -0600
Message-ID: <20090404205333.12269.76287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38002 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbZDDUzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 16:55:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello,

This following series of fixes implements support in mainline for
using GPTIMER12 as the system tick timer.  Currently this is only
needed for some BeagleBoards.  Detailed comments are in the patch
descriptions.

This is being posted for any brief comments before submitting upstream
as part of a fix series.


- Paul

---

Kevin Hilman (1):
      OMAP: dmtimer: enable all timers to be wakeup events

Paul Walmsley (2):
      OMAP2/3 GPTIMER: allow system tick GPTIMER to be changed in board-*.c files
      OMAP3 GPTIMER: fix GPTIMER12 IRQ


 arch/arm/mach-omap2/board-omap3beagle.c    |    4 ++
 arch/arm/mach-omap2/clock24xx.c            |    1 +
 arch/arm/mach-omap2/clock24xx.h            |   10 +++++-
 arch/arm/mach-omap2/clock34xx.h            |    1 -
 arch/arm/mach-omap2/timer-gp.c             |   48 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/dmtimer.c               |   28 ++++++++++------
 arch/arm/plat-omap/include/mach/dmtimer.h  |    2 +
 arch/arm/plat-omap/include/mach/timer-gp.h |   17 ++++++++++
 8 files changed, 94 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/timer-gp.h


