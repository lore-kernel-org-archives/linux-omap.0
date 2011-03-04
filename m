From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/2] OMAP: PM: implement devices wakeup latency constraints APIs
Date: Fri,  4 Mar 2011 15:52:53 +0100
Message-ID: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38774 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759044Ab1CDPBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:01:12 -0500
Received: by wyg36 with SMTP id 36so2160153wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 07:01:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
creating similar APIs at the omap_device and omap_hwmod levels. The
omap_hwmod level call is the layer with access to the powerdomain
core, so it is the place where the powerdomain is queried to set and
release the constraints.

NOTE: only works for devices which have been converted to use
      omap_device/omap_hwmod.

Longer term, we could possibly remove this API from the OMAP PM layer,
and instead directly use the device level API.

The power domains get the next power state programmed directly in
the registers via pwrdm_wakeuplat_update_pwrst.

Note about PM QOS: the MPU and CORE power domains get the next power
state via cpuidle, which get the strongest wake-up latency constraint
by querying PM QOS. The usage of PM QOS is temporary, until a generic
solution is in place.

Jean Pihet (2):
  OMAP PM: create a PM layer plugin for the devices wakeup latency
    constraints
  OMAP: PM: implement devices wakeup latency constraints APIs

 arch/arm/mach-omap2/omap_hwmod.c              |   62 +++++-
 arch/arm/mach-omap2/powerdomain.c             |  197 ++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |   39 +++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   60 ++++
 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  358 +++++++++++++++++++++++++
 arch/arm/plat-omap/omap_device.c              |   28 ++
 10 files changed, 754 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.2.3

