From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
Date: Sat,  9 Feb 2013 13:38:12 -0300
Message-ID: <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36624 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760757Ab3BIQiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 11:38:24 -0500
In-Reply-To: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Fix gpmc_cs_reserved() so it returns 0 if the chip select
is available (not reserved) or an error otherwise.
This allows to use the return value directly and return a proper error code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd3bc93..604c1eb 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -452,12 +452,16 @@ static int gpmc_cs_set_reserved(int cs, int reserved)
 	return 0;
 }
 
+/* Returns 0 if CS is available (not reseverd) or an error otherwise */
 static int gpmc_cs_reserved(int cs)
 {
 	if (cs > GPMC_CS_NUM)
 		return -ENODEV;
 
-	return gpmc_cs_map & (1 << cs);
+	if (gpmc_cs_map & (1 << cs))
+		return -EBUSY;
+
+	return 0;
 }
 
 static unsigned long gpmc_mem_align(unsigned long size)
@@ -516,10 +520,10 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 		return -ENOMEM;
 
 	spin_lock(&gpmc_mem_lock);
-	if (gpmc_cs_reserved(cs)) {
-		r = -EBUSY;
+	r = gpmc_cs_reserved(cs);
+	if (r < 0)
 		goto out;
-	}
+
 	if (gpmc_cs_mem_enabled(cs))
 		r = adjust_resource(res, res->start & ~(size - 1), size);
 	if (r < 0)
-- 
1.7.8.6

