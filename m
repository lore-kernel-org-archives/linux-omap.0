From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 00/10] move retu to threaded IRQ
Date: Mon,  3 Jan 2011 09:49:38 +0200
Message-ID: <1294040988-21191-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51584 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426Ab1ACHt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 02:49:57 -0500
Received: by mail-ey0-f173.google.com with SMTP id 7so4283167eyg.18
        for <linux-omap@vger.kernel.org>; Sun, 02 Jan 2011 23:49:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are a few more patches to retu. It converts
it (hopefully successfuly) to threaded IRQ and
adds an IRQ chip to retu.c core driver.

Anyone with an N810 available, please give it a
shot. Patches are also available for pulling
from [1]

[1] git://gitorious.org/usb/usb.git cbus

Felipe Balbi (10):
  cbus: retu: give it a context structure
  cbus: retu: get rid of retu-user.c
  cbus: retu: move module_* close to the matching symbol
  cbus: retu: cleanup error path
  cbus: retu: move to threaded IRQ and GENIRQ
  cbus: retu: headset: convert to threaded_irq
  cbus: retu-pwrbutton: convert to threaded irq
  cbus: retu-rtc: move to threaded irq
  cbus: retu-rtc: drop the reset_occurred flag
  cbus: Makefile: re-enable retu-wdt

 drivers/cbus/Kconfig          |    7 -
 drivers/cbus/Makefile         |    4 +-
 drivers/cbus/retu-headset.c   |   22 ++-
 drivers/cbus/retu-pwrbutton.c |   37 +---
 drivers/cbus/retu-rtc.c       |  130 ++-----------
 drivers/cbus/retu-user.c      |  424 -----------------------------------------
 drivers/cbus/retu.c           |  388 ++++++++++++++++++--------------------
 drivers/cbus/retu.h           |   12 --
 8 files changed, 223 insertions(+), 801 deletions(-)
 delete mode 100644 drivers/cbus/retu-user.c

-- 
1.7.3.4.598.g85356

