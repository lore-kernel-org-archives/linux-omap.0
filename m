From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH PM 0/2] OMAP2/3 GPIO fixes for idling debounce clocks
Date: Tue, 27 Jan 2009 11:26:52 -0800
Message-ID: <1233084414-8088-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:41631 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbZA0T06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 14:26:58 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7636443wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 11:26:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series against the current PM branch is to add support for
auto-disabling GPIO debounce clocks when the system is idle.  Without
this, any platform using the GPIO debounce feature will not go into
retention since the GPIO debounce clocks are still active.

This is needed particularily on OMAP3EVM which sets up the debounce
clocks for the touchscreen GPIO.

Kevin Hilman (2):
  OMAP2/3: GPIO: generalize prepare for idle
  OMAP3: GPIO: disable GPIO debounce clocks on idle

 arch/arm/mach-omap2/pm24xx.c           |    4 ++--
 arch/arm/mach-omap2/pm34xx.c           |   10 ++++------
 arch/arm/plat-omap/gpio.c              |   27 +++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/gpio.h |    4 ++--
 4 files changed, 29 insertions(+), 16 deletions(-)

