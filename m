From: jean.pihet@newoldbits.com
Subject: [PATCH 0/5] OMAP: cpuidle code clean-up
Date: Fri, 29 Apr 2011 11:26:21 +0200
Message-ID: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33081 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab1D2J0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 05:26:43 -0400
Received: by wya21 with SMTP id 21so2712160wya.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 02:26:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Rework the cpuidle code:
- optimize the cpuidle C-states data registration and storage,
- change the interaction with the debugfs 'enable_off_mode' knob
 and the use of the C-states 'valid' internal field,
- remove dead code,
- improve code readability.

Tested on Beagleboard B5 with cpuidle in RET and OFF modes.

Another 161 lines of OMAP code gone ;p

Notes:
1) the debugfs 'enable_off_mode' knob will be deprecated by the use
 of the devices constraints framework to restrict the power domains
 power modes.
2) the MPU and CORE power domains low power modes are controlled
 by cpuidle, based on the allowed overall sleep+wake-up latencies
 and the wake-up latency constraints on the MPU. This is incorrect.
 The devices constraints framework shall be used instead to control
 all power domains.

ToDo:
- integrate cpuidle with the devices constraints framework, when merged in,
- refine the latency figures and express them in term of available data
 from other frameworks (OMAP PM, constaints framework, omap_devices,
 new VC/VP voltage and DVFS code ...),

Jean Pihet (5):
  OMAP3 cpuidle: remove useless SDP specific timings
  OMAP3: clean-up mach specific cpuidle data structures
  OMAP3: cpuidle: re-organize the C-states data
  OMAP3: cpuidle: code rework for improved readability
  OMAP3: cpuidle: change the power domains modes determination logic

 arch/arm/mach-omap2/board-3430sdp.c |   19 --
 arch/arm/mach-omap2/board-rx51.c    |   15 +-
 arch/arm/mach-omap2/cpuidle34xx.c   |  424 ++++++++++++-----------------------
 arch/arm/mach-omap2/pm.h            |   17 +-
 arch/arm/mach-omap2/pm34xx.c        |   12 -
 5 files changed, 163 insertions(+), 324 deletions(-)

