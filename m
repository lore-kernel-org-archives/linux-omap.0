From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/5] extra module resets to ensure full-chip idle
Date: Wed, 26 Nov 2008 16:05:44 -0800
Message-ID: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:22149 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbYK0AFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:05:55 -0500
Received: by an-out-0708.google.com with SMTP id d40so306825and.1
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:05:53 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Various bootloaders have been known to leave modules in a state
which prevents full-chip retention.  This series forces
MMC, IVA2 and D2D/modem into known reset/idle states so that
the OMAP3 can hit full-chip idle.

Tested on OMAP3 Beagle, and custom OMAP3 hardware.

NOTE: this is similar to the set I posted for the PM branch
      but this series is rebased onto linux-omap and includes
      the MMC reset.

Kevin Hilman (5):
  OMAP3: PM: HSMMC: force MMC module reset on boot
  OMAP3: PM: Force IVA2 into idle during bootup
  OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
  OMAP3: PM: D2D clockdomain supports SW supervised transitions
  OMAP3: PM: Ensure modem is reset during PRCM init

 arch/arm/mach-omap2/clock34xx.h           |   37 +++++++++++++-
 arch/arm/mach-omap2/clockdomains.h        |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +++++
 arch/arm/mach-omap2/devices.c             |   76 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |   65 ++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/control.h |    5 ++
 6 files changed, 195 insertions(+), 4 deletions(-)

