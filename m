From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 0/4] ARM: OMAP2+: Timer build warnings and error fixes
Date: Wed, 28 Nov 2012 16:04:56 -0600
Message-ID: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932507Ab2K1WFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 17:05:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Fixes for build warnings and errors seen with various kernel
configuration combinations. Based upon Tony Lindgren's OMAP
master branch.

V2 changes:
- Update fix for realtime counter per feedback from Santosh
- Update fix when building for only AM335x with Igor's suggestion to
  use __maybe_unused (thanks Igor!)
- Add Vaibhav's fixes for sparse warnings

Jon Hunter (3):
  ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
  ARM: OMAP4: Fix build error and warning in timer.c
  ARM: AM335x: Fix warning in timer.c

Vaibhav Hiremath (1):
  ARM: OMAP2+: Fix sparse warnings in timer.c

 arch/arm/mach-omap2/Kconfig |    3 ++-
 arch/arm/mach-omap2/timer.c |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
1.7.10.4

