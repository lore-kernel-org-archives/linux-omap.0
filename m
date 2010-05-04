From: Mike Chan <mike@android.com>
Subject: [PATCH 1/2] [ARM] omap-pm: resource: Lock resource list in update_resource_level
Date: Mon,  3 May 2010 17:34:30 -0700
Message-ID: <1272933271-12937-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:40755 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab0EDAeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:34:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Mike Chan <mike@android.com>

Take the resource mutex when iterating over the resource user_list.
A race can occur if resource_request() adds a first time user to
the user_list while update_resource_level() is called.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/plat-omap/resource.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index f769f7c..6d3bba6 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -106,6 +106,7 @@ static int update_resource_level(struct shared_resource *resp)
 	unsigned long target_level;
 	int ret;
 
+	mutex_lock(&resp->resource_mutex);
 	/* Regenerate the target_value for the resource */
 	if (resp->flags & RES_TYPE_PERFORMANCE) {
 		target_level = RES_PERFORMANCE_DEFAULTLEVEL;
@@ -118,9 +119,11 @@ static int update_resource_level(struct shared_resource *resp)
 			if (user->level < target_level)
 				target_level = user->level;
 	} else {
+		mutex_unlock(&resp->resource_mutex);
 		pr_debug("SRF: Unknown resource type\n");
 		return -EINVAL;
 	}
+	mutex_unlock(&resp->resource_mutex);
 
 	pr_debug("SRF: Changing Level for resource %s to %ld\n",
 				resp->name, target_level);
@@ -439,10 +442,12 @@ int resource_release(const char *name, struct device *dev)
 	list_del(&user->node);
 	free_user(user);
 
-	/* Recompute and set the current level for the resource */
-	ret = update_resource_level(resp);
 res_unlock:
 	mutex_unlock(&resp->resource_mutex);
+	/* Recompute and set the current level for the resource */
+	if (!ret)
+		ret = update_resource_level(resp);
+
 	return ret;
 }
 EXPORT_SYMBOL(resource_release);
-- 
1.7.0.1

