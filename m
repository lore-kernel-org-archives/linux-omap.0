From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [PATCH 3.6.0- 1/6] ARM/omap1: use module_platform_driver macro
Date: Wed, 10 Oct 2012 19:30:10 +0100
Message-ID: <1349893810-7370-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:46094 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab2JJSbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 14:31:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, tony@atomide.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-omap1/mailbox.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e962926..45c8719 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -179,19 +179,7 @@ static struct platform_driver omap1_mbox_driver = {
 		.name	= "omap-mailbox",
 	},
 };
-
-static int __init omap1_mbox_init(void)
-{
-	return platform_driver_register(&omap1_mbox_driver);
-}
-
-static void __exit omap1_mbox_exit(void)
-{
-	platform_driver_unregister(&omap1_mbox_driver);
-}
-
-module_init(omap1_mbox_init);
-module_exit(omap1_mbox_exit);
+module_platform_driver(omap1_mbox_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
-- 
1.7.0.4

