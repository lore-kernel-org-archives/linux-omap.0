From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] ARM: OMAP1: Define OMAP1_INT_I2C locally
Date: Thu, 30 Aug 2012 17:52:24 -0700
Message-ID: <20120831005224.28732.88615.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17173 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2HaAwZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:25 -0400
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is needed to start removing hardcoded IRQs for omap2+.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index db071bc..40bc06a 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -39,6 +39,7 @@
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
+#define OMAP1_INT_I2C		(32 + 4)
 
 static const char name[] = "omap_i2c";
 
@@ -105,7 +106,7 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	res = pdev->resource;
 	res[0].start = OMAP1_I2C_BASE;
 	res[0].end = res[0].start + OMAP_I2C_SIZE;
-	res[1].start = INT_I2C;
+	res[1].start = OMAP1_INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
 	/* all OMAP1 have IP version 1 register set */

