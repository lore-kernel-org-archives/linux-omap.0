From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] OMAP2+: hwmod: Do not break iterator fn's if one fails
Date: Wed, 16 Feb 2011 17:41:25 +0530
Message-ID: <1297858285-7056-4-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
 <1297858285-7056-2-git-send-email-rnayak@ti.com>
 <1297858285-7056-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab1BPMLg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:11:36 -0500
In-Reply-To: <1297858285-7056-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

The iterator functions used to iterate over all
registered hwmods and all hwmods of a given class
break if one of the iterator functions fail.
Instead iterate over all the functions and return
an ORed return value back to the user.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 960461f..3cab82e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1568,25 +1568,21 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name)
  *
  * Call @fn for each registered omap_hwmod, passing @data to each
  * function.  @fn must return 0 for success or any other value for
- * failure.  If @fn returns non-zero, the iteration across omap_hwmods
- * will stop and the non-zero return value will be passed to the
- * caller of omap_hwmod_for_each().  @fn is called with
+ * failure. Return value of all callback functions is OR'd and the
+ * value is passed back to the caller. @fn is called with
  * omap_hwmod_for_each() held.
  */
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data)
 {
 	struct omap_hwmod *temp_oh;
-	int ret;
+	int ret = 0;
 
 	if (!fn)
 		return -EINVAL;
 
-	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
-		ret = (*fn)(temp_oh, data);
-		if (ret)
-			break;
-	}
+	list_for_each_entry(temp_oh, &omap_hwmod_list, node)
+		ret |= (*fn)(temp_oh, data);
 
 	return ret;
 }
@@ -2127,8 +2123,7 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
  * @user: arbitrary context data to pass to the callback function
  *
  * For each omap_hwmod of class @classname, call @fn.
- * If the callback function returns something other than
- * zero, the iterator is terminated, and the callback function's return
+ * Return value of all callback functions is OR'd and the
  * value is passed back to the caller.  Returns 0 upon success, -EINVAL
  * if @classname or @fn are NULL, or passes back the error code from @fn.
  */
@@ -2150,14 +2145,12 @@ int omap_hwmod_for_each_by_class(const char *classname,
 		if (!strcmp(temp_oh->class->name, classname)) {
 			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
 				 __func__, temp_oh->name);
-			ret = (*fn)(temp_oh, user);
-			if (ret)
-				break;
+			ret |= (*fn)(temp_oh, user);
 		}
 	}
 
 	if (ret)
-		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
+		pr_debug("omap_hwmod: %s: one or more callback fn failed: %d\n",
 			 __func__, ret);
 
 	return ret;
-- 
1.7.0.4

