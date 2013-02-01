From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: GPMC Fixes
Date: Fri, 1 Feb 2013 10:38:44 -0600
Message-ID: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867Ab3BAQiz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 11:38:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>, Jon Hunter <jon-hunter@ti.com>

A couple GPMC fixes for OMAP2+ devices which were causing boot problems
on OMAP2420 H4.

Please note that long term we need to remove the cpu_is_omap24xx() from
the gpmc driver and pass the gpmc_mem_root information via platform data
and figure out a way to pass this information for device tree.

Boot tested on OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP and AM335x EVM.

Jon Hunter (2):
  ARM: OMAP2+: Prevent potential crash if GPMC probe fails
  ARM: OMAP2: Fix GPMC memory initialisation

 arch/arm/mach-omap2/gpmc.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
1.7.10.4

