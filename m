From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 29/35] ARM: OMAP2+: io: remove common_pm_late_init if using hwmod data modules
Date: Wed, 15 Apr 2015 15:53:16 +0300
Message-ID: <1429102402-5276-30-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769AbbDOMxT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:19 -0400
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
index c2b80b8..258e5ac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -354,7 +354,9 @@ static int __init _omap2_init_reprogram_sdrc(void)
 static void __init __maybe_unused omap_common_late_init(void)
 {
 	omap_mux_late_init();
+#ifndef CONFIG_OMAP_HWMOD_DATA_MODULES
 	omap2_common_pm_late_init();
+#endif
 	omap_soc_device_init();
 }
 
-- 
1.7.9.5

