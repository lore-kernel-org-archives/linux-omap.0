From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 11/11] omap4: use lp params for calculating pmic setup times
Date: Wed, 5 Oct 2011 20:17:11 +0300
Message-ID: <1317835031-8201-12-git-send-email-t-kristo@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35071 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935152Ab1JERRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:41 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHf7r017477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:41 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHeI9003328
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:40 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHeWZ001846
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:40 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index ee0edf3..badf28b 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -381,6 +381,15 @@ static void omap4_set_timings(struct voltagedomain *voltdm, bool off_mode)
 		OMAP4_DOWNTIME_MASK);
 
 	__raw_writel(val, OMAP4_SCRM_CLKSETUPTIME);
+
+	omap_pm_get_pmic_lp_time(&tstart, &tshut);
+
+	val = omap4_usec_to_val_scrm(tstart, OMAP4_WAKEUPTIME_SHIFT,
+		OMAP4_WAKEUPTIME_MASK);
+	val |= omap4_usec_to_val_scrm(tshut, OMAP4_SLEEPTIME_SHIFT,
+		OMAP4_SLEEPTIME_MASK);
+
+	__raw_writel(val, OMAP4_SCRM_PMICSETUPTIME);
 }
 
 /* OMAP4 specific voltage init functions */
-- 
1.7.4.1


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

