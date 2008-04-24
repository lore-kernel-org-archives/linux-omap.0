From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/5] Updates on mcbsp driver
Date: Thu, 24 Apr 2008 11:54:20 -0400
Message-ID: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21216 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbYDXPyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 11:54:53 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3OFsQhQ015034
	for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 18:54:50 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

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

Eduardo Valentin (5):
  PLAT-OMAP: MCBSP: Tranform into platform driver
  MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
  Fix mcbsp clock definition on clock34xx.h
  OMAP3xx: Add DMA and IRQ definition for McBSP 1 and 2
  MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2

 arch/arm/mach-omap1/Makefile      |    2 +
 arch/arm/mach-omap1/mcbsp.c       |  166 +++++++++
 arch/arm/mach-omap2/Makefile      |    2 +
 arch/arm/mach-omap2/clock34xx.h   |   30 ++-
 arch/arm/mach-omap2/mcbsp.c       |  108 ++++++
 arch/arm/plat-omap/devices.c      |   45 +++
 arch/arm/plat-omap/mcbsp.c        |  662 ++++++++++++++-----------------------
 include/asm-arm/arch-omap/dma.h   |    4 +
 include/asm-arm/arch-omap/irqs.h  |    4 +
 include/asm-arm/arch-omap/mcbsp.h |   73 ++++-
 10 files changed, 675 insertions(+), 421 deletions(-)
 create mode 100644 arch/arm/mach-omap1/mcbsp.c
 create mode 100644 arch/arm/mach-omap2/mcbsp.c

