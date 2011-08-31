From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 12/14] omap: mcbsp: Move address definitions to arch/arm/mach-omap1/mcbsp.c
Date: Wed, 31 Aug 2011 18:22:59 +0300
Message-ID: <1314804181-17260-13-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:36919 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756630Ab1HaPle (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:41:34 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

These address definitions are OMAP1 specific can be in single source file.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/mcbsp.c             |   11 +++++++++++
 arch/arm/plat-omap/include/plat/mcbsp.h |   11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 36ab5d8..91f9abb 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -79,6 +79,17 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops = {
 	.free		= omap1_mcbsp_free,
 };
 
+#define OMAP7XX_MCBSP1_BASE	0xfffb1000
+#define OMAP7XX_MCBSP2_BASE	0xfffb1800
+
+#define OMAP1510_MCBSP1_BASE	0xe1011800
+#define OMAP1510_MCBSP2_BASE	0xfffb1000
+#define OMAP1510_MCBSP3_BASE	0xe1017000
+
+#define OMAP1610_MCBSP1_BASE	0xe1011800
+#define OMAP1610_MCBSP2_BASE	0xfffb1000
+#define OMAP1610_MCBSP3_BASE	0xe1017000
+
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 struct resource omap7xx_mcbsp_res[][6] = {
 	{
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 5d657d9..af5824a 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -38,17 +38,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define MCBSP_CONFIG_TYPE3	0x3
 #define MCBSP_CONFIG_TYPE4	0x4
 
-#define OMAP7XX_MCBSP1_BASE	0xfffb1000
-#define OMAP7XX_MCBSP2_BASE	0xfffb1800
-
-#define OMAP1510_MCBSP1_BASE	0xe1011800
-#define OMAP1510_MCBSP2_BASE	0xfffb1000
-#define OMAP1510_MCBSP3_BASE	0xe1017000
-
-#define OMAP1610_MCBSP1_BASE	0xe1011800
-#define OMAP1610_MCBSP2_BASE	0xfffb1000
-#define OMAP1610_MCBSP3_BASE	0xe1017000
-
 /* McBSP register numbers. Register address offset = num * reg_step */
 enum {
 	/* Common registers */
-- 
1.7.5.4

