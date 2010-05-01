From: virtuoso@slind.org
Subject: [PATCH 3/6] etm: do a dummy read from OSSRR during initialization
Date: Sat,  1 May 2010 20:38:18 +0300
Message-ID: <1272735501-2963-4-git-send-email-virtuoso@slind.org>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44762 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0EARlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:41:17 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

The first read from ETM OS save and restore register after the power
down bit deassertion returns garbage.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/kernel/etm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index d08062b..73b824a 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -558,7 +558,9 @@ static int __init etm_probe(struct amba_device *dev, struct amba_id *id)
 	t->etm_portsz = 1;
 
 	etm_unlock(t);
-	ret = etm_readl(t, ETMMR_PDSR);
+	(void)etm_readl(t, ETMMR_PDSR);
+	/* dummy first read */
+	(void)etm_readl(&tracer, ETMMR_OSSRR);
 
 	t->ncmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
 	etm_writel(t, 0x440, ETMR_CTRL);
-- 
1.7.1.1.g15764

