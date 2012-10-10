From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 6/6] omap_rng: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:31:07 +0100
Message-ID: <1349893867-7548-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:48452 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293Ab2JJScb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 14:32:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 drivers/char/hw_random/omap-rng.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index a5effd8..29732c6 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -217,19 +217,7 @@ static struct platform_driver omap_rng_driver = {
 	.probe		= omap_rng_probe,
 	.remove		= __exit_p(omap_rng_remove),
 };
-
-static int __init omap_rng_init(void)
-{
-	return platform_driver_register(&omap_rng_driver);
-}
-
-static void __exit omap_rng_exit(void)
-{
-	platform_driver_unregister(&omap_rng_driver);
-}
-
-module_init(omap_rng_init);
-module_exit(omap_rng_exit);
+module_platform_driver(omap_rng_driver);
 
 MODULE_AUTHOR("Deepak Saxena (and others)");
 MODULE_LICENSE("GPL");
-- 
1.7.0.4

