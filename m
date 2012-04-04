From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 00/17][V2] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx cleanups
Date: Wed,  4 Apr 2012 22:12:34 +0200
Message-ID: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64294 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2DDUMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 16:12:54 -0400
Received: by wgbdr13 with SMTP id dr13so616927wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 13:12:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

This patchset makes some cleanup on these cpuidle drivers
and consolidate the code across both architecture.

Tested on OMAP3 (igepV2).
Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

V2 : Fixed a couple of typos in the patch description

V1 : Initial Post

Daniel Lezcano (17):
  ARM: OMAP4: cpuidle - Remove unused valid field
  ARM: OMAP4: cpuidle - Declare the states with the driver declaration
  ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
  ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
  ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
  ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
  ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
    time
  ARM: OMAP3: cpuidle - remove rx51 cpuidle parameters table
  ARM: OMAP3: define cpuidle statically
  ARM: OMAP3: cpuidle - remove the 'valid' field
  ARM: OMAP3: cpuidle - remove cpuidle_params_table
  ARM: OMAP3: define statically the omap3_idle_data
  ARM: OMAP3: cpuidle - use omap3_idle_data directly
  ARM: OMAP3 : cpuidle - simplify next_valid_state
  ARM: OMAP3: set omap3_idle_data as static
  ARM: OMAP3/4: consolidate cpuidle Makefile
  ARM: OMAP3: cpuidle - set global variables static

 arch/arm/mach-omap2/Makefile      |   11 +-
 arch/arm/mach-omap2/board-rx51.c  |   38 +++---
 arch/arm/mach-omap2/cpuidle34xx.c |  299 +++++++++++++++----------------------
 arch/arm/mach-omap2/cpuidle44xx.c |  135 +++++++----------
 arch/arm/mach-omap2/pm.h          |   38 ++---
 5 files changed, 219 insertions(+), 302 deletions(-)

-- 
1.7.5.4

