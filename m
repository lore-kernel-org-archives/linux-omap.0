From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/6] OMAP GPIO updates for 2.6.35
Date: Tue, 11 May 2010 16:30:46 -0700
Message-ID: <1273620652-15927-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35206 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0EKXaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:30:55 -0400
Received: by pvh11 with SMTP id 11so99806pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:30:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

A series of OMAP GPIO updates for 2.6.35 from the OMAP PM branch.

Series based on v2.6.34-rc6

Also available here:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git gpio-2.6.35

Kevin

Chunqiu Wang (1):
  OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs

Kevin Hilman (3):
  OMAP2/3: GPIO: generalize prepare for idle
  OMAP3: GPIO: disable GPIO debounce clocks on idle
  OMAP: GPIO: remove duplicate debugfs interface

Tero Kristo (2):
  OMAP3: GPIO fixes for off-mode
  OMAP3: GPIO: Removed a couple of unneeded registers from context
    save/restore

 arch/arm/mach-omap2/pm24xx.c           |    4 +-
 arch/arm/mach-omap2/pm34xx.c           |    4 +-
 arch/arm/plat-omap/gpio.c              |  177 +++++++++-----------------------
 arch/arm/plat-omap/include/plat/gpio.h |    4 +-
 4 files changed, 53 insertions(+), 136 deletions(-)

