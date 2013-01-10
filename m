From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 3/5] staging: tidspbridge: fix uninitialized variable sym_name
Date: Thu, 10 Jan 2013 03:37:00 -0600
Message-ID: <1357810622-1709-4-git-send-email-omar.ramirez@copitl.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40669 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab3AJJhW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:22 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so339160oag.2
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:21 -0800 (PST)
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

On both counts, sym_name could be printed uninitialized, this
is solved by moving the pr_* statement to be triggered if the
value is assigned.

Reported-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/rmgr/nldr.c |    6 ++++--
 drivers/staging/tidspbridge/rmgr/node.c |   12 ++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/nldr.c b/drivers/staging/tidspbridge/rmgr/nldr.c
index 6309221..ca38050 100644
--- a/drivers/staging/tidspbridge/rmgr/nldr.c
+++ b/drivers/staging/tidspbridge/rmgr/nldr.c
@@ -1802,8 +1802,6 @@ int nldr_find_addr(struct nldr_nodeobject *nldr_node, u32 sym_addr,
 	bool status1 = false;
 	s32 i = 0;
 	struct lib_node root = { NULL, 0, NULL };
-	pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__, (u32) nldr_node,
-			sym_addr, offset_range, (u32) offset_output, sym_name);
 
 	if (nldr_node->dynamic && *nldr_node->phase_split) {
 		switch (nldr_node->phase) {
@@ -1852,6 +1850,10 @@ int nldr_find_addr(struct nldr_nodeobject *nldr_node, u32 sym_addr,
 		pr_debug("%s: Address 0x%x not found in range %d.\n",
 					__func__, sym_addr, offset_range);
 		status = -ESPIPE;
+	} else {
+		pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n",
+			 __func__, (u32) nldr_node, sym_addr, offset_range,
+			 (u32) offset_output, sym_name);
 	}
 
 	return status;
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
index 737f4a9..87dfa92 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -3012,16 +3012,16 @@ int node_find_addr(struct node_mgr *node_mgr, u32 sym_addr,
 	struct node_object *node_obj;
 	int status = -ENOENT;
 
-	pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__,
-			(unsigned int) node_mgr,
-			sym_addr, offset_range,
-			(unsigned int) sym_addr_output, sym_name);
-
 	list_for_each_entry(node_obj, &node_mgr->node_list, list_elem) {
 		status = nldr_find_addr(node_obj->nldr_node_obj, sym_addr,
 			offset_range, sym_addr_output, sym_name);
-		if (!status)
+		if (!status) {
+			pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x, %s)\n", __func__,
+				 (unsigned int) node_mgr,
+				 sym_addr, offset_range,
+				 (unsigned int) sym_addr_output, sym_name);
 			break;
+		}
 	}
 
 	return status;
-- 
1.7.4.4

