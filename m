From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 10/15] omap: beagle: set oscillator startup time to 10ms for rev c4
Date: Fri, 25 Nov 2011 17:49:43 +0200
Message-ID: <1322236188-19456-11-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47900 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab1KYPuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 10:50:14 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoErD006353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:14 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFoDsg005590
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:13 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoD8S017930
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:13 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Based on the oscillator datasheet for this device.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a7c3d60..5e3f575 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -516,6 +516,9 @@ static void __init beagle_opp_init(void)
 			opp_disable(mpu_dev, 720000000);
 			opp_disable(iva_dev, 520000000);
 		}
+
+		/* Setup oscillator startup time to 10ms */
+		omap_pm_setup_oscillator(10000, 0);
 	}
 
 	/* Custom OPP enabled for all xM versions */
-- 
1.7.4.1

