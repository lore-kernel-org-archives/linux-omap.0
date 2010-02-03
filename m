From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/9] omap: Fix access to already released memory in
	clk_debugfs_register_one()
Date: Tue, 02 Feb 2010 18:26:16 -0800
Message-ID: <20100203022616.26347.80630.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61613 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:48 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Marek Skuczynski <mareksk7@gmail.com>

From: Marek Skuczynski <mareksk7@gmail.com>

I have found an access to already released memory in
clk_debugfs_register_one() function.

Signed-off-by: Marek Skuczynski <mareksk7@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d9f8c84..4becbdd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -391,7 +391,7 @@ static struct dentry *clk_debugfs_root;
 static int clk_debugfs_register_one(struct clk *c)
 {
 	int err;
-	struct dentry *d, *child;
+	struct dentry *d, *child, *child_tmp;
 	struct clk *pa = c->parent;
 	char s[255];
 	char *p = s;
@@ -423,7 +423,7 @@ static int clk_debugfs_register_one(struct clk *c)
 
 err_out:
 	d = c->dent;
-	list_for_each_entry(child, &d->d_subdirs, d_u.d_child)
+	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
 		debugfs_remove(child);
 	debugfs_remove(c->dent);
 	return err;

