From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 3/6] ARM/pxa: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:30:37 +0100
Message-ID: <1349893837-7441-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:56989 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293Ab2JJScC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 14:32:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-pxa/pxa3xx-ulpi.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
index 7dbe3cc..e329cce 100644
--- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -384,18 +384,7 @@ static struct platform_driver pxa3xx_u2d_ulpi_driver = {
         .probe          = pxa3xx_u2d_probe,
         .remove         = pxa3xx_u2d_remove,
 };
-
-static int pxa3xx_u2d_ulpi_init(void)
-{
-	return platform_driver_register(&pxa3xx_u2d_ulpi_driver);
-}
-module_init(pxa3xx_u2d_ulpi_init);
-
-static void __exit pxa3xx_u2d_ulpi_exit(void)
-{
-	platform_driver_unregister(&pxa3xx_u2d_ulpi_driver);
-}
-module_exit(pxa3xx_u2d_ulpi_exit);
+module_platform_driver(pxa3xx_u2d_ulpi_driver);
 
 MODULE_DESCRIPTION("PXA3xx U2D ULPI driver");
 MODULE_AUTHOR("Igor Grinberg");
-- 
1.7.0.4

