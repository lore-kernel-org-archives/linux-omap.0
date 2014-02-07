From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 3/4] ARM: OMAP2+: AM43x: determine features
Date: Fri, 7 Feb 2014 15:51:25 +0530
Message-ID: <1391768486-2134-4-git-send-email-lokeshvutla@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35676 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbaBGKWC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Feb 2014 05:22:02 -0500
In-Reply-To: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

From: Afzal Mohammed <afzal@ti.com>

Determine AM43x device features by reusing AM335x helper as feature
register layout is similar.
And also exporting AM43xx family name.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/id.c |    2 ++
 arch/arm/mach-omap2/io.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 8a05eaf..157412e 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -667,6 +667,8 @@ static const char * __init omap_get_family(void)
 		return kasprintf(GFP_KERNEL, "OMAP4");
 	else if (soc_is_omap54xx())
 		return kasprintf(GFP_KERNEL, "OMAP5");
+	else if (soc_is_am43xx())
+		return kasprintf(GFP_KERNEL, "AM43xx");
 	else
 		return kasprintf(GFP_KERNEL, "Unknown");
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d408b15..d971411 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -613,6 +613,7 @@ void __init am43xx_init_early(void)
 	omap_prm_base_init();
 	omap_cm_base_init();
 	omap3xxx_check_revision();
+	am33xx_check_features();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
-- 
1.7.9.5

