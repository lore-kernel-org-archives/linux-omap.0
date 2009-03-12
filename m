From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/86] [ARM] omap: remove clk->owner
Date: Thu, 12 Mar 2009 11:27:18 -0700
Message-ID: <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbZCLS3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:32 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:30 -0700 (PDT)
In-Reply-To: <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

clk->owner is always NULL, so its existence doesn't serve any useful
function other than bloating the kernel by 992 bytes.  Remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/clock.c              |    7 ++-----
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 529c4a9..c53205c 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -53,15 +53,14 @@ struct clk * clk_get(struct device *dev, const char *id)
 	mutex_lock(&clocks_mutex);
 
 	list_for_each_entry(p, &clocks, node) {
-		if (p->id == idno &&
-		    strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
+		if (p->id == idno && strcmp(id, p->name) == 0) {
 			clk = p;
 			goto found;
 		}
 	}
 
 	list_for_each_entry(p, &clocks, node) {
-		if (strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
+		if (strcmp(id, p->name) == 0) {
 			clk = p;
 			break;
 		}
@@ -148,8 +147,6 @@ EXPORT_SYMBOL(clk_get_rate);
 
 void clk_put(struct clk *clk)
 {
-	if (clk && !IS_ERR(clk))
-		module_put(clk->owner);
 }
 EXPORT_SYMBOL(clk_put);
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 40a2ac3..547619f 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -65,7 +65,6 @@ struct dpll_data {
 struct clk {
 	struct list_head	node;
 	const struct clkops	*ops;
-	struct module		*owner;
 	const char		*name;
 	int			id;
 	struct clk		*parent;
-- 
1.6.1.2

