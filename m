From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 0/6] OMAP cleanups
Date: Thu, 18 Nov 2010 19:59:45 +0200
Message-ID: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:44804 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759967Ab0KRR7u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 12:59:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Some small OMAP cleanups to eliminate noise from compilation/sparse
checks:

Aaro Koskinen (6):
  arm: omap1: add missing includes
  arm: omap1: make some functions static
  arm: omap1: mbox: make variables static
  arm: omap1: mbox: delete unused variable
  arm: omap1: board-ams-delta: fix cast
  arm: omap2: timer-gp: delete unused variable

 arch/arm/mach-omap1/board-ams-delta.c |    3 ++-
 arch/arm/mach-omap1/devices.c         |    1 +
 arch/arm/mach-omap1/flash.c           |    1 +
 arch/arm/mach-omap1/mailbox.c         |    5 ++---
 arch/arm/mach-omap1/mcbsp.c           |    2 +-
 arch/arm/mach-omap1/mux.c             |    2 +-
 arch/arm/mach-omap1/serial.c          |    2 ++
 arch/arm/mach-omap1/time.c            |    1 +
 arch/arm/mach-omap2/timer-gp.c        |    3 +--
 arch/arm/plat-omap/dma.c              |    2 +-
 arch/arm/plat-omap/sram.c             |    2 +-
 11 files changed, 14 insertions(+), 10 deletions(-)

