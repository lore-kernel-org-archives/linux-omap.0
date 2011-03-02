From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 3/3] omap3+: sr: Reuse sr_[start|stop]_vddautocomp functions
Date: Wed,  2 Mar 2011 17:57:25 +0200
Message-ID: <1299081445-27938-4-git-send-email-jhnikula@gmail.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59934 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1CBP4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 10:56:23 -0500
Received: by mail-ey0-f174.google.com with SMTP id 24so22036eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 07:56:23 -0800 (PST)
In-Reply-To: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

sr_start_vddautocomp and sr_stop_autocomp functions can be reused from
omap_sr_enable, omap_sr_disable and omap_sr_disable_reset_volt and by
adding one additional argument sr_stop_autocomp.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/smartreflex.c |   41 ++++++------------------------------
 1 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 11741d8..7e6002f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -227,7 +227,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
 		sr->autocomp_active = true;
 }
 
-static void sr_stop_vddautocomp(struct omap_sr *sr)
+static void sr_stop_vddautocomp(struct omap_sr *sr, int is_volt_reset)
 {
 	if (!sr->autocomp_active)
 		return;
@@ -239,7 +239,7 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
 		return;
 	}
 
-	if (!sr_class->disable(sr->voltdm, 1))
+	if (!sr_class->disable(sr->voltdm, is_volt_reset))
 		sr->autocomp_active = false;
 }
 
@@ -681,16 +681,7 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
-		return;
-	}
-
-	sr_class->enable(voltdm);
+	sr_start_vddautocomp(sr);
 }
 
 /**
@@ -714,16 +705,7 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 		return;
 	}
 
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
-		return;
-	}
-
-	sr_class->disable(voltdm, 0);
+	sr_stop_vddautocomp(sr, 0);
 }
 
 /**
@@ -747,16 +729,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 		return;
 	}
 
-	if (!sr->autocomp_active)
-		return;
-
-	if (!sr_class || !(sr_class->disable)) {
-		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
-			"registered\n", __func__);
-		return;
-	}
-
-	sr_class->disable(voltdm, 1);
+	sr_stop_vddautocomp(sr, 1);
 }
 
 /**
@@ -809,7 +782,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	if (!val)
-		sr_stop_vddautocomp(sr_info);
+		sr_stop_vddautocomp(sr_info, 1);
 	else
 		sr_start_vddautocomp(sr_info);
 
@@ -976,7 +949,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	}
 
 	if (sr_info->autocomp_active)
-		sr_stop_vddautocomp(sr_info);
+		sr_stop_vddautocomp(sr_info, 1);
 
 	list_del(&sr_info->node);
 	iounmap(sr_info->base);
-- 
1.7.2.3

