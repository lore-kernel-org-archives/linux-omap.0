From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: Timer build warnings and error fixes
Date: Tue, 27 Nov 2012 20:15:12 -0600
Message-ID: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52389 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab2K1CPX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 21:15:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Fixes for build warnings and errors seen with various kernel
configuration combinations.

Jon Hunter (3):
  ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
  ARM: OMAP4: Fix build error and warning in timer.c
  ARM: AM335x: Fix warning in timer.c

 arch/arm/mach-omap2/Kconfig |    4 ----
 arch/arm/mach-omap2/timer.c |   12 ++++++------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
1.7.10.4

