From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Tue,  8 Mar 2011 15:06:21 +0200
Message-ID: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50907 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab1CHNI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:08:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com
Cc: ilkka.koskinen@nokia.com, wim@iguana.be, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

The runtime PM does not offer enough granularity to control
individual clocks separately as needed. Current pm implementation
of omap_wdt blocks the CORE power domain from idling in
OMAP SoC, as it keeps the interface clock of the watchdog always
on. This causes severe power leakage in devices where 
the omap watchdog is in active use.

This patch set reverts the omap_wdt move to runtime_pm and
introduces a tight control of the interface clock in the driver
to only enable it when registers are accessed. The patch is
based on earlier patch by Atal Shargorodsky.

If anyone has good suggestions how to fix this with runtime_pm,
feel free to propose patches. Otherwise I suggest we revert
back to something that works.

Tested with RX-51 S4.0 Macroboard, linux-omap-pm/pm branch and
MeeGo armv7l release.

Kalle Jokiniemi (2):
  Revert "OMAP: WDT: Use PM runtime APIs instead of clk FW APIs"
  Watchdog: omap_wdt: fix interface clock handling

 drivers/watchdog/omap_wdt.c |   64 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 55 insertions(+), 9 deletions(-)

