From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 0/3] PM: Misc latency fixes
Date: Wed, 21 Oct 2009 14:51:18 +0300
Message-ID: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:10267 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbZJULvB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 07:51:01 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Hello,
Here are some fruits from digging out the latency sources
of our idle loop. The main latency source was powerdomain
state counter updating at beginning and end of the idle
loop. Also PER previous state reading strangely seemed to
cause some latency with significance. Could not find any
TRM or errata comment to why this is, though.

The I2C mpu wakeup latency constraint patch has been updated
to calculate latencies at boot from clkrate and fifo size.
This was included in this set, since it benefits from the
reduced latency of the other patches.

Patches tested on linux-omap/pm and rx-51.

Kalle Jokiniemi (3):
      OMAP3: Only update pm-counters when needed
      PM: Skip PER previous state register read
      OMAP: I2C: Add mpu wake up latency constraint in i2c

 arch/arm/mach-omap2/pm-debug.c |   51 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h       |    2 +
 arch/arm/mach-omap2/pm34xx.c   |   31 ++++++++++++++--------
 arch/arm/plat-omap/i2c.c       |   54 +++++++++++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-omap.c  |   25 +++++++++++++++---
 include/linux/i2c-omap.h       |    9 ++++++
 6 files changed, 143 insertions(+), 29 deletions(-)


