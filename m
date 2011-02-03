From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 00/13] CBUS meets GENIRQ
Date: Thu,  3 Feb 2011 12:20:15 +0200
Message-ID: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38737 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756130Ab1BCKVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:21:42 -0500
Received: by fxm20 with SMTP id 20so1016728fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:21:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

When you have some extra time, could you run these on N810
to check whether I'm on the right path ? After these patches
all CBUS drivers are using standard request_threaded_irq()
calls. It's one step closer into getting those in mainline.

Felipe Balbi (13):
  cbus: retu: get rid of retu-user.c
  cbus: retu: give it a context structure
  cbus: retu: move module_* close to the matching symbol
  cbus: retu: cleanup error path
  arm: omap: irqs: add CBUS_RETU_IRQ_BASE and CBUS_RETU_IRQ_END
  arm: omap: cbus: pass irq_base and irq_end via platform_data
  cbus: retu: move to threaded IRQ and GENIRQ
  cbus: retu: headset: convert to threaded_irq
  cbus: retu-pwrbutton: convert to threaded irq
  cbus: retu-rtc: move to threaded irq
  cbus: retu-rtc: drop the reset_occurred flag
  cbus: Makefile: re-enable retu-wdt
  cbus: tahvo: drop tahvo-user

 arch/arm/mach-omap1/board-nokia770.c   |    8 +
 arch/arm/mach-omap2/board-n8x0.c       |    8 +
 arch/arm/plat-omap/include/plat/cbus.h |    5 +
 arch/arm/plat-omap/include/plat/irqs.h |   10 +-
 drivers/cbus/Kconfig                   |   14 -
 drivers/cbus/Makefile                  |    3 +-
 drivers/cbus/retu-headset.c            |   22 +-
 drivers/cbus/retu-pwrbutton.c          |   37 +--
 drivers/cbus/retu-rtc.c                |  130 ++---------
 drivers/cbus/retu-user.c               |  424 --------------------------------
 drivers/cbus/retu.c                    |  394 ++++++++++++++----------------
 drivers/cbus/retu.h                    |   12 -
 drivers/cbus/tahvo-user.c              |  406 ------------------------------
 drivers/cbus/tahvo.c                   |   11 -
 drivers/cbus/tahvo.h                   |    5 -
 15 files changed, 258 insertions(+), 1231 deletions(-)
 delete mode 100644 drivers/cbus/retu-user.c
 delete mode 100644 drivers/cbus/tahvo-user.c

-- 
1.7.4.rc2

