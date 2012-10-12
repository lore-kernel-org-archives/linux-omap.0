From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RESEND] [PATCH 3.6.0- 4/6] ARM/pxa: use module_platform_driver macro
Date: Fri, 12 Oct 2012 08:11:27 +0100
Message-ID: <1350025887-30591-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:45205 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756061Ab2JLHNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 03:13:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eric.y.miao@gmail.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, paul@pwsan.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, juha.yrjola@nokia.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-pxa/tosa-bt.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index b9b1e5c..fe2a9e1 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -132,17 +132,4 @@ static struct platform_driver tosa_bt_driver = {
 		.owner = THIS_MODULE,
 	},
 };
-
-
-static int __init tosa_bt_init(void)
-{
-	return platform_driver_register(&tosa_bt_driver);
-}
-
-static void __exit tosa_bt_exit(void)
-{
-	platform_driver_unregister(&tosa_bt_driver);
-}
-
-module_init(tosa_bt_init);
-module_exit(tosa_bt_exit);
+module_platform_driver(tosa_bt_driver);
-- 
1.7.0.4

