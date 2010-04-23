From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19/28] omap4: Fix McBSP4 base address
Date: Fri, 23 Apr 2010 16:11:48 -0700
Message-ID: <20100423231148.31953.20114.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61922 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab0DWXLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:48 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the McBSP4 base address for OMAP4

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 3974835..7de903d 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -59,7 +59,7 @@
 #define OMAP44XX_MCBSP1_BASE	0x49022000
 #define OMAP44XX_MCBSP2_BASE	0x49024000
 #define OMAP44XX_MCBSP3_BASE	0x49026000
-#define OMAP44XX_MCBSP4_BASE	0x48074000
+#define OMAP44XX_MCBSP4_BASE	0x48096000
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 

