From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] enable GP timer 12 as wakeup source
Date: Tue, 16 Dec 2008 10:34:07 -0800
Message-ID: <1229452450-22497-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f31.google.com ([209.85.219.31]:47421 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYLPSeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:34:17 -0500
Received: by ewy12 with SMTP id 12so3425524ewy.13
        for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 10:34:15 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

This series enables GP timer 12 as a wakeup source since it is in the
WKUP powerdomain.

Since Beagle boards <= B4 need to use gptimer12, this will allow
these boards to sleep-when-idle using gptimer12 as the wakeup timer.

I've verified on my ES2.1 beagle that gptimer12 can wakeup the system
from retention and off-mode.

Special thanks to Paul Walmsley for some advice on getting this working.

Kevin Hilman (3):
  OMAP: move GP timer selection alongside other timer options
  OMAP: dmtimer: enable all timers to be wakeup events
  OMAP3: PM: enable gptimer12 as a wakeup source

 arch/arm/mach-omap2/Kconfig       |   16 ----------------
 arch/arm/mach-omap2/pm34xx.c      |    6 ++++--
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 arch/arm/plat-omap/Kconfig        |   15 +++++++++++++++
 arch/arm/plat-omap/dmtimer.c      |    6 ++----
 5 files changed, 23 insertions(+), 22 deletions(-)

