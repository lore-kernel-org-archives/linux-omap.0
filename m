From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 0/2] OMAP 2/3 GPIO fixes for idling debounce clocks
Date: Wed, 28 Jan 2009 17:58:00 -0800
Message-ID: <1233194282-30057-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:10300 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZA2B6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 20:58:08 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8408212wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2009 17:58:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

[updated since v1: also works for retention/off when idle by 
 masking off GPIO clocks in the 'fclks_active' check.]

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
 arch/arm/mach-omap2/pm34xx.c           |   14 ++++++++------
 arch/arm/plat-omap/gpio.c              |   27 +++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/gpio.h |    4 ++--
 4 files changed, 33 insertions(+), 16 deletions(-)

