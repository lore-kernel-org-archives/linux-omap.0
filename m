From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/3] [RFC] introduce clk_associate
Date: Wed,  1 Oct 2008 13:36:00 +0300
Message-ID: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42150 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbYJAKgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:36:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <felipe.balbi@nokia.com>

The following patches introduce a new mechanism
to associate the device with its clock during
platform_device registration and move musb and
watchdog drivers to use the new mechanism as
an example.

Felipe Balbi (3):
  clk: introduce clk_associate
  clk: use clk_associate for musb driver
  clk: use clk_associate on watchdog driver

 Documentation/arm/OMAP/clk_function_name.txt |   13 ++++
 arch/arm/mach-omap2/usb-musb.c               |   34 +++-------
 arch/arm/plat-omap/clock.c                   |   38 +++++++++++-
 arch/arm/plat-omap/devices.c                 |   18 ++++--
 arch/arm/plat-omap/include/mach/clock.h      |    5 ++
 drivers/usb/musb/musb_core.c                 |   23 ++-----
 drivers/watchdog/omap_wdt.c                  |   87 ++++++++------------------
 7 files changed, 109 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/arm/OMAP/clk_function_name.txt

