From: Mike Chan <mike@android.com>
Subject: [PATCH] [ARM] omap: resource: Make resource_refresh() thread safe.
Date: Thu,  3 Sep 2009 16:18:07 -0700
Message-ID: <1252019887-4463-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:46714 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbZICXSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 19:18:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Mike Chan <mike@android.com>

Need to lock the res_mutex when traversing the res_list.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/plat-omap/resource.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index 25072cd..4631912 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -234,11 +234,13 @@ int resource_refresh(void)
 	struct shared_resource *resp = NULL;
 	int ret = 0;
 
+	down(&res_mutex);
 	list_for_each_entry(resp, &res_list, node) {
 		ret = update_resource_level(resp);
 		if (ret)
 			break;
 	}
+	up(&res_mutex);
 	return ret;
 }
 
-- 
1.5.4.5

