From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 7/9] omap: introduce omap4 feature
Date: Tue, 22 Jun 2010 21:16:13 -0500
Message-ID: <1277259375-18521-8-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45145 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0FWCQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 22:16:22 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

introduce basic omap4 feature framework

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 01555b6..e3f5994 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -267,6 +267,19 @@ static void __init omap3_check_revision(void)
 	}
 }
 
+static void __init omap4_check_features(void)
+{
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	if (cpu_is_omap4430())
+		omap_features |= OMAP_HAS_L2CACHE |
+			OMAP_HAS_IVA |
+			OMAP_HAS_SGX |
+			OMAP_HAS_NEON;
+}
+
 static void __init omap4_check_revision(void)
 {
 	u32 idcode;
@@ -382,6 +395,7 @@ void __init omap2_check_revision(void)
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
+		omap4_check_features();
 		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
-- 
1.6.3.3

