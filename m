From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/2] OMAP3: wdtimer: Fix CORE idle
Date: Thu, 10 Mar 2011 12:54:06 +0200
Message-ID: <1299754448-24888-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:49260 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497Ab1CJKzy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 05:55:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

These patches fix the issue where the wdtimer blocks CORE idle
transitions on n900 (OMAP3). The root cause was that SMART idle
mode in wdtimer did not allow the CORE idle transition to happen.

Paul, I added your S-o-bs to the patches already. Please check
that they are ok by you.

Paul Walmsley (2):
  Watchdog: omap_wdt: add fine grain runtime-pm
  OMAP3: wdtimer: Fix CORE idle transition

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 drivers/watchdog/omap_wdt.c                |   25 +++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

