From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/28] omap: fix the compile error if CONFIG_MTD_NAND_OMAP2 is
	notenabled
Date: Fri, 23 Apr 2010 16:11:34 -0700
Message-ID: <20100423231134.31953.95895.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61692 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0DWXLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:34 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: stanley.miao <stanley.miao@windriver.com>

If CONFIG_MTD_NAND_OMAP2 is not enabled, there will be a compile error,
"gpmc_nand_init() is not defined". Add a inline noop function to fix it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

