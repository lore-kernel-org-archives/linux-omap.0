From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 2/2] smc911x: Add support for LAN9211 chips from SMSC
Date: Mon, 17 Nov 2008 17:29:55 +0800
Message-ID: <1226914195-20473-2-git-send-email-stanley.miao@windriver.com>
References: <1226914195-20473-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56897 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbYKQJXv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2008 04:23:51 -0500
In-Reply-To: <1226914195-20473-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-omap@vger.kernel.org

Add the define of LAN9211 in chip_ids.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 drivers/net/smc911x.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
index d1b3b9b..f688b55 100644
--- a/drivers/net/smc911x.h
+++ b/drivers/net/smc911x.h
@@ -682,6 +682,7 @@ smc_pxa_dma_outsl(struct smc911x_local *lp, u_long physaddr,
 #define CHIP_9116	0x0116
 #define CHIP_9117	0x0117
 #define CHIP_9118	0x0118
+#define CHIP_9211	0x9211
 #define CHIP_9215	0x115A
 #define CHIP_9217	0x117A
 #define CHIP_9218	0x118A
@@ -696,6 +697,7 @@ static const struct chip_id chip_ids[] =  {
 	{ CHIP_9116, "LAN9116" },
 	{ CHIP_9117, "LAN9117" },
 	{ CHIP_9118, "LAN9118" },
+	{ CHIP_9211, "LAN9211" },
 	{ CHIP_9215, "LAN9215" },
 	{ CHIP_9217, "LAN9217" },
 	{ CHIP_9218, "LAN9218" },
-- 
1.5.6.3

