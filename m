From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap1: mbox: delete unused variable
Date: Thu, 18 Nov 2010 19:59:49 +0200
Message-ID: <1290103191-360-5-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:44783 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759937Ab0KRR7u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 12:59:50 -0500
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Delete unused variable from probe().

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 12d6880..c0e1f48 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -145,7 +145,6 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int ret;
-	int i;
 	struct omap_mbox **list;
 
 	list = omap1_mboxes;
-- 
1.5.6.5

