From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/4] omap: mailbox cleanup: split MODULE_AUTHOR line
Date: Mon, 10 May 2010 12:16:51 +0300
Message-ID: <1273483013-5942-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28065 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab0EJJRK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:17:10 -0400
In-Reply-To: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Ohad Ben-Cohen <ohad@wizery.com>

use multiple MODULE_AUTHOR lines for multiple authors

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 arch/arm/plat-omap/mailbox.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 318f363..763272c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -486,5 +486,6 @@ module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
-MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_AUTHOR("Paul Mundt");
 MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index af3a6ac..5140efc 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -419,4 +419,5 @@ module_exit(omap_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: interrupt driven messaging");
-MODULE_AUTHOR("Toshihiro Kobayashi and Hiroshi DOYU");
+MODULE_AUTHOR("Toshihiro Kobayashi");
+MODULE_AUTHOR("Hiroshi DOYU");
-- 
1.7.1.rc1

