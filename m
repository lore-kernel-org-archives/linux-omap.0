From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 00/12] Retu meets GENIRQ
Date: Fri,  7 Jan 2011 11:07:58 +0200
Message-ID: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55650 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753668Ab1AGJIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:16 -0500
Received: by ewy1 with SMTP id 1so7300745ewy.29
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi all,

Second try of moving Retu to GENIRQ + Threaded IRQ.

For convenience, patches are also available at [1].

Compile tested only with omap2plus_defconfig + enabled
CBUS and RETU support.

[1] git://gitorious.org/usb/usb.git cbus

Changes from v1:

. add CBUS_RETU_IRQ_BASE and CBUS_RETU_IRQ_END
. add a platform_data for retu
. pass irq_base and irq_end via platform_data
. first remove retu-user.c before doing anything else

Felipe Balbi (12):
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

 arch/arm/mach-omap1/board-nokia770.c   |    8 +
 arch/arm/mach-omap2/board-n8x0.c       |    8 +
 arch/arm/plat-omap/include/plat/cbus.h |    5 +
 arch/arm/plat-omap/include/plat/irqs.h |   10 +-
 drivers/cbus/Kconfig                   |    7 -
 drivers/cbus/Makefile                  |    4 +-
 drivers/cbus/retu-headset.c            |   22 +-
 drivers/cbus/retu-pwrbutton.c          |   37 +--
 drivers/cbus/retu-rtc.c                |  130 ++---------
 drivers/cbus/retu-user.c               |  424 --------------------------------
 drivers/cbus/retu.c                    |  394 ++++++++++++++----------------
 drivers/cbus/retu.h                    |   12 -
 12 files changed, 259 insertions(+), 802 deletions(-)
 delete mode 100644 drivers/cbus/retu-user.c

-- 
1.7.3.4.598.g85356

