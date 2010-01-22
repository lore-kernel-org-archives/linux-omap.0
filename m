From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 2/3] OMAP3: VC: simply struct copy in init_vc routine
Date: Thu, 21 Jan 2010 17:02:20 -0800
Message-ID: <1264122141-17886-3-git-send-email-khilman@deeprootsystems.com>
References: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:60567 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab0AVBC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 20:02:27 -0500
Received: by mail-iw0-f196.google.com with SMTP id 34so557850iwn.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 17:02:27 -0800 (PST)
In-Reply-To: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>

Rather than copy each field, just to a struct copy.
---
 arch/arm/mach-omap2/vc.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 61d1e4a..c238002 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -41,22 +41,8 @@ static struct prm_setup_vc prm_setup = {
 
 void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 {
-	if (!setup_vc)
-		return;
-
-	prm_setup.clksetup = setup_vc->clksetup;
-	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
-	prm_setup.voltoffset = setup_vc->voltoffset;
-	prm_setup.voltsetup2 = setup_vc->voltsetup2;
-	prm_setup.vdd0_on = setup_vc->vdd0_on;
-	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
-	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
-	prm_setup.vdd0_off = setup_vc->vdd0_off;
-	prm_setup.vdd1_on = setup_vc->vdd1_on;
-	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
-	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
-	prm_setup.vdd1_off = setup_vc->vdd1_off;
+	if (setup_vc)
+		prm_setup = *setup_vc;
 }
 
 static void __init configure_vc(void)
-- 
1.6.6

