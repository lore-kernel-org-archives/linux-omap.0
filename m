From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PM-WIP-OPP][PATCH] OMAP3630 PM: Update for OPP 1GHz
Date: Wed,  7 Apr 2010 02:06:09 +0800
Message-ID: <1270577169-8831-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab0DFM22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 08:28:28 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o36CSOFU008873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 07:28:27 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

It is found that system is not very stable with current 1GHz OPP configuration 
(ARM@1G, IVA@880M, VDD1@1.31V) and it has been recommended to 
use below configuration for stable 1GHz OPP. 
(ARM@1G, IVA@800M, VDD1@1.35V).

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index c453ec5..189c42e
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -82,7 +82,7 @@ static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
 	/* OPP3 - OPP-Turbo */
 	OMAP_OPP_DEF(false, 800000000, 1260000),
 	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 1000000000, 1310000),
+	OMAP_OPP_DEF(false, 1000000000, 1350000),
 	/* Terminator */
 	OMAP_OPP_DEF(0, 0, 0)
 };
@@ -104,7 +104,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	/* OPP3 - OPP-Turbo */
 	OMAP_OPP_DEF(false, 660000000, 1260000),
 	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 875000000, 1310000),
+	OMAP_OPP_DEF(false, 800000000, 1350000),
 	/* Terminator */
 	OMAP_OPP_DEF(0, 0, 0)
 };
