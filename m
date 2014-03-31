From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/55] ARM: AM33xx: PRM: remove references to prm-regbits-33xx.h from PRM core code
Date: Mon, 31 Mar 2014 18:15:56 +0300
Message-ID: <1396278994-12624-18-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbaCaPRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:17:51 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make PRM a standalone driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm33xx.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 0660105..877d7c7 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -21,7 +21,13 @@
 
 #include "powerdomain.h"
 #include "prm33xx.h"
-#include "prm-regbits-33xx.h"
+
+#define AM33XX_LASTPOWERSTATEENTERED_SHIFT	24
+#define AM33XX_LASTPOWERSTATEENTERED_MASK	(0x3 << 24)
+#define AM33XX_LOGICSTATEST_SHIFT		2
+#define AM33XX_LOGICSTATEST_MASK		(1 << 2)
+#define AM33XX_LOWPOWERSTATECHANGE_SHIFT	4
+#define AM33XX_LOWPOWERSTATECHANGE_MASK		(1 << 4)
 
 /* Read a register in a PRM instance */
 u32 am33xx_prm_read_reg(s16 inst, u16 idx)
-- 
1.7.9.5

