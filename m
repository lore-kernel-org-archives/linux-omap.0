From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] trivial compile warning fixes
Date: Tue, 15 Feb 2011 14:49:10 +0200
Message-ID: <1297774156-23312-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:32891 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754853Ab1BOMtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 07:49:32 -0500
Received: by mail-yx0-f178.google.com with SMTP id 42so53192yxe.37
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:49:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

following are a few compile warning fixes for your
consideration.

For convenience, patches are also available at [1]

[1] git://gitorious.org/usb/usb.git trivial

Felipe Balbi (6):
  arm: omap: i2c: fix compile warning
  arm: omap1: fix compile warning
  arm: omap1: fix compile warnings
  arm: omap1: fix a bunch of section mismatches
  arm: omap2: irq: fix compile warning:
  arm: omap2: clksel: fix compile warning

 arch/arm/mach-omap1/board-ams-delta.c  |   14 +++---
 arch/arm/mach-omap1/board-fsample.c    |    2 +-
 arch/arm/mach-omap1/board-palmte.c     |   13 -----
 arch/arm/mach-omap2/clkt_clksel.c      |    2 +-
 arch/arm/mach-omap2/irq.c              |    4 +-
 arch/arm/plat-omap/i2c.c               |    2 +-
 arch/arm/plat-omap/include/plat/fpga.h |   92 ++++++++++++++++----------------
 7 files changed, 58 insertions(+), 71 deletions(-)

-- 
1.7.4.rc2

