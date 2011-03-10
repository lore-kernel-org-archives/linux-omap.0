From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH v2 0/2] OMAP3: wdtimer: Fix CORE idle
Date: Thu, 10 Mar 2011 14:10:56 +0200
Message-ID: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:31008 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab1CJMMu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 07:12:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org, wim@iguana.be, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com
Cc: jhnikula@gmail.com, ilkka.koskinen@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

These patches fix the issue where the wdtimer blocks CORE idle
transitions on n900 (OMAP3). The root cause was that SMART idle
mode in wdtimer did not allow the CORE idle transition to happen.

v2: updated commit message on patch 1/2, Cc'd Wim, and added
comments to code about possible HW bug in wdtimer2.

Wim, please check patch number one and add your acked by.

I propose that we push these upstream via linux-omap-pm,
as the patches deal with PM and need to be applied together
to get the desired functionality.

Paul Walmsley (2):
  Watchdog: omap_wdt: add fine grain runtime-pm
  OMAP3: wdtimer: Fix CORE idle transition

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 drivers/watchdog/omap_wdt.c                |   25 +++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

