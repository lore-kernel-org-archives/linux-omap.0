From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 12/14] ARM: OMAP: beagle: set oscillator startup time to 10ms for rev c4
Date: Thu, 31 May 2012 16:55:48 +0300
Message-ID: <1338472550-20743-13-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290Ab2EaN4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 09:56:18 -0400
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Based on the oscillator datasheet for this device.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 09aa4b1..4737234 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -488,6 +488,9 @@ static void __init beagle_opp_init(void)
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

