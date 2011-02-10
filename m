From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] RETU fetch IRQ via struct resource
Date: Thu, 10 Feb 2011 12:21:17 +0200
Message-ID: <1297333281-29853-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46010 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755840Ab1BJKVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 05:21:25 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so1450612fxm.18
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 02:21:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are 4 very quick patches to grab IRQ
via struct resource. Now all these changes
need to be ported to Tahvo. I'm not sure
I'll have any time to look at that for a
while, though.

Felipe Balbi (4):
  cbus: retu: pass IRQ via struct resource
  cbus: retu: headset: grab IRQ via struct resource
  cbus: retu: pwrbutton: grab IRQ via struct resource
  cbus: retu: rtc: grab IRQ via struct resource

 drivers/cbus/retu-headset.c   |   11 +++++++--
 drivers/cbus/retu-pwrbutton.c |    2 +-
 drivers/cbus/retu-rtc.c       |   23 +++++++++++++++------
 drivers/cbus/retu.c           |   42 ++++++++++++++++++++++++++++++++++------
 4 files changed, 60 insertions(+), 18 deletions(-)

-- 
1.7.4.rc2

