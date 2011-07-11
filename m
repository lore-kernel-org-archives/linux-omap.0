From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 14:17:13 +0300
Message-ID: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47928 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754633Ab1GKLRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:17:45 -0400
Received: by mail-gw0-f53.google.com with SMTP id 20so1808691gwj.26
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:17:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here's the complete series... I'll stop playing
with these for a while. If you have some free time
to boot test on n8x0, I'd be really glad ;-)

Maybe Michael could test too ??

Felipe Balbi (22):
  cbus: tahvo: convert spinlock into mutex
  cbus: tahvo: move to __devinit/__devexit sections
  cbus: tahvo: a switch looks better
  cbus: tahvo: don't go over 80 columns
  cbus: tahvo: drop the tasklet
  cbus: retu: set IRQF_ONESHOT flag
  cbus: tahvo: git it a context structure
  cbus: tahvo: pass tahvo to IRQ handler
  cbus: tahvo: introduce __tahvo_(read/write)_reg
  cbus: tahvo: drop some unneded defines
  cbus: retu: IRQ demux optimization
  cbus: tahvo: give it an irq_chip
  cbus: tahvo: start using irq_chip
  cbus: tahvo: usb: fix up to use threaded irqs
  cbus: tahvo drop the legacy interfaces
  cbus: tahvo: usb: drop unused variable
  cbus: tahvo: no need to mask interrupts on exit
  cbus: tahvo: drop the get_status hack
  cbus: tahvo: drop more unused interfaces
  cbus: tahvo: pass child device pointer
  cbus: tahvo: drop backlight interfaces
  cbus: tahvo: drop static global pointer

 arch/arm/mach-omap1/board-nokia770.c |    6 -
 arch/arm/mach-omap2/board-n8x0.c     |    6 -
 drivers/cbus/retu.c                  |   18 +-
 drivers/cbus/tahvo-usb.c             |   58 ++---
 drivers/cbus/tahvo.c                 |  462 ++++++++++++++++++----------------
 drivers/cbus/tahvo.h                 |   16 +-
 6 files changed, 283 insertions(+), 283 deletions(-)

-- 
1.7.6

