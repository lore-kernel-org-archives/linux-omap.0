From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 30/35] ARM: OMAP3: io: remove early PM init when hwmod data is built as module
Date: Wed, 15 Apr 2015 15:53:17 +0300
Message-ID: <1429102402-5276-31-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47081 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbbDOMxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:21 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

If hwmod data is built as a module, PM init will be done after the module
has been loaded. PM code has dependencies towards certain hwmods, which
are not going to be available during early init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 258e5ac..6cb1e40 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -487,8 +487,10 @@ void __init am35xx_init_early(void)
 void __init omap3_init_late(void)
 {
 	omap_common_late_init();
+#ifndef CONFIG_OMAP_HWMOD_DATA_MODULES
 	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
+#endif
 }
 
 void __init omap3430_init_late(void)
-- 
1.7.9.5

