From: jean.pihet@newoldbits.com
Subject: [PATCH v3 0/4] OMAP: cpuidle code clean-up
Date: Mon,  9 May 2011 12:02:12 +0200
Message-ID: <1304935336-6308-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33090 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1EIKCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 06:02:19 -0400
Received: by wya21 with SMTP id 21so3737777wya.19
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 03:02:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Rework of the OMAP2+ cpuidle code

v3: rework after comments on linux-omap ML:
- renamed the C-state driver data variables as 'cx',
- retain C1 as the only always valid state and safe state,
- rework of the C-states definition.

v2: rework after comments on linux-omap ML:
- remove useless macros,
- replace the C-state common data fill-in helper macro by an inline
   function, for better readability,
- update commits description.

v1:
- optimize the cpuidle C-states data registration and storage,
- change the interaction with the debugfs 'enable_off_mode' knob
 and the use of the C-states 'valid' internal field,
- remove dead code,
- improve code readability.

Tested on Beagleboard B5 with cpuidle in RET and OFF modes.

Another 151 lines of OMAP code gone ;p

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

Rebased on khilman's for_2.6.40/pm-cleanup branch


Jean Pihet (4):
  OMAP3: clean-up mach specific cpuidle data structures
  OMAP3: cpuidle: re-organize the C-states data
  OMAP3: cpuidle: code rework for improved readability
  OMAP3: cpuidle: change the power domains modes determination logic

 arch/arm/mach-omap2/board-rx51.c  |   18 +-
 arch/arm/mach-omap2/cpuidle34xx.c |  436 +++++++++++++------------------------
 arch/arm/mach-omap2/pm.h          |   17 +-
 arch/arm/mach-omap2/pm34xx.c      |   12 -
 4 files changed, 166 insertions(+), 317 deletions(-)

-- 
1.7.2.5

