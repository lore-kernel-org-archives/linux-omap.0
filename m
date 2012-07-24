From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/5] arm: omap: debug-leds: few changes
Date: Tue, 24 Jul 2012 11:53:57 +0300
Message-ID: <1343120042-16695-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53888 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752473Ab2GXI5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 04:57:19 -0400
Received: by lago2 with SMTP id o2so615078lag.15
        for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 01:57:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are a few changes for the debug-leds driver. This series tries to get the
driver closer to be moved away from arch/arm/plat-omap/ and under drivers/leds.
There's only the dependency with <plat/fpga.h> now.

I tried moving the needed definitions into the C file, but there's another file
which uses the same structure (arch/arm/mach-omap1/leds-h2p2-debug.c) so I left
it for another series. Ideally, omap1 would be using the same debug-leds driver
for that purpose and we could drop the dependency on <plat/fpga.h>.

BTW, patches were compile tested only due to the lack of an H4 board.

Felipe Balbi (5):
  arm: omap: debug-leds: drop machine_is_* checks
  arm: omap: debug-leds: move initialization to debug-leds
  arm: omap: debug-leds: add section annotation to probe
  arm: omap: debug-leds: add a remove method
  arm: omap: debug-leds: switch to resource_size()

 arch/arm/plat-omap/debug-leds.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

-- 
1.7.11

