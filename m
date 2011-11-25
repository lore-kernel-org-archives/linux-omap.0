From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 08/15] omap4: use pmic params for calculating pmic setup times
Date: Fri, 25 Nov 2011 17:49:41 +0200
Message-ID: <1322236188-19456-9-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41907 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab1KYPuL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:11 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoAHC003210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:10 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFoATl003827
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:10 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoAsj017865
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:10 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

As voltdm->pmic now contains startup and shutdown times for PMIC, use
these for calculating the fields in the PMICSETUPTIME register.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 351319c..1562aa9 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -407,6 +407,17 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 		OMAP4_DOWNTIME_MASK);
 
 	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
+
+	tstart = voltdm->pmic->startup_time;
+	tshut = voltdm->pmic->shutdown_time;
+
+	if (tstart && tshut) {
+		val = omap4_usec_to_val_scrm(tstart, OMAP4_WAKEUPTIME_SHIFT,
+			OMAP4_WAKEUPTIME_MASK);
+		val |= omap4_usec_to_val_scrm(tshut, OMAP4_SLEEPTIME_SHIFT,
+			OMAP4_SLEEPTIME_MASK);
+		__raw_writel(val, OMAP4_SCRM_PMICSETUPTIME);
+	}
 }
 
 /* OMAP4 specific voltage init functions */
-- 
1.7.4.1

