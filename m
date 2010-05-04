From: Mike Chan <mike@android.com>
Subject: [PATCH] [ARM] omap-pm: resource: Protect static pool from concurrent get_user() calls
Date: Mon,  3 May 2010 17:14:45 -0700
Message-ID: <1272932085-5664-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:45554 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab0EDAOv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:14:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, Mike Chan <mike@android.com>

With per-resource mutexes, mulitple threads can call resource_request()
which can cause get_user() to concurrently allocate from the static pool.
Take the res_mutex when allocating from the static pool, which is used
in resouce_request() and resource_release() to guard against this.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/plat-omap/resource.c |   55 +++++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/resource.c b/arch/arm/plat-omap/resource.c
index 0a7b79b..f769f7c 100644
--- a/arch/arm/plat-omap/resource.c
+++ b/arch/arm/plat-omap/resource.c
@@ -148,34 +148,39 @@ static struct users_list *get_user(void)
 	int ind = 0;
 	struct users_list *user;
 
+	/*
+	 * When allocating from the static pool, we must lock resource mutex,
+	 * to protect against concurrent get_user() calls.
+	 */
+	down(&res_mutex);
 	/* See if something available in the static pool */
 	while (ind < MAX_USERS) {
-		if (usr_list[ind].usage == UNUSED)
-			break;
-		else
-			ind++;
+		if (usr_list[ind].usage == UNUSED) {
+			/* Pick from the static pool */
+			user = &usr_list[ind];
+			user->usage = STATIC_ALLOC;
+			up(&res_mutex);
+			return user;
+		}
+		ind++;
 	}
-	if (ind < MAX_USERS) {
-		/* Pick from the static pool */
-		user = &usr_list[ind];
-		user->usage = STATIC_ALLOC;
-	} else {
-		/* By this time we hope slab is initialized */
-		if (slab_is_available()) {
-			user = kmalloc(sizeof(struct  users_list), GFP_KERNEL);
-			if (!user) {
-				printk(KERN_ERR "SRF:FATAL ERROR: kmalloc"
-							"failed\n");
-				return ERR_PTR(-ENOMEM);
-			}
-			user->usage = DYNAMIC_ALLOC;
-		} else {
-			/* Dynamic alloc not available yet */
-			printk(KERN_ERR "SRF: FATAL ERROR: users_list"
-				"initial POOL EMPTY before slab init\n");
+	up(&res_mutex);
+	/* By this time we hope slab is initialized */
+	if (slab_is_available()) {
+		user = kmalloc(sizeof(struct  users_list), GFP_KERNEL);
+		if (!user) {
+			printk(KERN_ERR "SRF:FATAL ERROR: kmalloc"
+					"failed\n");
 			return ERR_PTR(-ENOMEM);
 		}
+		user->usage = DYNAMIC_ALLOC;
+	} else {
+		/* Dynamic alloc not available yet */
+		printk(KERN_ERR "SRF: FATAL ERROR: users_list"
+				"initial POOL EMPTY before slab init\n");
+		return ERR_PTR(-ENOMEM);
 	}
+
 	return user;
 }
 
@@ -192,8 +197,12 @@ void free_user(struct users_list *user)
 	if (user->usage == DYNAMIC_ALLOC) {
 		kfree(user);
 	} else {
-		user->usage = UNUSED;
+		/*
+		 * It is not necesssary to lock when returning to the
+		 * static pool.
+		 */
 		user->dev = NULL;
+		user->usage = UNUSED;
 	}
 }
 
-- 
1.7.0.1

