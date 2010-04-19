From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 1/9] omap: fix the compile error if CONFIG_MTD_NAND_OMAP2 is not enabled
Date: Mon, 19 Apr 2010 18:20:39 +0800
Message-ID: <1271672447-3639-2-git-send-email-stanley.miao@windriver.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51705 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0DSKL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 06:11:56 -0400
In-Reply-To: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, hvaibhav@ti.com, srk@ti.com

If CONFIG_MTD_NAND_OMAP2 is not enabled, there will be a compile error,
"gpmc_nand_init() is not defined". Add a inline noop function to fix it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/plat-omap/include/plat/nand.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 6ba88d2..f8efd54 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -29,4 +29,11 @@ struct omap_nand_platform_data {
 /* size (4 KiB) for IO mapping */
 #define	NAND_IO_SIZE	SZ_4K
 
+#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
 extern int gpmc_nand_init(struct omap_nand_platform_data *d);
+#else
+static inline int gpmc_nand_init(struct omap_nand_platform_data *d)
+{
+	return 0;
+}
+#endif
-- 
1.5.4.3

