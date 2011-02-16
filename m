From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/6] CBUS Second try
Date: Wed, 16 Feb 2011 21:42:24 +0200
Message-ID: <1297885350-3462-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50446 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115Ab1BPTmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:42:36 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so1811210bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:42:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are the fixes for CBUS RETU.

Just one patch added, no other differences. My cbus
branch has been updated for convenience:

git://gitorious.org/usb/usb.git cbus

(I'm starting to think usb.git isn't a good name for that tree)

Felipe Balbi (6):
  cbus: retu: wdt: save dev in retu_wdt_dev
  cbus: retu: pass the child device pointer to all retu functions
  cbus: retu: headset: don't save pdev pointer
  cbus: retu: replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
  cbus: retu: tabify retu initialization
  cbus: retu: set pm_power_off to NULL when removing retu

 drivers/cbus/retu-headset.c   |   35 +++++++++++--------
 drivers/cbus/retu-pwrbutton.c |    2 +-
 drivers/cbus/retu-rtc.c       |   28 ++++++++--------
 drivers/cbus/retu-wdt.c       |    8 ++--
 drivers/cbus/retu.c           |   73 ++++++++++++++++++++++++----------------
 drivers/cbus/retu.h           |    9 +++--
 6 files changed, 88 insertions(+), 67 deletions(-)

-- 
1.7.4.rc2

