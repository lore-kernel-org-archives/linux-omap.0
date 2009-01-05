From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 10/23] OMAP2/3 clock: remove clk->owner
Date: Sun, 04 Jan 2009 19:34:53 -0700
Message-ID: <20090105023452.12661.72470.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42890 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbZAEDWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:48 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

clk->owner is always NULL, so its existence doesn't serve any useful
function other than bloating the kernel by 992 bytes.  Remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |    7 ++-----
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 80eb558..ab3d879 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -191,15 +191,14 @@ struct clk * clk_get(struct device *dev, const char *id)
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
@@ -295,8 +294,6 @@ EXPORT_SYMBOL(clk_get_rate);
 
 void clk_put(struct clk *clk)
 {
-	if (clk && !IS_ERR(clk))
-		module_put(clk->owner);
 }
 EXPORT_SYMBOL(clk_put);
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index a039832..58450a1 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -77,7 +77,6 @@ struct clk_child {
 
 struct clk {
 	struct list_head	node;
-	struct module		*owner;
 	const char		*name;
 	int			id;
 	struct clk		*parent;


