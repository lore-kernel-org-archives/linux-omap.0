From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH v2 0/6] ARM: OMAP2+: PM: introduce the power domains functional states
Date: Wed, 11 Apr 2012 22:46:06 +0200
Message-ID: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61654 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab2DKUql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:46:41 -0400
Received: by wibhr17 with SMTP id hr17so4359706wib.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:46:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ldc_pm_all@list.ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement the functional states for the power domains:
- protect the power domain state change by a mutex in
  omap_set_pwrdm_state,
- introduce the functional states for power domains power states and
  logic power states, and the conversion functions between the
  functional and internal states,
- unify the API to use the functional states,
- program the logic power state of power domains from the functional
  states, in omap_set_pwrdm_state
- convert the OMAP2/3/4 PM code to use the updated API,
- provide the power domains statistics by functional states.

Tested on OMAP3 Beagleboard, with suspend and cpuidle in RET and
OFF modes.


Jean Pihet (6):
  ARM: OMAP2+: PM: protect the power domain state change by a mutex
  ARM: OMAP2+: PM: introduce power domains functional states
  ARM: OMAP2+: PM: use the functional power states API
  ARM: OMAP2+: PM: introduce power domains logic and memory functional
    states
  ARM: OMAP2+: PM: use the functional power states API for logic and
    memory
  ARM: OMAP2+: PM: use power domain functional state in stats counters

 arch/arm/mach-omap2/cpuidle34xx.c          |   61 ++++----
 arch/arm/mach-omap2/cpuidle44xx.c          |   28 ++--
 arch/arm/mach-omap2/omap-hotplug.c         |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |   39 +++---
 arch/arm/mach-omap2/pm-debug.c             |   15 +-
 arch/arm/mach-omap2/pm.c                   |   62 -------
 arch/arm/mach-omap2/pm24xx.c               |   14 +-
 arch/arm/mach-omap2/pm34xx.c               |   80 +++++-----
 arch/arm/mach-omap2/pm44xx.c               |   15 +--
 arch/arm/mach-omap2/powerdomain-common.c   |   85 ++++++++++
 arch/arm/mach-omap2/powerdomain.c          |  244 ++++++++++++++++++++++++++--
 arch/arm/mach-omap2/powerdomain.h          |   42 +++++-
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c |    7 +
 arch/arm/mach-omap2/powerdomain44xx.c      |    3 +
 14 files changed, 489 insertions(+), 208 deletions(-)

-- 
1.7.7.6

