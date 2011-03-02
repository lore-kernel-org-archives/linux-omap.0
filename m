From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 2/3] omap3+: sr: Sync sr_stop_vddautocomp implementation with sr_start_vddautocomp
Date: Wed,  2 Mar 2011 17:57:24 +0200
Message-ID: <1299081445-27938-3-git-send-email-jhnikula@gmail.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59934 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab1CBP4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 10:56:20 -0500
Received: by mail-ey0-f174.google.com with SMTP id 24so22036eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 07:56:20 -0800 (PST)
In-Reply-To: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

This is mostly preparation for another patch that takes these functions into
use from omap_sr_enable and omap_sr_disable.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/smartreflex.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d94894a..11741d8 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -229,6 +229,9 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 
 static void sr_stop_vddautocomp(struct omap_sr *sr)
 {
+	if (!sr->autocomp_active)
+		return;
+
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev,
 			"%s: smartreflex class driver not registered\n",
@@ -236,10 +239,8 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
-	if (sr->autocomp_active) {
-		sr_class->disable(sr->voltdm, 1);
+	if (!sr_class->disable(sr->voltdm, 1))
 		sr->autocomp_active = false;
-	}
 }
 
 /*
-- 
1.7.2.3

