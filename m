From: Mike Chan <mike@android.com>
Subject: [PATCH] omap: resource: Fix race in register_resource()
Date: Thu,  3 Sep 2009 12:37:18 -0700
Message-ID: <1252006638-1697-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:48953 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbZICThU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 15:37:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Mike Chan <mike@android.com>

Checking if the resource is already registered and adding to the list
must be atomic or bad things can happen.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/plat-omap/resource.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index e9ace13..9d20249 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -253,6 +253,7 @@ int resource_refresh(void)
  */
 int resource_register(struct shared_resource *resp)
 {
+	int ret = 0;
 	if (!resp)
 		return -EINVAL;
 
@@ -260,13 +261,15 @@ int resource_register(struct shared_resource *resp)
 		return -EINVAL;
 
 	/* Verify that the resource is not already registered */
-	if (resource_lookup(resp->name))
-		return -EEXIST;
+	down(&res_mutex);
+	if (_resource_lookup(resp->name)) {
+		ret = -EEXIST;
+		goto out;
+	}
 
 	INIT_LIST_HEAD(&resp->users_list);
 	mutex_init(&resp->resource_mutex);
 
-	down(&res_mutex);
 	/* Add the resource to the resource list */
 	list_add(&resp->node, &res_list);
 
@@ -274,10 +277,11 @@ int resource_register(struct shared_resource *resp)
 	if (resp->ops->init)
 		resp->ops->init(resp);
 
-	up(&res_mutex);
 	pr_debug("resource: registered %s\n", resp->name);
 
-	return 0;
+out:
+	up(&res_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(resource_register);
 
-- 
1.5.4.5

