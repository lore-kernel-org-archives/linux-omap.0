From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] CBUS patches
Date: Wed, 23 Nov 2011 16:00:42 +0200
Message-ID: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53082 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1KWOAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:00:53 -0500
Received: by mail-gy0-f178.google.com with SMTP id r11so1818651ghr.23
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:00:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are a few fixes for CBUS and friends plus an RFC
of irq_domain conversion for retu.c. Untested, compile
tested only.

Felipe Balbi (6):
  cbus: fix compile breakage
  cbus: move the module_platform_driver where possible
  cbus: fix very old compile warning
  cbus: retu: move irq_chip to our context structure
  cbus: tahvo: move irq_chip to our context structure
  cbus: retu: implement irq_domain support

 drivers/cbus/cbus.c           |   23 +++++-------
 drivers/cbus/retu-headset.c   |   21 +++--------
 drivers/cbus/retu-pwrbutton.c |   20 +++-------
 drivers/cbus/retu-rtc.c       |   18 +++-------
 drivers/cbus/retu-wdt.c       |   19 +++-------
 drivers/cbus/retu.c           |   77 ++++++++++++++++++++++------------------
 drivers/cbus/tahvo-usb.c      |   21 ++++++-----
 drivers/cbus/tahvo.c          |   34 +++++++-----------
 8 files changed, 98 insertions(+), 135 deletions(-)

-- 
1.7.8.rc3

