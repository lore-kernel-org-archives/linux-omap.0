From: jean.pihet@newoldbits.com
Subject: [PATCH v2 0/4] OMAP: cpuidle code clean-up
Date: Thu,  5 May 2011 17:12:35 +0200
Message-ID: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63626 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1EEPMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 11:12:50 -0400
Received: by wwa36 with SMTP id 36so2475814wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 08:12:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Rework of the OMAP2+ cpuidle code

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

Another 145 lines of OMAP code gone ;p

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
 arch/arm/mach-omap2/cpuidle34xx.c |  426 +++++++++++++------------------------
 arch/arm/mach-omap2/pm.h          |   17 +-
 arch/arm/mach-omap2/pm34xx.c      |   12 -
 4 files changed, 164 insertions(+), 309 deletions(-)

-- 
1.7.2.5

