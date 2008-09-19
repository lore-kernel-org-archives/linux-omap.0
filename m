From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/5] omap watchdog updaes
Date: Fri, 19 Sep 2008 13:32:34 +0300
Message-ID: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23464 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbYISKib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 06:38:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

Hi all,

Following are patches syncing, cleaning up and fixing omap watchdog
driver.

Patches 1-3 could be applied as is. Patches 4 and 5, on the other
hand, needs some discussion since I'd be creating a new directory
(include/linux/watchdog) and changing the clock handling.

Russel King told me, he'd like to hold on patch 5/5 as he'd have a
better solution for the clock handling soon. I'm sending that patch
away anyway so we can start the discussion on the mainling list about
that.

Felipe Balbi (5):
  watchdog: sync linux-omap changes
  watchdog: another ioremap() fix
  watchdog: cleanup a bit omap_wdt.c
  watchdog: move omap_wdt.h to include/linux/watchdog
  watchdog: introduce platform_data and remove cpu conditional code

 arch/arm/plat-omap/devices.c      |   76 ++++++++-
 drivers/watchdog/omap_wdt.c       |  333 ++++++++++++++++++++++---------------
 drivers/watchdog/omap_wdt.h       |   64 -------
 include/linux/watchdog/omap_wdt.h |   83 +++++++++
 4 files changed, 352 insertions(+), 204 deletions(-)
 delete mode 100644 drivers/watchdog/omap_wdt.h
 create mode 100644 include/linux/watchdog/omap_wdt.h

