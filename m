From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no match exists for a hwmod class
Date: Wed, 8 Aug 2012 16:05:17 +0530
Message-ID: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59269 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab2HHKfd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 06:35:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pswan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Bedia <vaibhav.bedia@ti.com>

If no match is found for a hwmod class, omap_hwmod_for_each_by_class()
currently does not spit out any error messages. To make debugging
issues related to non-existent hwmod classes simpler make this function
print an error message in case no match is found for the supplied hwmod
class.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6ca8e51..90e2306 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3480,7 +3480,8 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
  * If the callback function returns something other than
  * zero, the iterator is terminated, and the callback function's return
  * value is passed back to the caller.  Returns 0 upon success, -EINVAL
- * if @classname or @fn are NULL, or passes back the error code from @fn.
+ * if @classname or @fn are NULL or no match is found for @classname,
+ * or passes back the error code from @fn.
  */
 int omap_hwmod_for_each_by_class(const char *classname,
 				 int (*fn)(struct omap_hwmod *oh,
@@ -3489,6 +3490,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 {
 	struct omap_hwmod *temp_oh;
 	int ret = 0;
+	bool found = false;
 
 	if (!classname || !fn)
 		return -EINVAL;
@@ -3498,6 +3500,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
 
 	list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
 		if (!strcmp(temp_oh->class->name, classname)) {
+			found = true;
 			pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
 				 __func__, temp_oh->name);
 			ret = (*fn)(temp_oh, user);
@@ -3506,6 +3509,12 @@ int omap_hwmod_for_each_by_class(const char *classname,
 		}
 	}
 
+	if (!found) {
+		pr_err("omap_hwmod: %s: no match for class %s\n",
+			__func__, classname);
+		return -EINVAL;
+	}
+
 	if (ret)
 		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
 			 __func__, ret);
-- 
1.7.0.4

