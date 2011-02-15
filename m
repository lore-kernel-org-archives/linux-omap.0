From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/15] More cleanups
Date: Tue, 15 Feb 2011 10:45:47 +0200
Message-ID: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55565 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab1BOIqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:15 -0500
Received: by gxk21 with SMTP id 21so2414887gxk.10
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We're almost there. retu.c looks very nice now.

The bulk effort is now on its children:

. retu-headset.c
	. should use jack framework
	. should use dev_pm_ops
	. some cleanups wouldn't hurt

. retu-rtc.c
	. needs suspend/resume (?)

. retu-wdt.c
	. needs suspend/resume (?)

patches also available at [1] for convenience

[1] git://gitorious.org/usb/usb.git cbus

Felipe Balbi (15):
  cbus: retu: drop retu_get_status
  cbus: retu: replace BUG_ON with WARN
  cbus: retu: drop the unnecessary spinlock_t
  cbus: retu: drop unused PFX macro
  arm: omap: cbus: add IDs for Retu and Tahvo
  arm: omap: pass Retu ID via platform_data
  cbus: retu: use the devid from platform_data
  cbus: retu: introduce internal read/write functions
  cbus: retu: search and replace
  cbus: retu: pwrbutton: save device pointer on our structure
  cbus: retu: pass the child device pointer to all retu functions
  cbus: retu: headset: don't save pdev pointer
  cbus: retu: replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
  cbus: retu: tabify retu initialization
  cbus: retu: set pm_power_off to NULL when removing retu

 arch/arm/mach-omap1/board-nokia770.c   |    1 +
 arch/arm/mach-omap2/board-n8x0.c       |    1 +
 arch/arm/plat-omap/include/plat/cbus.h |    4 +
 drivers/cbus/retu-headset.c            |   35 ++++---
 drivers/cbus/retu-pwrbutton.c          |    4 +-
 drivers/cbus/retu-rtc.c                |   34 +++----
 drivers/cbus/retu-wdt.c                |   15 +---
 drivers/cbus/retu.c                    |  160 +++++++++++++++++++-------------
 drivers/cbus/retu.h                    |   10 +-
 9 files changed, 146 insertions(+), 118 deletions(-)

-- 
1.7.4.rc2

