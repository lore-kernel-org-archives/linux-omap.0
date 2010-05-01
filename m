From: virtuoso@slind.org
Subject: [PATCH 1/6] coresight: add ETM management registers
Date: Sat,  1 May 2010 20:38:16 +0300
Message-ID: <1272735501-2963-2-git-send-email-virtuoso@slind.org>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44773 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0EARlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:41:20 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

Add notion of ETM OS lock, save and restore registers.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/include/asm/hardware/coresight.h |    8 ++++++--
 arch/arm/kernel/etm.c                     |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
index 8838be1..d846051 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -36,8 +36,6 @@
 /* CoreSight Component Registers */
 #define CSCR_CLASS	0xff4
 
-#define CSCR_PRSR	0x314
-
 #define UNLOCK_MAGIC	0xc5acce55
 
 /* ETM control register, "ETM Architecture", 3.3.1 */
@@ -120,6 +118,12 @@
 				ETMCTRL_BRANCH_OUTPUT | \
 				ETMCTRL_DO_CONTEXTID)
 
+/* ETM management registers, "ETM Architecture", 3.5.24 */
+#define ETMMR_OSLAR	0x300
+#define ETMMR_OSLSR	0x304
+#define ETMMR_OSSRR	0x308
+#define ETMMR_PDSR	0x314
+
 /* ETB registers, "CoreSight Components TRM", 9.3 */
 #define ETBR_DEPTH		0x04
 #define ETBR_STATUS		0x0c
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 47a38af..d08062b 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -558,7 +558,7 @@ static int __init etm_probe(struct amba_device *dev, struct amba_id *id)
 	t->etm_portsz = 1;
 
 	etm_unlock(t);
-	ret = etm_readl(t, CSCR_PRSR);
+	ret = etm_readl(t, ETMMR_PDSR);
 
 	t->ncmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
 	etm_writel(t, 0x440, ETMR_CTRL);
-- 
1.7.1.1.g15764

