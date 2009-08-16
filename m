From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] OMAP clock: use debugfs_remove_recursive() for rewinding
Date: Sun, 16 Aug 2009 07:25:51 +0300
Message-ID: <1250396751-18725-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47123 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZHPEZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 00:25:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Rewinding each debugfs entries to unregister if an error happens.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index a8cb24a..60d70ba 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -918,7 +918,7 @@ static int __init clk_debugfs_init(void)
 	}
 	return 0;
 err_out:
-	debugfs_remove(clk_debugfs_root); /* REVISIT: Cleanup correctly */
+	debugfs_remove_recursive(clk_debugfs_root);
 	return err;
 }
 late_initcall(clk_debugfs_init);
-- 
1.6.0.4

