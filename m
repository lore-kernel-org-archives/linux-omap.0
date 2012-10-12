From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: [RESEND] [PATCH 3.6.0- 1/6] ARM/omap1: use module_platform_driver macro
Date: Fri, 12 Oct 2012 08:11:08 +0100
Message-ID: <1350025868-30482-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:56340 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756243Ab2JLHNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 03:13:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, rnayak@ti.com
Cc: srinivas.kandagatla@st.com, Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, tarun.kanti@ti.com, thara@ti.com, grinberg@compulab.co.il, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, juha.yrjola@nokia.com, linux@arm.linux.org.uk, haojian.zhuang@gmail.com, dsaxena@plexity.net, mpm@selenic.com, herbert@gondor.apana.org.au

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

