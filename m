From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 12/21] ARM: OMAP: beagle: set oscillator startup time to 10ms for rev c4
Date: Tue, 25 Sep 2012 19:33:44 +0300
Message-ID: <1348590833-12335-13-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60228 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758042Ab2IYQe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 12:34:26 -0400
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Based on the oscillator datasheet for this device.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 0d2a45f..304fc48 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -486,6 +486,9 @@ static void __init beagle_opp_init(void)
 			opp_disable(mpu_dev, 720000000);
 			opp_disable(iva_dev, 520000000);
 		}
+
+		/* Set oscillator startup time to 10ms, shutdown not used */
+		omap_pm_setup_oscillator(10000, ULONG_MAX);
 	}
 
 	/* Custom OPP enabled for all xM versions */
-- 
1.7.4.1

