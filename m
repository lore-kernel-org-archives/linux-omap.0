From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1 configs
Date: Fri, 4 Mar 2011 15:36:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36374 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab1CDWgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 17:36:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-kernel@lists.infradead.org


Commit 3cf32bba8ca0e0052ca41d74d455a5805b7fea85 ("OMAP: McBSP: Convert
McBSP to platform device model") in the current omap-for-linus branch
breaks compilation with non-multi-OMAP1 configs:

  CC      arch/arm/mach-omap1/mcbsp.o
arch/arm/mach-omap1/mcbsp.c: In function 'omap1_mcbsp_init':
arch/arm/mach-omap1/mcbsp.c:384: warning: dereferencing 'void *' pointer
arch/arm/mach-omap1/mcbsp.c:387: error: invalid use of void expression
arch/arm/mach-omap1/mcbsp.c:390: warning: dereferencing 'void *' pointer
arch/arm/mach-omap1/mcbsp.c:393: error: invalid use of void expression

Fix by avoiding NULL dereferences.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/mcbsp.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index e68f6c0..d9af981 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -136,6 +136,8 @@ struct resource omap7xx_mcbsp_res[][6] = {
 	},
 };
 
+#define omap7xx_mcbsp_res_0		omap7xx_mcbsp_res[0]
+
 static struct omap_mcbsp_platform_data omap7xx_mcbsp_pdata[] = {
 	{
 		.ops		= &omap1_mcbsp_ops,
@@ -147,7 +149,7 @@ static struct omap_mcbsp_platform_data omap7xx_mcbsp_pdata[] = {
 #define OMAP7XX_MCBSP_RES_SZ		ARRAY_SIZE(omap7xx_mcbsp_res[1])
 #define OMAP7XX_MCBSP_COUNT		ARRAY_SIZE(omap7xx_mcbsp_res)
 #else
-#define omap7xx_mcbsp_res		NULL
+#define omap7xx_mcbsp_res_0		NULL
 #define omap7xx_mcbsp_pdata		NULL
 #define OMAP7XX_MCBSP_RES_SZ		0
 #define OMAP7XX_MCBSP_COUNT		0
@@ -238,6 +240,8 @@ struct resource omap15xx_mcbsp_res[][6] = {
 	},
 };
 
+#define omap15xx_mcbsp_res_0		omap15xx_mcbsp_res[0]
+
 static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 	{
 		.ops		= &omap1_mcbsp_ops,
@@ -252,7 +256,7 @@ static struct omap_mcbsp_platform_data omap15xx_mcbsp_pdata[] = {
 #define OMAP15XX_MCBSP_RES_SZ		ARRAY_SIZE(omap15xx_mcbsp_res[1])
 #define OMAP15XX_MCBSP_COUNT		ARRAY_SIZE(omap15xx_mcbsp_res)
 #else
-#define omap15xx_mcbsp_res		NULL
+#define omap15xx_mcbsp_res_0		NULL
 #define omap15xx_mcbsp_pdata		NULL
 #define OMAP15XX_MCBSP_RES_SZ		0
 #define OMAP15XX_MCBSP_COUNT		0
@@ -343,6 +347,8 @@ struct resource omap16xx_mcbsp_res[][6] = {
 	},
 };
 
+#define omap16xx_mcbsp_res_0		omap16xx_mcbsp_res[0]
+
 static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 	{
 		.ops		= &omap1_mcbsp_ops,
@@ -357,7 +363,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 #define OMAP16XX_MCBSP_RES_SZ		ARRAY_SIZE(omap16xx_mcbsp_res[1])
 #define OMAP16XX_MCBSP_COUNT		ARRAY_SIZE(omap16xx_mcbsp_res)
 #else
-#define omap16xx_mcbsp_res		NULL
+#define omap16xx_mcbsp_res_0		NULL
 #define omap16xx_mcbsp_pdata		NULL
 #define OMAP16XX_MCBSP_RES_SZ		0
 #define OMAP16XX_MCBSP_COUNT		0
@@ -381,19 +387,19 @@ static int __init omap1_mcbsp_init(void)
 		return -ENOMEM;
 
 	if (cpu_is_omap7xx())
-		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res[0],
+		omap_mcbsp_register_board_cfg(omap7xx_mcbsp_res_0,
 					OMAP7XX_MCBSP_RES_SZ,
 					omap7xx_mcbsp_pdata,
 					OMAP7XX_MCBSP_COUNT);
 
 	if (cpu_is_omap15xx())
-		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_res[0],
+		omap_mcbsp_register_board_cfg(omap15xx_mcbsp_res_0,
 					OMAP15XX_MCBSP_RES_SZ,
 					omap15xx_mcbsp_pdata,
 					OMAP15XX_MCBSP_COUNT);
 
 	if (cpu_is_omap16xx())
-		omap_mcbsp_register_board_cfg(omap16xx_mcbsp_res[0],
+		omap_mcbsp_register_board_cfg(omap16xx_mcbsp_res_0,
 					OMAP16XX_MCBSP_RES_SZ,
 					omap16xx_mcbsp_pdata,
 					OMAP16XX_MCBSP_COUNT);
-- 
1.7.2.3

