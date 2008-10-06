From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 0/3] omap_clk_associate
Date: Tue,  7 Oct 2008 01:47:29 +0300
Message-ID: <1223333252-25687-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55507 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYJFWr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 18:47:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

In the following patches we introduce omap_clk_associate
hook to simplify clk handling for drivers. The main idea
is that we let struct clk know which device is the user
for that clk source and create a function name (or alias)
for the clk so drivers doesn't have to care about different
clk names between omap versions.

Felipe Balbi (3):
  clk: introduce omap_clk_associate
  clk: use clk_associate for musb driver
  clk: use clk_associate on watchdog driver

 Documentation/arm/OMAP/clk_function_name.txt |   13 ++++
 arch/arm/mach-omap2/board-n800-usb.c         |   26 --------
 arch/arm/mach-omap2/usb-musb.c               |   34 +++-------
 arch/arm/mach-omap2/usb-tusb6010.c           |    2 +
 arch/arm/plat-omap/clock.c                   |   38 +++++++++++-
 arch/arm/plat-omap/devices.c                 |   18 ++++--
 arch/arm/plat-omap/include/mach/clock.h      |    6 ++
 drivers/usb/musb/musb_core.c                 |   23 ++-----
 drivers/watchdog/omap_wdt.c                  |   87 ++++++++------------------
 9 files changed, 112 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/arm/OMAP/clk_function_name.txt

