From: Felipe Balbi <me@felipebalbi.com>
Subject: [RFC] [PATCH 0/5] omap watchdog fixes
Date: Fri, 19 Sep 2008 01:23:37 +0300
Message-ID: <1221776622-22906-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40936 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbYIRWX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 18:23:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

**** THIS IS NOT MEANT FOR INTEGRATION ****

Before sending to mainline I need a little help from you
people.

The main issue would be that mainline doesn't have yet the
omap_prcm_get_reset_sources() which means patch 5 would break
support for omap2/3 if applied to linux-omap.

I left the command commented out with a REVISIT note so when
those pieces go upstream, that comment should be removed.

I don't have hw rigth now, but I'll test the patches tomorrow
at work on omap2 (n810) and omap3 (sdp).

Please, give it a good review, specially on the clock handling
as I'm not really sure if I did it right.

Felipe Balbi (5):
  watchdog: sync linux-omap changes
  watchdog: another ioremap() fix
  watchdog: move omap_wdt.h to include/linux/watchdog
  watchdog: cleanup a bit omap_wdt.c
  watchdog: introduce platform_data and remove cpu conditional code

 arch/arm/plat-omap/devices.c      |   76 +++++++-
 drivers/watchdog/omap_wdt.c       |  369 ++++++++++++++++++++++---------------
 drivers/watchdog/omap_wdt.h       |   64 -------
 include/linux/watchdog/omap_wdt.h |   83 +++++++++
 4 files changed, 367 insertions(+), 225 deletions(-)
 delete mode 100644 drivers/watchdog/omap_wdt.h
 create mode 100644 include/linux/watchdog/omap_wdt.h

