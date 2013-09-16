From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC v3 00/12] ARM: OMAP2+: AM43x PRCM basic support
Date: Mon, 16 Sep 2013 19:16:02 +0530
Message-ID: <cover.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab3IPNqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 09:46:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul, Benoit,

This series adds PRCM support for AM43x SoC's. It has been modified
as compared to last version based on Rajendra's comments and discussion
with him, please let me know your comments on this series.

Major changes (as compared to v2):
1. omap_hwmod_33xx_43xx_interconnect_data.c has all the common
   interconnect ocp's structs shared between AM335x and AM43x
2. omap_hwmod_33xx_43xx_ipblock_data.c has all the common hwmod structs
   shared between AM335x and AM43x
3. Instances where clock domain or clock topology has changed in the few
   cases, have separate structures for AM335x and AM43x
4. To handle scenarios where register offsets are different, they are
   dynamically init-ed in omap_hwmod_33xx_43xx_ipblock_data.c
5. Register offsets for hwmod's that are present either in AM335x or
   AM43x are updated statically in omap_hwmod_33xx_data.c or
   omap_hwmod_43xx_data.c as that was cleaner.

Please note that this series is only compile tested, yet to be tested on
pre-silicon platform (hence RFC), testing on pre-silicon platform takes
huge amount of time (1 second realtime ~ 1 hour on pre-silicon). Here
the intention is to get early feedback on the approach taken for hwmod.

This series has been boot tested on AM335x-EVM.

And the diffstat is now +1500 (+3500 -2000).

The change that re-introduces SW_SLEEP for OMAP4 has been left out from
this series, it will be properly taken care in the next version - as
here main intention is to know acceptability of approach towards hwmod.


Some more details:
AM43x reuses most of the IP's from AM335x, as that is the case, much of
the AM335x hwmod data is reused. As AM43x PRCM register layout differs
from AM335x and is similar to OMAP4, power domain, clock domain & hwmod
operations are reused from OMAP4. Currently there is no public TRM
available for AM43x.


Regards
Afzal


Afzal Mohammed (8):
  ARM: OMAP2+: hwmod: AM335x/AM43x: move common ocpif
  ARM: OMAP2+: hwmod: AM335x/AM43x: move common hwmod
  ARM: OMAP2+: hwmod: AM335x: runtime register update
  ARM: OMAP2+: hwmod: AM335x: remove static register offs
  ARM: OMAP2+: PRCM: AM43x definitions
  ARM: OMAP2+: hwmod: AM43x support
  ARM: OMAP2+: hwmod: AM43x operations
  ARM: OMAP2+: AM43x: PRCM kbuild

Ambresh K (3):
  ARM: OMAP2+: PM: AM43x powerdomain data
  ARM: OMAP2+: CM: AM43x clockdomain data
  ARM: OMAP2+: AM43x PRCM init

Ankur Kishore (1):
  ARM: OMAP2+: CM: cm_inst offset s16->u16

 arch/arm/mach-omap2/Makefile                       |    9 +-
 arch/arm/mach-omap2/clockdomain.h                  |    4 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c        |  199 ++
 arch/arm/mach-omap2/cm33xx.c                       |   30 +-
 arch/arm/mach-omap2/cm33xx.h                       |   28 +-
 arch/arm/mach-omap2/cminst44xx.c                   |   40 +-
 arch/arm/mach-omap2/cminst44xx.h                   |   25 +-
 arch/arm/mach-omap2/io.c                           |    6 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    8 +
 arch/arm/mach-omap2/omap_hwmod.h                   |    1 +
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h  |  157 ++
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  656 +++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1475 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 1969 +-------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  645 +++++++
 arch/arm/mach-omap2/powerdomain.h                  |    1 +
 arch/arm/mach-omap2/powerdomains43xx_data.c        |  145 ++
 arch/arm/mach-omap2/prcm43xx.h                     |  141 ++
 18 files changed, 3514 insertions(+), 2025 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_43xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm43xx.h

-- 
1.8.3.4

