From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and changes for the current watchdog framework
Date: Mon, 9 Jul 2012 12:39:36 +0800
Message-ID: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43984 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab2GIEnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 00:43:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com

Hello,

The following patches based on the 3.5-rc6 from Wim, which
are based on:

1 ) bootstatus fix for omap3,

2 ) omap-wdt framework update cater for the current framework
    as Shubhrajyoti comments mentioned.

Regards,
Zumeng

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

Zumeng Chen (3):
      Watchdog: Omap: Changes for the new watchdog framework
      Watchdog: Omap: select watchdog core for framework change
      Watchdog: Omap: get the bootstatus for OMAP2Plus

 arch/arm/mach-omap2/prcm.c  |    5 +-
 drivers/watchdog/Kconfig    |    1 +
 drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------------------
 drivers/watchdog/omap_wdt.h |    5 +
 4 files changed, 133 insertions(+), 216 deletions(-)

