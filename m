From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/7] OMAP2+: voltage layer cleanup and restructure.
Date: Fri, 18 Mar 2011 17:18:45 -0700
Message-ID: <1300493932-17362-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51416 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757562Ab1CSASf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 20:18:35 -0400
Received: by mail-iy0-f175.google.com with SMTP id 26so5564861iyb.34
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 17:18:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

In order to implement a clean DVFS layer, the current voltage layer
needs quite a bit of cleanup and restructure.  Many of the details
were described by Paul in his initial cleanup[1], and this series is
continuing in that direction.

This series is currently also available in my pm-wip/voltdm branch and
based on my pm-core branch.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=c0718df4d666cc5fd8837ac93c82995a17bfdbf5


Kevin Hilman (7):
  OMAP2+: hwmod: remove unused voltagedomain pointer
  OMAP2+: voltage: move PRCM mod offets into VDD structure
  OMAP2+: voltage: start towards a new voltagedomain layer
  OMAP2+: powerdomain: add voltage domain lookup during register
  OMAP2+: voltage: keep track of powerdomains in each voltagedomain
  OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
  OMAP3: powerdomain data: add voltage domains

 arch/arm/mach-omap2/io.c                      |    3 +
 arch/arm/mach-omap2/omap_twl.c                |   10 +-
 arch/arm/mach-omap2/pm.c                      |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |   27 ++
 arch/arm/mach-omap2/powerdomain.h             |    8 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   10 +
 arch/arm/mach-omap2/sr_device.c               |    2 +-
 arch/arm/mach-omap2/voltage.c                 |  438 +++++++++++++++----------
 arch/arm/mach-omap2/voltage.h                 |   44 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   42 ++--
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   55 ++--
 arch/arm/mach-omap2/vp.h                      |    3 -
 arch/arm/mach-omap2/vp3xxx_data.c             |    2 -
 arch/arm/mach-omap2/vp44xx_data.c             |    3 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 -
 15 files changed, 405 insertions(+), 245 deletions(-)

-- 
1.7.4

