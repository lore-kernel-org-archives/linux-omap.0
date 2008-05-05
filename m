From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Mon,  5 May 2008 17:23:03 -0400
Message-ID: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32789 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbYEEVYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 17:24:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Tony,

Here is the updated version of my previous patches.
DMA and IRQ definitions were left as they are. Chandra is going
to send his work on top of this series.

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

Comments are wellcome.

Cheers,


Eduardo Valentin (4):
  PLAT-OMAP: MCBSP: Tranform into platform driver
  MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
  Fix mcbsp clock definition on clock34xx.h
  MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2

 arch/arm/mach-omap1/Makefile      |    2 +
 arch/arm/mach-omap1/mcbsp.c       |  165 +++++++++
 arch/arm/mach-omap2/Makefile      |    2 +
 arch/arm/mach-omap2/clock34xx.h   |   30 ++-
 arch/arm/mach-omap2/mcbsp.c       |  105 ++++++
 arch/arm/plat-omap/devices.c      |   45 +++
 arch/arm/plat-omap/mcbsp.c        |  660 ++++++++++++++-----------------------
 include/asm-arm/arch-omap/mcbsp.h |   73 ++++-
 8 files changed, 661 insertions(+), 421 deletions(-)
 create mode 100644 arch/arm/mach-omap1/mcbsp.c
 create mode 100644 arch/arm/mach-omap2/mcbsp.c

