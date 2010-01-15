From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/18] OMAP clock: resolve all remaining sparse warnings
Date: Fri, 15 Jan 2010 02:07:10 -0700
Message-ID: <20100115090708.30690.78226.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48754 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845Ab0AOJIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:16 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Resolve all remaining sparse warnings in the OMAP clock code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |    2 +-
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e0f72f4..0ae2753 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(clk_get_parent);
  * OMAP specific clock functions shared between omap1 and omap2
  *-------------------------------------------------------------------------*/
 
-unsigned int __initdata mpurate;
+int __initdata mpurate;
 
 /*
  * By default we use the rate set by the bootloader.
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 896cedc..e413132 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -123,7 +123,7 @@ struct clk_functions {
 #endif
 };
 
-extern unsigned int mpurate;
+extern int mpurate;
 
 extern int clk_init(struct clk_functions *custom_clocks);
 extern void clk_preinit(struct clk *clk);


