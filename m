From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RESEND] [PATCH 3.6.0- 5/6] ARM/omap: use module_platform_driver macro
Date: Fri, 12 Oct 2012 08:11:34 +0100
Message-ID: <1350025894-30625-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:40422 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756061Ab2JLHNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 03:13:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/plat-omap/dmtimer.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 938b50a..c89fc6a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -786,19 +786,8 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-static int __init omap_dm_timer_driver_init(void)
-{
-	return platform_driver_register(&omap_dm_timer_driver);
-}
-
-static void __exit omap_dm_timer_driver_exit(void)
-{
-	platform_driver_unregister(&omap_dm_timer_driver);
-}
-
 early_platform_init("earlytimer", &omap_dm_timer_driver);
-module_init(omap_dm_timer_driver_init);
-module_exit(omap_dm_timer_driver_exit);
+module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
-- 
1.7.0.4

