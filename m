From: Mike Chan <mike@android.com>
Subject: [PATCH 2/2] [ARM] omap-pm: resource: Only update resource level if there is a change
Date: Mon,  3 May 2010 17:34:31 -0700
Message-ID: <1272933271-12937-2-git-send-email-mike@android.com>
References: <1272933271-12937-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:40762 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab0EDAeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:34:36 -0400
In-Reply-To: <1272933271-12937-1-git-send-email-mike@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Mike Chan <mike@android.com>

Previosuly update_resource_level() would always call the change_level()
function, even if there was no change necessary.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/plat-omap/resource.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index 6d3bba6..ff5a938 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -104,7 +104,7 @@ static int update_resource_level(struct shared_resource *resp)
 {
 	struct users_list *user;
 	unsigned long target_level;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&resp->resource_mutex);
 	/* Regenerate the target_value for the resource */
@@ -125,6 +125,9 @@ static int update_resource_level(struct shared_resource *resp)
 	}
 	mutex_unlock(&resp->resource_mutex);
 
+	if (resp->curr_level == target_level)
+		return ret;
+
 	pr_debug("SRF: Changing Level for resource %s to %ld\n",
 				resp->name, target_level);
 	ret = resp->ops->change_level(resp, target_level);
-- 
1.7.0.1

