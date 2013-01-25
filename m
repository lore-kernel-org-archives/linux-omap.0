From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ARM: omap2: gpmc: Remove unneeded of_node_put()
Date: Fri, 25 Jan 2013 09:19:47 -0300
Message-ID: <1359116387-32613-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47719 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101Ab3AYMU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 07:20:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, zonque@gmail.com, tony@atomide.com, matthias.bgg@googlemail.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

for_each_node_by_name() automatically calls of_node_put() on each
node passed; so don't do it explicitly unless there's an error.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 01ce462..c6255f7 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1271,9 +1271,10 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 
 	for_each_node_by_name(child, "nand") {
 		ret = gpmc_probe_nand_child(pdev, child);
-		of_node_put(child);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(child);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
1.7.8.6

