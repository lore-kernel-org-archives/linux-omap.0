From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/5] Updates on mcbsp driver (take #4)
Date: Thu, 29 May 2008 12:50:45 -0400
Message-ID: <1212079850-28202-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65422 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYE2Que (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 12:50:34 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4TGnkXK009056
	for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 11:50:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Tony,

Here is the updated version of my previous patches.
Now with modifications recommended by Anand and Andrew.

As on take #2, DMA and IRQ definitions were left as they are.
Chandra is going to send his work on top of this series.

This series adds Tony's comments about clock usage on plat-omap/mcbsp.c.
Now it is done only with usual clk_* functions calls. But a
fake clock is created under mach-omap[1,2] to enable / disable
correct clocks when necessary. I also included Tony's patch to fix
clock definitions for 24xx.

This patch series updates mcbsp driver by transforming it into
a platform driver. This is a very initial implementation.
Basically it moves machine specific code to their correct place
and creates the platform driver necessary structures.

It must be working for previous boards. For omap34xx it should
work for mcbsp 1 and 2.

In order to do not break other places, I tryied to do not change
previous API. But future improvements are needed.

Clock definitions for  mcbsp 1 and 2 were also modified to add
correct support for omap34xx.

Thanks for last comments. More comments are wellcome. :)

Cheers,

Eduardo Valentin (4):
  PLAT-OMAP: MCBSP: Tranform into platform driver
  MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
  Fix mcbsp clock definition on clock34xx.h
  MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2

Tony Lindgren (1):
  ARM: OMAP: Fix 24xx mcbsp clocks

 arch/arm/mach-omap1/Makefile      |    2 +
 arch/arm/mach-omap1/mcbsp.c       |  280 ++++++++++++++++
 arch/arm/mach-omap2/Makefile      |    2 +
 arch/arm/mach-omap2/clock24xx.h   |   30 ++-
 arch/arm/mach-omap2/clock34xx.h   |   30 ++-
 arch/arm/mach-omap2/mcbsp.c       |  208 ++++++++++++
 arch/arm/plat-omap/devices.c      |   45 +++
 arch/arm/plat-omap/mcbsp.c        |  662 ++++++++++++++-----------------------
 include/asm-arm/arch-omap/mcbsp.h |   62 ++++-
 9 files changed, 890 insertions(+), 431 deletions(-)
 create mode 100644 arch/arm/mach-omap1/mcbsp.c
 create mode 100644 arch/arm/mach-omap2/mcbsp.c

