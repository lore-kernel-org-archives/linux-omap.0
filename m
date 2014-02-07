From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 0/4] ARM: OMAP2+: AM43x: Enable in OMAP2PLUS and add ID for ES1.1
Date: Fri, 7 Feb 2014 15:51:22 +0530
Message-ID: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbaBGKWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2014 05:22:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

This patch series enables AM43xx SOC in omap2plus_deconfig along with
updating clocksource and adding support for ES1.1.
With this series using omap2plus_defconfig alone boots on AM43XX.

Changes since V1:
- Added a new patch to determine AM43x device features.

Tested on: 
AM4372 EPOS EVM. log for the same http://hastebin.com/pagigecume.xml

Afzal Mohammed (2):
  ARM: OMAP2+: AM43x: enable in default config
  ARM: OMAP2+: AM43x: determine features

Lokesh Vutla (1):
  ARM: OMAP2+: AM43x: Add ID for ES1.1

Rajendra Nayak (1):
  ARM: OMAP2+: AM43x: Use gptimer as clocksource

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/id.c             |   16 ++++++++++++++--
 arch/arm/mach-omap2/io.c             |    1 +
 arch/arm/mach-omap2/soc.h            |    3 ++-
 arch/arm/mach-omap2/timer.c          |    3 ++-
 6 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.7.9.5

